package com.shc.alumni.springboot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.shc.alumni.springboot.service.StoryService;



@Controller
public class StoryController {
	
	@Autowired
	private StoryService storyService;
	
	// Endpoint to handle news submission
    @PostMapping("/addstories")
    public ResponseEntity<Object> addNews(
            @RequestParam("title") String title,
            @RequestParam("content") String content,
            @RequestParam("image") MultipartFile imageFile) {

        System.out.println("Received title: " + title);
        System.out.println("Received content: " + content);
        System.out.println("Received image: " + (imageFile != null ? imageFile.getOriginalFilename() : "null"));

        try {
        	storyService.saveStory(title, content, imageFile);
            return ResponseEntity.status(HttpStatus.CREATED).body("{\"message\": \"Story added successfully!\"}");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("{\"error\": \"Error saving story: " + e.getMessage() + "\"}");
        }
    }

    @GetMapping("/addstories")
    public String showAddStoryPage() {
        return "addalumnistories"; // Corresponds to addnews.html or addnews.jsp
    }

}
