package com.shc.alumni.springboot.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
//import java.util.Optional;
import java.util.stream.Collectors;
import java.util.Base64;
import java.util.Collections;


import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import jakarta.servlet.http.HttpSession;
import java.net.MalformedURLException;
import java.nio.file.*;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;


import com.shc.alumni.springboot.entity.AlumniRegisterEntity;
import com.shc.alumni.springboot.entity.CompanyEntity;
import com.shc.alumni.springboot.entity.News;
import com.shc.alumni.springboot.service.AlumniRegisterService;
import com.shc.alumni.springboot.service.CompanyService;
//import com.shc.alumni.springboot.service.MembershipService;
import com.shc.alumni.springboot.service.NewsService;


//@RestController
@Controller
@RequestMapping("/")
public class AlumniRegisterController {

    @Autowired
    private AlumniRegisterService alumniRegisterService;
    private static final String UPLOAD_DIR = "photograph/";
    
    

    @Autowired
    private NewsService newsService;
    
    @Autowired
    private CompanyService companyService;

    
    @GetMapping("/profile")
    public String getProfile(Model model, HttpSession session) {
        // Retrieve logged-in user details from session
        String emailaddress = (String) session.getAttribute("loggedInEmail");
        String role = (String) session.getAttribute("role"); // Check if it's an admin or alumni

        if (emailaddress == null) {
            return "redirect:/alumni"; // Redirect to login page if no user is logged in
        }

        if ("admin".equalsIgnoreCase(role)) {
            return "redirect:/admin/profile"; // Redirect to admin profile if logged in as admin
        }

        // Fetch alumni details using stored email
        AlumniRegisterEntity alumni = alumniRegisterService.findByEmail(emailaddress);

        if (alumni != null) {
            // Set image path
            String profileImagePath = "/profile/image/" + alumni.getEmailaddress();
            System.out.println("Image Path: " + alumni.getFilePath());

            // Add alumni details to the model
            model.addAttribute("fullname", alumni.getFullname());
            model.addAttribute("fathersname", alumni.getFathersname());
            model.addAttribute("nationality", alumni.getNationality());
            model.addAttribute("dob", alumni.getDob());
            model.addAttribute("gender", alumni.getGender());
            model.addAttribute("house_flat_number", alumni.getHouse_flat_number());
            model.addAttribute("street_name", alumni.getStreet_name());
            model.addAttribute("city", alumni.getCity());
            model.addAttribute("state", alumni.getState());
            model.addAttribute("postal_code", alumni.getPostal_code());
            model.addAttribute("landmark", alumni.getLandmark());
            model.addAttribute("area", alumni.getArea());
            model.addAttribute("address_type", alumni.getAddress_type());
            model.addAttribute("shift", alumni.getShift());
            model.addAttribute("department", alumni.getDepartment());
            model.addAttribute("degree_obtained", alumni.getDegree_obtained());
            model.addAttribute("shc_stay_from", alumni.getShcStayFrom());
            model.addAttribute("shc_stay_to", alumni.getShcStayTo());
            model.addAttribute("marital_status", alumni.getMarital_status());
            model.addAttribute("anniversary_year", alumni.getAnniversary_year());
            model.addAttribute("whatsappno", alumni.getWhatsappno());
            model.addAttribute("phoneno", alumni.getPhoneno());
            model.addAttribute("emailaddress", alumni.getEmailaddress());
            model.addAttribute("empstatus", alumni.getEmpstatus());
            model.addAttribute("jobdesig", alumni.getJobdesig());
            model.addAttribute("officephoneno", alumni.getOfficephoneno());
            model.addAttribute("officeemail", alumni.getOfficeemail());
            model.addAttribute("fieldofexpert", alumni.getFieldofexpert());
            model.addAttribute("image", profileImagePath);

            return "profile"; // Render profile.jsp
        }

        return "redirect:/alumni"; // Redirect to login if alumni not found
    }


    
    @GetMapping("/profile/image/{emailaddress}")
    public ResponseEntity<Resource> getProfileImage(@PathVariable String emailaddress) {
        AlumniRegisterEntity alumni = alumniRegisterService.findByEmail(emailaddress);
        if (alumni == null || alumni.getFilePath() == null) {
            System.out.println("Image not found for: " + emailaddress);
            return ResponseEntity.notFound().build();
        }

        try {
            Path filePath = Paths.get(alumni.getFilePath());

            // Check if file exists
            if (!Files.exists(filePath) || !Files.isReadable(filePath)) {
                System.out.println("File does not exist or is not readable: " + filePath);
                return ResponseEntity.notFound().build();
            }

            Resource resource = new UrlResource(filePath.toUri());

            return ResponseEntity.ok()
                    .contentType(MediaType.IMAGE_JPEG)
                    .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + filePath.getFileName() + "\"")
                    .body(resource);
        } catch (MalformedURLException e) {
            System.out.println("Malformed URL Error: " + e.getMessage());
            return ResponseEntity.badRequest().build();
        }
    }

   
    @PostMapping("/updateprofile")
    public String updateProfile(
        @RequestParam("fullname") String fullname,
        @RequestParam("fathersname") String fathersname,
        @RequestParam("nationality") String nationality,
        @RequestParam("dob") String dob,
        @RequestParam("gender") String gender,
        @RequestParam("house_flat_number") String house_flat_number,
        @RequestParam("street_name") String street_name,
        @RequestParam("city") String city,
        @RequestParam("state") String state,
        @RequestParam("postal_code") String postal_code,
        @RequestParam("landmark") String landmark,
        @RequestParam("area") String area,
        @RequestParam("address_type") String address_type,
        @RequestParam("shift") String shift,
        @RequestParam("department") String department,
        @RequestParam("degree_obtained") String degree_obtained,
        @RequestParam("shc_stay_from") String shc_stay_from,
        @RequestParam("shc_stay_to") String shc_stay_to,
        @RequestParam("phoneno") String phoneno,
        @RequestParam("whatsappno") String whatsappno,
        @RequestParam("marital_status") String marital_status,
        @RequestParam(value = "anniversary_year", required = false) String anniversary_year,
        @RequestParam("emailaddress") String emailaddress,
        @RequestParam("empstatus") String empstatus,
        @RequestParam("jobdesig") String jobdesig,
        @RequestParam("officephoneno") String officephoneno,
        @RequestParam("officeemail") String officeemail,
        @RequestParam("fieldofexpert") String fieldofexpert,
        @RequestParam(value = "profileImage", required = false) MultipartFile profileImage,
        HttpSession session
    ) {
        // Retrieve the logged-in user's email from the session
        String loggedInEmail = (String) session.getAttribute("loggedInEmail");

        if (loggedInEmail == null || !loggedInEmail.equals(emailaddress)) {
            return "redirect:/"; // Redirect to login if session is invalid
        }

        AlumniRegisterEntity alumni = alumniRegisterService.findByEmail(loggedInEmail);
        if (alumni == null) {
            return "redirect:/"; // Redirect to login if no alumni record is found
        }

        try {
            // Update alumni personal information
            alumni.setFullname(fullname);
            alumni.setFathersname(fathersname);
            alumni.setNationality(nationality);
            alumni.setDob(LocalDate.parse(dob));
            alumni.setGender(gender);
            alumni.setHouse_flat_number(house_flat_number);
            alumni.setStreet_name(street_name);
            alumni.setCity(city);
            alumni.setState(state);
            alumni.setPostal_code(postal_code);
            alumni.setLandmark(landmark);
            alumni.setArea(area);
            alumni.setAddress_type(address_type);
            alumni.setShift(shift);
            alumni.setDepartment(department);
            alumni.setDegree_obtained(degree_obtained);
            alumni.setShcStayFrom(shc_stay_from);
            alumni.setShcStayTo(shc_stay_to);
            alumni.setPhoneno(phoneno);
            alumni.setWhatsappno(whatsappno);
            alumni.setMarital_status(marital_status);
            if (anniversary_year != null && !anniversary_year.isEmpty()) {
                alumni.setAnniversary_year(LocalDate.parse(anniversary_year));
            }
           

            // Update alumni work information
            alumni.setEmpstatus(empstatus);
            alumni.setJobdesig(jobdesig);
            alumni.setOfficephoneno(officephoneno);
            alumni.setOfficeemail(officeemail);
            alumni.setFieldofexpert(fieldofexpert);

            
            System.out.println("Received update profile request");

            
            if (profileImage != null && !profileImage.isEmpty()) {
                String fileName = fullname + "_" + profileImage.getOriginalFilename();
                Path uploadPath = Paths.get(UPLOAD_DIR);

                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                }

                Path filePath = uploadPath.resolve(fileName);
                Files.copy(profileImage.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
                alumni.setFilePath(filePath.toString());
            }


            // Save the updated alumni details
            alumniRegisterService.saveAlumni(alumni);

            return "redirect:/profile"; // Redirect to the updated profile page
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/profile?error=An error occurred while updating the profile.";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // Completely clear session
        
        // Redirect based on user type
        return "redirect:/alumni"; // Change if needed
    }


    



    // Show the alumni registration form
    @GetMapping("/register")
    public String showRegistrationForm() {
        return "alumniregister"; // Returns alumniregister.jsp
    }
    
    // Show the alumni registration form

    
    @GetMapping("/about")
    public String showaboutForm() {
        return "aboutus"; // Returns .jsp
    }

    
    @GetMapping("/editprofile")
    public String editProfile(Map<String, Object> model, HttpSession session) {
        // Retrieve the logged-in user's email from the session
        String loggedInEmail = (String) session.getAttribute("loggedInEmail");

        if (loggedInEmail == null) {
            // Redirect to login if the user is not logged in
            return "redirect:/alumni";
        }

        // Retrieve the alumni details using the email
        AlumniRegisterEntity alumni = alumniRegisterService.findByEmail(loggedInEmail);

        if (alumni == null) {
            // Redirect to login if no alumni record is found for the email
            return "redirect:/alumni";
        }

        // Add alumni details to the model for rendering on the edit profile page
        model.put("alumni", alumni);

        // Return the name of the JSP page for editing the profile
        return "editprofile";
    }



    @GetMapping("/home")
    public String showHomePage(Model model) {
        // Fetch all news records
        List<News> allNews = newsService.findAll();
        List<CompanyEntity> allCarrers = companyService.findAll();

        // Sort the news in descending order by creation date
        allNews.sort((news1, news2) -> news2.getCreatedAt().compareTo(news1.getCreatedAt()));
        allCarrers.sort((company1, company2) -> company2.getCreatedAt().compareTo(company2.getCreatedAt()));

        // Convert news entities to include Base64-encoded images
        List<News> newsListWithBase64 = allNews.stream()
            .map(news -> {
                if (news.getImage() != null) {
                    String base64Image = Base64.getEncoder().encodeToString(news.getImage());
                    news.setImageBase64(base64Image);
                }
                return news;
            })
            .collect(Collectors.toList());

        // Add the sorted list of news to the model
        model.addAttribute("newsList", newsListWithBase64);
        
        List<CompanyEntity> companiesListWithBase64 = allCarrers.stream()
                .map(companies -> {
                    if (companies.getImage() != null) {
                        String base64Image = Base64.getEncoder().encodeToString(companies.getImage());
                        companies.setImageBase64(base64Image);
                    }
                    return companies;
                })
                .collect(Collectors.toList());

            // Add the sorted list of news to the model
            model.addAttribute("companiesList", companiesListWithBase64);

        return "alumnihome"; // Render alumnihome.jsp
    }
    
    @GetMapping("/expandstory")
    public String showexpandpage() {
        return "storyexpand"; // Returns alumnilogin.jsp
    }

    @PostMapping("/register")
    public ResponseEntity<?> saveAlumni(
            @RequestParam("fullname") String fullname,
            @RequestParam("fathersname") String fathersname,
            @RequestParam("nationality") String nationality,
            @RequestParam("dob") String dob,
            @RequestParam("gender") String gender,
            @RequestParam("house_flat_number") String house_flat_number,
            @RequestParam("street_name") String street_name,
            @RequestParam("city") String city,
            @RequestParam("state") String state,
            @RequestParam("postal_code") String postal_code,
            @RequestParam("landmark") String landmark,
            @RequestParam("area") String area,
            @RequestParam("address_type") String address_type,
            @RequestParam("shift") String shift,
            @RequestParam("department") String department,
            @RequestParam(value = "degree_obtained", required = false) String[] degree_obtained,
            @RequestParam("shc_stay_from") String shc_stay_from,
            @RequestParam("shc_stay_to") String shc_stay_to,
            @RequestParam("marital_status") String marital_status,
            @RequestParam(value = "anniversary_year", required = false) String anniversary_year,
            @RequestParam("whatsappno") String whatsappno,
            @RequestParam("phoneno") String phoneno,
            @RequestParam("emailaddress") String emailaddress,
            @RequestParam("empstatus") String empstatus,
            @RequestParam("jobdesig") String jobdesig,
            @RequestParam("officephoneno") String officephoneno,
            @RequestParam("officeemail") String officeemail,
            @RequestParam("fieldofexpert") String fieldofexpert,
            @RequestPart(value = "profileImage", required = false) MultipartFile[] profileImage,
            HttpSession session) throws IOException {

        // Validate required fields
        if (fullname == null || fullname.isEmpty()) {
            return ResponseEntity.badRequest().body("Fullname is required.");
        }

        // Check if email or fullname is already taken
        if (alumniRegisterService.isEmailaddressOrFullnameTaken(emailaddress, fullname)) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(Collections.singletonMap("error", "Email or FullName already taken"));
        }

        // Create and populate AlumniRegisterEntity object
        AlumniRegisterEntity alumni = new AlumniRegisterEntity();
        alumni.setFullname(fullname);
        alumni.setFathersname(fathersname);
        alumni.setNationality(nationality);
        alumni.setDob(LocalDate.parse(dob));
        alumni.setGender(gender);
        alumni.setHouse_flat_number(house_flat_number);
        alumni.setStreet_name(street_name);
        alumni.setCity(city);
        alumni.setState(state);
        alumni.setPostal_code(postal_code);
        alumni.setLandmark(landmark);
        alumni.setArea(area);
        alumni.setAddress_type(address_type);
        alumni.setShift(shift);
        alumni.setDepartment(department);
        alumni.setDegree_obtained(degree_obtained != null ? String.join(", ", degree_obtained) : null);
        alumni.setShcStayFrom(shc_stay_from);
        alumni.setShcStayTo(shc_stay_to);
        alumni.setMarital_status(marital_status);

        if (anniversary_year != null && !anniversary_year.isEmpty()) {
            alumni.setAnniversary_year(LocalDate.parse(anniversary_year));
        }

        alumni.setWhatsappno(whatsappno);
        alumni.setPhoneno(phoneno);
        alumni.setEmailaddress(emailaddress);
        alumni.setEmpstatus(empstatus);
        alumni.setJobdesig(jobdesig);
        alumni.setOfficephoneno(officephoneno);
        alumni.setOfficeemail(officeemail);
        alumni.setFieldofexpert(fieldofexpert);

        // Handle profile image upload
        if (profileImage != null && profileImage.length > 0) {
            for (MultipartFile file : profileImage) {
                if (!file.isEmpty()) {
                    try {
                        String originalFileName = file.getOriginalFilename();
                        System.out.println("File received: " + originalFileName);

                        // Define the directory to store uploaded images
                        String uploadDir = System.getProperty("user.dir") + "/photograph/";
                        File uploadPath = new File(uploadDir);

                        if (!uploadPath.exists() && !uploadPath.mkdirs()) {
                            System.out.println("Failed to create upload directory: " + uploadPath);
                            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                    .body("Failed to create upload directory.");
                        }

                        // Get file extension
                        String extension = "";
                        int dotIndex = originalFileName.lastIndexOf('.');
                        if (dotIndex >= 0) {
                            extension = originalFileName.substring(dotIndex);
                        }

                        // Format fullname for a valid filename (replace spaces & special characters)
                        String sanitizedFullname = fullname.trim().toLowerCase().replaceAll("[^a-zA-Z0-9]", "_");

                        // Generate the file name
                        String fileName = sanitizedFullname + "_" + System.currentTimeMillis() + extension;
                        Path filePath = Paths.get(uploadDir, fileName);

                        // Save the file
                        Files.write(filePath, file.getBytes());

                        // Store the relative path of the file in the entity
                        alumni.setFilePath("/photograph/" + fileName);
                        System.out.println("File successfully saved: " + filePath.toString());

                    } catch (IOException e) {
                        System.out.println("Error saving file: " + e.getMessage());
                        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                .body("Error uploading file.");
                    }
                }
            }
        } else {
            System.out.println("No profile image uploaded.");
        }


        // Save the alumni entity with updated information
        alumniRegisterService.saveAlumni(alumni);

        return ResponseEntity.status(HttpStatus.CREATED).body("Alumni registered successfully");
    }


        
    // Success page
    @GetMapping("/success")
    public String showSuccessPage() {
        return "alumniregistersuccess"; // Returns alumniregistersuccess.jsp
    }

    // Retrieve all alumni records
    // @GetMapping("/all")
    //public ResponseEntity<List<AlumniRegisterEntity>> getAllAlumni() {
    //  List<AlumniRegisterEntity> alumniList = alumniRegisterService.getAllAlumni();
    //  return new ResponseEntity<>(alumniList, HttpStatus.OK);
    //}

    // Retrieve an alumni record by ID

}
