package com.shc.alumni.springboot.controller;

import java.util.Base64;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.shc.alumni.springboot.entity.Comment;
import com.shc.alumni.springboot.entity.News;
import com.shc.alumni.springboot.service.CommentService;
import com.shc.alumni.springboot.service.FunFactService;
import com.shc.alumni.springboot.service.NewsService;


@Controller
public class AlumniNewsController {
	
	 @Autowired
	    private NewsService newsService;
	 
	 @Autowired
	    private CommentService commentService;
	 @Autowired
	 private FunFactService funFactService;
	 
	 
	 @GetMapping("/news")
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

	     return "alumninews"; // Returns the JSP view name
	 }
	 
	 @GetMapping("/news/{id}")
	 public String viewNews(@PathVariable("id") int id, Model model) {
	     News news = newsService.getNewsById(id);
	     if (news == null) {
	         return "redirect:/404"; // Redirect if no news found
	     }

	     List<Comment> comments = commentService.getCommentsByNewsId(id);

	     model.addAttribute("news", news);
	     model.addAttribute("comments", comments);
	     
	     // Add a fun fact to the model
			String funFact = funFactService.getFunFactForToday();
			model.addAttribute("funFact", funFact);	
	     return "newsexpand"; // Return the JSP view
	 }


	// Endpoint to handle adding a new comment
	 @PostMapping("/news/{id}/comment")
	 public String addComment(@PathVariable("id") int newsId, 
	                          @RequestParam("commentText") String commentText) {
	     if (commentText != null && !commentText.trim().isEmpty()) {
	         Comment comment = new Comment();
	         comment.setNewsId(newsId);
	         comment.setText(commentText);
	         commentService.addComment(comment);
	     }
	     return "redirect:/news/" + newsId; // Redirect back to the news details page
	 }


}
