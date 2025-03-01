package com.shc.alumni.springboot.service;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Base64;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

//import com.shc.alumni.springboot.entity.News;
import com.shc.alumni.springboot.entity.StoryEntity;
import com.shc.alumni.springboot.repository.StoryRepository;

@Service
public class StoryService {
	
	@Autowired
    private StoryRepository storyRepository;
    
    public List<StoryEntity> findAll() {
    	
        return storyRepository.findAll();
        
    }
    
    public List<StoryEntity> findTop5ByOrderByCreatedAtDesc() {
        return storyRepository.findTop5ByOrderByCreatedAtDesc();
    }
    
    public StoryEntity getStoryById(int id) {
        return storyRepository.findById((long) id).orElse(null);  // Returns null if the News is not found
    }


    // Method to save news to the database
 // Method to save news to the database
    public void saveStory(String title, String content, MultipartFile imageFile) {
        System.out.println("Saving Story...");
        try {
            // Convert image to Base64 string
            String imageBase64 = convertImageToBase64(imageFile);
            System.out.println("Base64 Image: " + imageBase64.substring(0, 100) + "...");

            StoryEntity stories = new StoryEntity();
            stories.setTitle(title);
            stories.setContent(content);
            stories.setImageBase64(imageBase64); // Set Base64 image
            stories.setCreatedAt(LocalDateTime.now()); // Ensure createdAt is set

            // Save the news entity
            storyRepository.save(stories);
            System.out.println("News saved successfully!");
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException("Error saving news: " + e.getMessage());
        }
    }

    public String convertImageToBase64(MultipartFile imageFile) throws IOException {
        // Get the byte array of the image
        byte[] bytes = imageFile.getBytes();
        
        // Encode the byte array to Base64 and return the encoded string
        return Base64.getEncoder().encodeToString(bytes);
    }

}
