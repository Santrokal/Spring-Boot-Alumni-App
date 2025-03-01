package com.shc.alumni.springboot.controller;


import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.itextpdf.io.exceptions.IOException;
import com.shc.alumni.springboot.entity.ContactEntity;
import com.shc.alumni.springboot.repository.ContactRepository;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

import java.util.List;

@Controller
public class AdminContactController {
	
	@Autowired
    private ContactRepository contactRepository;
	@Autowired
    private JavaMailSender javaMailSender;
	
	@GetMapping("/admin/messages")
    public String showMessages(Model model) {
        // Fetch all messages that are not skipped
        List<ContactEntity> messages = contactRepository.findBySkippedFalse();
        model.addAttribute("messages", messages);
        return "adminmessages"; // JSP page to display messages
    }
	@PostMapping("/admin/respond")
    public String respondToMessage(
            @RequestParam Long id,
            @RequestParam String response,
            @RequestParam("file") MultipartFile file) { // Handle file upload
        ContactEntity message = contactRepository.findById(id).orElse(null);
        if (message != null) {
            try {
                // Send response to the user's email address with file attachment
                sendEmailWithAttachment(
                    message.getEmailAddress(),
                    "Response to Your Message",
                    response,
                    file
                );

                // Mark the message as skipped
                message.setSkipped(true);
                contactRepository.save(message);
            } catch (MessagingException | IOException e) {
                System.err.println("Failed to send email with attachment: " + e.getMessage());
            }
        }
        return "adminmessages"; // Redirect back to the messages page
    }

    // Method to send email with attachment
    private void sendEmailWithAttachment(
            String toEmail, String subject, String text, MultipartFile file)
            throws MessagingException, IOException {
        MimeMessage mimeMessage = javaMailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);

        helper.setTo(toEmail); // Recipient's email address
        helper.setSubject(subject); // Email subject
        helper.setText(text); // Email body

        // Attach the file
        if (file != null && !file.isEmpty()) {
            helper.addAttachment(file.getOriginalFilename(), file);
        }

        javaMailSender.send(mimeMessage); // Send the email
        System.out.println("Email with attachment sent to: " + toEmail);
    }


    // Admin skips a message
    @PostMapping("/admin/skip")
    public String skipMessage(@RequestParam Long id) {
        ContactEntity message = contactRepository.findById(id).orElse(null);
        if (message != null) {
            // Mark the message as skipped
            message.setSkipped(true);
            contactRepository.save(message);
        }
        return "adminmessages"; // Redirect back to the messages page
    }

}
