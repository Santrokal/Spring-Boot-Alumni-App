package com.shc.alumni.springboot.controller;

//import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

//import com.shc.alumni.springboot.entity.ContactEntity;
import com.shc.alumni.springboot.entity.News;
import com.shc.alumni.springboot.repository.ContactRepository;
import com.shc.alumni.springboot.service.ContactService;
import com.shc.alumni.springboot.service.EmailService;
import com.shc.alumni.springboot.service.NewsService;

@Controller
public class AdminNewsController {
	
	@Autowired
	private NewsService newsService;
	@Autowired
	ContactService contactService;
	@Autowired
	ContactRepository contactRepository;
	@Autowired
	EmailService emailService;
	
	
	 @GetMapping("/admin/managenews")
	 public String getAllNews(Model model) {
	     // Fetch all news records
	     List<News> newsList = newsService.findAll();

	     // Print out the createdAt for debugging
	     System.out.println("Before sorting:");
	     for (News news : newsList) {
	         System.out.println(news.getTitle() + " - " + news.getCreatedAt());
	     }

	     // Sort the list based on createdAt in descending order (newest first)
	     newsList.sort((news1, news2) -> news2.getCreatedAt().compareTo(news1.getCreatedAt()));

	     // Print out the createdAt after sorting for debugging
	     System.out.println("After sorting:");
	     for (News news : newsList) {
	         System.out.println(news.getTitle() + " - " + news.getCreatedAt());
	     }

	     // Convert photographs to Base64
	     for (News news : newsList) {
	         if (news.getImage() != null) {
	             String base64Image = Base64.getEncoder().encodeToString(news.getImage());
	             news.setImageBase64(base64Image); // Setting Base64 string for JSP use
	         }
	     }

	     // Add news list to the model
	     model.addAttribute("newsList", newsList);

	     return "adminnews"; // Returns the JSP view name
	 }
	 @GetMapping("/admin/deleteNews")
	 public String deleteNews(@RequestParam("id") Long id) {
	     newsService.deleteById(id);
	     return "redirect:/admin/managenews"; // Redirect back to the news management page
	 }
	

}
