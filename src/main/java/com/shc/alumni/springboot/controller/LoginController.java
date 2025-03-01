package com.shc.alumni.springboot.controller;

import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.shc.alumni.springboot.entity.AdminEntity;
import com.shc.alumni.springboot.entity.AlumniRegisterEntity;
import com.shc.alumni.springboot.repository.AdminRepository;
import com.shc.alumni.springboot.service.AlumniRegisterService;

import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {

    @Autowired
    private AlumniRegisterService alumniRegisterService;

    @Autowired
    private AdminRepository adminRepository;
    
    
    @GetMapping("/alumni")
    public String showAddUserForm() {
        return "alumnilogin"; // Points to adminregister.jsp
    }

    @PostMapping("/alumni")
    public ResponseEntity<?> login(@RequestBody Map<String, String> payload, HttpSession session) {
        System.out.println("Payload received: " + payload);

        String role = payload.get("role");
        String emailAddress = payload.get("emailAddress");
        System.out.println("Role: " + role + ", Email: " + emailAddress);

        try {
            if ("admin".equalsIgnoreCase(role)) {
                // Admin Login (Validates Email & Password)
                String password = payload.get("password");
                AdminEntity adminEntity = adminRepository.findByEmailAddress(emailAddress).orElse(null);

                if (adminEntity != null && password.equals(adminEntity.getPassword())) {
                    // Store Admin in session
                    session.setAttribute("loggedInUser", adminEntity);
                    session.setAttribute("role", "admin");
                    System.out.println("Admin login successful for: " + emailAddress);
                    
                    return ResponseEntity.ok(Map.of("success", true, "message", "Admin login successful", "redirectUrl", "/admin/adminhome"));
                } else {
                    System.out.println("Invalid admin credentials for: " + emailAddress);
                    return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Map.of("success", false, "message", "Invalid admin credentials"));
                }

            } else if ("alumni".equalsIgnoreCase(role)) {
                // Alumni Login (Validates Email & Date of Birth)
                String dob = payload.get("dob");
                
                if (emailAddress == null || emailAddress.isEmpty() || dob == null || dob.isEmpty()) {
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                            .body(Map.of("success", false, "message", "Email and DOB are required"));
                }

                try {
                    LocalDate parsedDob = LocalDate.parse(dob);
                    AlumniRegisterEntity alumni = alumniRegisterService.findByEmailaddressAndDob(emailAddress, parsedDob);

                    if (alumni != null) {
                        // ✅ Store alumni in session
                        session.setAttribute("loggedInUser", alumni);
                        session.setAttribute("loggedInEmail", emailAddress); // Storing email separately for easy access
                        session.setAttribute("role", "alumni");
                        
                        System.out.println("Alumni login successful for: " + emailAddress);
                        return ResponseEntity.ok(Map.of("success", true, "message", "Alumni login successful", "redirectUrl", "/home"));
                    } else {
                        System.out.println("Invalid alumni credentials for: " + emailAddress);
                        return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                                .body(Map.of("success", false, "message", "Invalid email or date of birth"));
                    }
                } catch (DateTimeParseException e) {
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                            .body(Map.of("success", false, "message", "Invalid date format. Use YYYY-MM-DD"));
                }
            }
 else {
                System.out.println("Invalid role selection: " + role);
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of("success", false, "message", "Invalid role selected"));
            }

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of("success", false, "message", "An error occurred: " + e.getMessage()));
        }
    }
}
