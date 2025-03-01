package com.shc.alumni.springboot.controller;

import com.shc.alumni.springboot.entity.BillPdfEntity;
import com.shc.alumni.springboot.entity.MembershipEntity;
import com.shc.alumni.springboot.repository.BillPdfRepository;
import com.shc.alumni.springboot.repository.MembershipRepository;
import com.shc.alumni.springboot.service.BillingService;
import com.shc.alumni.springboot.service.MembershipService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Controller
public class MembershipController {

    private static final Logger logger = LoggerFactory.getLogger(MembershipController.class);

    @Autowired
    private MembershipService membershipService;

    private final BillingService billingService;

    @Autowired
    public MembershipController(BillingService billingService) {
        this.billingService = billingService;
    }

    @Autowired
    private MembershipRepository membershipRepository;

    @Autowired
    private BillPdfRepository billPdfRepository;

    /**
     * Display the membership page.
     */
    @GetMapping("/membership")
    public String showMembershipPage() {
        return "membershipFlow";
    }

    /**
     * Handle membership creation and initiate Razorpay payment.
     */
    @PostMapping("/createMembership")
    public String createMembership(
            @RequestParam String fullName,
            @RequestParam String emailAddress,
            Model model) {
        try {
            // Generate a unique member ID
            String memberId = membershipService.generateMemberId(fullName);
            if (memberId == null || memberId.isEmpty()) {
                model.addAttribute("errorMessage", "Failed to generate Member ID.");
                return "membershipFlow";
            }

            // Initiate Razorpay payment (amount is in rupees)
            String orderId = membershipService.initiatePayment(1500);

            // Pass payment details to the Razorpay checkout page
            model.addAttribute("orderId", orderId);
            model.addAttribute("amount", 1500); // Amount in rupees
            model.addAttribute("fullName", fullName);
            model.addAttribute("emailAddress", emailAddress);

            return "razorpayCheckout"; // Razorpay payment integration page
        } catch (Exception e) {
            logger.error("Error during membership creation: ", e);
            model.addAttribute("errorMessage", "Error during membership creation: " + e.getMessage());
            return "membershipFlow"; // Redirect back to the membership form
        }
    }

    /**
     * Handle payment success callback from Razorpay.
     */
    @PostMapping("/paymentSuccess")
    public String paymentSuccess(
            @RequestParam(required = false) String paymentId, 
            @RequestParam(required = false) String fullName, 
            @RequestParam(required = false) String emailAddress, 
            Model model) {

        try {
            logger.info("Received payment callback - Payment ID: {}, Full Name: {}, Email: {}", paymentId, fullName, emailAddress);

            // ✅ Validate Payment ID
            if (paymentId == null || paymentId.trim().isEmpty()) {
                logger.error("Payment ID is missing or invalid.");
                model.addAttribute("errorMessage", "Payment ID is invalid. Please try again.");
                return "razorpayCheckout";
            }

            // ✅ Validate Full Name & Email Address
            if (fullName == null || fullName.trim().isEmpty() || emailAddress == null || emailAddress.trim().isEmpty()) {
                logger.error("Full Name or Email Address is missing.");
                model.addAttribute("errorMessage", "Invalid user details. Please try again.");
                return "razorpayCheckout";
            }

            int amount = 1500; // Amount in INR (adjust as needed)

            // ✅ Capture Payment
            boolean isCaptured = membershipService.capturePayment(paymentId, amount);
            if (!isCaptured) {
                logger.error("Payment capture failed for Payment ID: {}", paymentId);
                model.addAttribute("errorMessage", "Payment capture failed. Please contact support.");
                return "razorpayCheckout";
            }

            // ✅ Verify Payment (Optional but recommended)
            boolean isPaymentValid = membershipService.verifyPayment(paymentId);
            if (!isPaymentValid) {
                logger.error("Payment verification failed for Payment ID: {}", paymentId);
                model.addAttribute("errorMessage", "Payment verification failed. Please contact support.");
                return "razorpayCheckout";
            }

            // ✅ Generate Member ID
            String memberId = membershipService.generateMemberId(fullName);
            if (memberId == null || memberId.isEmpty()) {
                logger.error("Failed to generate Member ID.");
                model.addAttribute("errorMessage", "Error generating membership ID. Please try again.");
                return "razorpayCheckout";
            }
            logger.info("Generated Member ID: {}", memberId);

            // ✅ Save Membership Details
            MembershipEntity membership = new MembershipEntity();
            membership.setMember_id(memberId);
            membership.setPaymentId(paymentId);
            membership.setEmailaddress(emailAddress);
            membership.setFullname(fullName);
            membership.setCreatedAt(LocalDateTime.now());

            membershipRepository.save(membership);
            logger.info("Membership details saved successfully for Member ID: {}", memberId);

            // ✅ Generate Bill PDF
            byte[] billPdf = billingService.generateBillPdf(memberId, fullName, emailAddress, paymentId);
            if (billPdf == null || billPdf.length == 0) {
                logger.error("Failed to generate Bill PDF.");
                model.addAttribute("errorMessage", "Error generating the bill PDF.");
                return "razorpayCheckout";
            }

            // ✅ Save PDF to Disk
            String directoryPath = "membership";
            Path path = Paths.get(directoryPath);
            if (!Files.exists(path)) {
                Files.createDirectories(path);
            }

            String filePath = directoryPath + "/" + memberId + "_bill.pdf";
            try (FileOutputStream fos = new FileOutputStream(filePath)) {
                fos.write(billPdf);
            }
            logger.info("Bill PDF saved to disk: {}", filePath);

            // ✅ Save Bill PDF to Database
            BillPdfEntity billPdfEntity = new BillPdfEntity();
            billPdfEntity.setId(UUID.randomUUID().toString());
            billPdfEntity.setMemberId(memberId);
            billPdfEntity.setFullName(fullName);
            billPdfEntity.setEmail(emailAddress);
            billPdfEntity.setPaymentId(paymentId);
            billPdfEntity.setStatus("PAID");
            billPdfEntity.setPdfData(billPdf);
            billPdfEntity.setDate(new Date(System.currentTimeMillis()));

            billPdfRepository.save(billPdfEntity);
            logger.info("Bill PDF stored in database successfully for Member ID: {}", memberId);

            // ✅ Redirect to Success Page
            return "redirect:/success";
        } catch (Exception e) {
            logger.error("Payment processing error: ", e);
            model.addAttribute("errorMessage", "Payment processing failed. Please try again.");
            return "razorpayCheckout";
        }
    }



    /**
     * Verify if a membership exists for the given email address.
     */
    @PostMapping("/verifyMembership")
    public String verifyMembership(@RequestParam String emailAddress, Model model) {
        try {
            // Check if a membership exists with the given email address
            Optional<MembershipEntity> membership = membershipRepository.findByEmailaddress(emailAddress);

            if (membership.isPresent()) {
                // Membership found, retrieve details and pass them to the model
                MembershipEntity member = membership.get();
                model.addAttribute("message", "Membership found!");
                model.addAttribute("fullName", member.getFullname());
                model.addAttribute("memberId", member.getMember_id());
                model.addAttribute("emailAddress", member.getEmailaddress());
                model.addAttribute("createdAt", member.getCreatedAt());

                return "membershipDetails"; // A view to show membership details
            } else {
                model.addAttribute("errorMessage", "No membership found for the given email address.");
                return "membershipFlow"; // Redirect back to the membership form
            }
        } catch (Exception e) {
            logger.error("Error during membership verification: ", e);
            model.addAttribute("errorMessage", "Error during membership verification.");
            return "membershipFlow";
        }
    }
    
 // ✅ Fetch all membership details and display on JSP
    @GetMapping("/membership-details")
    public String showMembershipDetails(HttpServletRequest request, Model model) {
        List<BillPdfEntity> bills = billPdfRepository.findAll();
        
        System.out.println("✅ Found " + bills.size() + " membership records.");
        
        for (BillPdfEntity bill : bills) {
            System.out.println("📝 Member ID: " + bill.getMemberId() + ", Status: " + bill.getStatus());
        }

        request.setAttribute("bills", bills);  // ✅ Add to request scope for JSP
        model.addAttribute("bills", bills);    // ✅ Add to model (optional)

        return "membershipDetails"; // Ensure this matches the JSP filename
    }



    // ✅ Serve the PDF for download
    @GetMapping("/download-bill/{id}")
    public void downloadBill(@PathVariable String id, HttpServletResponse response) throws IOException {
        BillPdfEntity bill = billPdfRepository.findById(id).orElse(null);
        if (bill != null && bill.getPdfData() != null) {
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=" + bill.getMemberId() + "_bill.pdf");
            response.getOutputStream().write(bill.getPdfData());
            response.getOutputStream().flush();
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Bill not found");
        }
    }
    
}
