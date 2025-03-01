package com.shc.alumni.springboot.service;

import com.shc.alumni.springboot.entity.News;
import com.shc.alumni.springboot.repository.NewsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDateTime;
//import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

@Service
public class NewsService {
	
	


    @Autowired
    private NewsRepository newsRepository;
    
    public News getNewsById(int id) {
        return newsRepository.findById((long) id).orElse(null);  // Returns null if the News is not found
    }


    
    public List<News> findAll() {
        return newsRepository.findAll();
    }
    
    public List<News> findTop5ByOrderByCreatedAtDesc() {
        return newsRepository.findTop5ByOrderByCreatedAtDesc();
    }


 // Method to save news to the database
    public void saveNews(String title, String content, MultipartFile imageFile) {
        System.out.println("Saving news...");
        try {
            // Convert image to Base64 string
            String imageBase64 = convertImageToBase64(imageFile);
            System.out.println("Base64 Image: " + imageBase64.substring(0, 100) + "...");

            News news = new News();
            news.setTitle(title);
            news.setContent(content);
            news.setImageBase64(imageBase64); // Set Base64 image
            news.setCreatedAt(LocalDateTime.now()); // Ensure createdAt is set

            // Save the news entity
            newsRepository.save(news);
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

    public void deleteById(Long id) {
        // Check if the entity exists before deleting
        if (newsRepository.existsById(id)) {
            newsRepository.deleteById(id);
        } else {
            throw new IllegalArgumentException("News with ID " + id + " does not exist.");
        }
    }


}
