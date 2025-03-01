package com.shc.alumni.springboot.service;

import com.razorpay.Order;
import com.razorpay.Payment;
import com.razorpay.RazorpayClient;
import com.razorpay.RazorpayException;
import com.shc.alumni.springboot.entity.MembershipEntity;
import com.shc.alumni.springboot.repository.MembershipRepository;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.time.Year;
import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

@Service
public class MembershipService {

    @Autowired
    private MembershipRepository membershipRepository;

    @Value("${razorpay.key_id}")
    private String razorpayKeyId;

    @Value("${razorpay.secret_key}")
    private String razorpaySecretKey;

    private RazorpayClient razorpayClient;

    /**
     * Initialize Razorpay Client
     */
    public RazorpayClient getRazorpayClient() throws RazorpayException {
        if (razorpayClient == null) {
            razorpayClient = new RazorpayClient(razorpayKeyId, razorpaySecretKey);
        }
        return razorpayClient;
    }

    /**
     * Generate a member ID in format: YYYY_FULLNAME
     */
    public String generateMemberId(String fullName) {
        String year = String.valueOf(Year.now().getValue());
        String namePart = fullName.replaceAll("\\s+", "_").toUpperCase();
        return year + "_" + namePart;
    }

    /**
     * Initiate a Razorpay test mode payment
     */
    public String initiatePayment(int amount) throws RazorpayException {
        RazorpayClient razorpayClient = getRazorpayClient();

        JSONObject orderRequest = new JSONObject();
        orderRequest.put("amount", amount * 100); // Convert to paise
        orderRequest.put("currency", "INR");
        orderRequest.put("receipt", "txn_" + UUID.randomUUID().toString());

        Order order = razorpayClient.Orders.create(orderRequest);
        return order.get("id");
    }

    /**
     * Save membership details after successful payment
     */
    public MembershipEntity saveMembershipDetails(String fullName, String emailAddress, String paymentId, String memberId) {
        MembershipEntity membership = new MembershipEntity();
        membership.setMember_id(memberId);
        membership.setPaymentId(paymentId);
        membership.setEmailaddress(emailAddress);
        membership.setFullname(fullName);
        membership.setCreatedAt(LocalDateTime.now());

        return membershipRepository.save(membership);
    }

    /**
     * Fetch membership by payment ID
     */
    public Optional<MembershipEntity> getMembershipByPaymentId(String paymentId) {
        return membershipRepository.findByPaymentId(paymentId);
    }

    /**
     * Verify payment status in test mode
     */
    public boolean verifyPayment(String paymentId) {
        try {
            RazorpayClient razorpay = getRazorpayClient();
            Payment payment = razorpay.Payments.fetch(paymentId);
            
            String status = payment.get("status");
            return "captured".equalsIgnoreCase(status) || "authorized".equalsIgnoreCase(status); // Allow 'authorized' in test mode
        } catch (Exception e) {
            return false;
        }
    }

    public boolean capturePayment(String paymentId, int amount) {
        try {
            RazorpayClient razorpay = getRazorpayClient();
            JSONObject captureRequest = new JSONObject();
            captureRequest.put("amount", amount * 100); // Amount in paise
            captureRequest.put("currency", "INR");

            Payment payment = razorpay.Payments.capture(paymentId, captureRequest);
            return "captured".equalsIgnoreCase(payment.get("status"));
        } catch (Exception e) {
            return false;
        }
    }


}
