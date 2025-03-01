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

//import com.shc.alumni.springboot.entity.Comment;
//import com.shc.alumni.springboot.entity.News;
import com.shc.alumni.springboot.entity.StoryComment;
import com.shc.alumni.springboot.entity.StoryEntity;
import com.shc.alumni.springboot.service.FunFactService;
import com.shc.alumni.springboot.service.StoryCommentService;
import com.shc.alumni.springboot.service.StoryService;

@Controller
public class AlumniStoryController {

	@Autowired
	private StoryService storyService;
	
	@Autowired
	private FunFactService funFactService;
	
	
	@Autowired
	private StoryCommentService storyCommentService;
	
	

	@GetMapping("/stories")
	public String getAllStory(Model model) {
		// Fetch all news records
		List<StoryEntity> storiesList = storyService.findAll();

		// Print out the createdAt for debugging
		System.out.println("Before sorting:");
		for (StoryEntity stories : storiesList) {
			System.out.println(stories.getTitle() + " - " + stories.getCreatedAt());
		}

		// Sort the list based on createdAt in descending order (newest first)
		storiesList.sort((stories1, stories2) -> stories2.getCreatedAt().compareTo(stories1.getCreatedAt()));

		// Print out the createdAt after sorting for debugging
		System.out.println("After sorting:");
		for (StoryEntity stories : storiesList) {
			System.out.println(stories.getTitle() + " - " + stories.getCreatedAt());
		}

		// Convert photographs to Base64
		for (StoryEntity stories : storiesList) {
			if (stories.getImage() != null) {
				String base64Image = Base64.getEncoder().encodeToString(stories.getImage());
				stories.setImageBase64(base64Image); // Setting Base64 string for JSP use
			}
		}

		// Add news list to the model
		model.addAttribute("storiesList", storiesList);
		

		return "alumnistories"; // Returns the JSP view name
	}
	
	@GetMapping("/stories/{id}")
	public String viewStories(@PathVariable("id") int id, Model model) {
	    StoryEntity stories = storyService.getStoryById(id);
	    
	    if (stories == null) {
	        return "redirect:/404"; // Redirect if no news found
	    }

	    System.out.println("Title: " + stories.getTitle()); // Debugging
	    System.out.println("Content: " + stories.getContent());
	    
	    List<StoryComment> storycomments = storyCommentService.getCommentsByStoryId(id);
	    String funFact = funFactService.getFunFactForToday();

	    model.addAttribute("stories", stories);
	    model.addAttribute("comments", storycomments);
	    model.addAttribute("funFact", funFact);
	    
	    return "storyexpand"; // Return the JSP view
	}

	
	
	
	// Endpoint to handle adding a new comment
		 @PostMapping("/stories/{id}/storycomment")
		 public String addComment(@PathVariable("id") int storyId, 
		                          @RequestParam("storycommentText") String storycommentText) {
		     if (storycommentText != null && !storycommentText.trim().isEmpty()) {
		         StoryComment storycomment = new StoryComment();
		         storycomment.setStoryId(storyId);
		         storycomment.setText(storycommentText);
		         storyCommentService.addComment(storycomment);
		     }
		     return "redirect:/stories/" + storyId; // Redirect back to the news details page
		 }
		 
		 

}
