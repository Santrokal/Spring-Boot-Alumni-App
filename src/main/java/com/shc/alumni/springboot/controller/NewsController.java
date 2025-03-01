package com.shc.alumni.springboot.controller;

//import com.shc.alumni.springboot.entity.Comment;
//import com.shc.alumni.springboot.entity.News;
//import com.shc.alumni.springboot.service.CommentService;
import com.shc.alumni.springboot.service.NewsService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model; // Correct import
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

//import java.util.List;

@Controller
@RequestMapping("/")
public class NewsController {

    @Autowired
    private NewsService newsService;

    //@Autowired
    //private CommentService commentService;

    // Endpoint to handle news submission
    @PostMapping("/addnews")
    public ResponseEntity<Object> addNews(
            @RequestParam("title") String title,
            @RequestParam("content") String content,
            @RequestParam("image") MultipartFile imageFile) {

        System.out.println("Received title: " + title);
        System.out.println("Received content: " + content);
        System.out.println("Received image: " + (imageFile != null ? imageFile.getOriginalFilename() : "null"));

        try {
            newsService.saveNews(title, content, imageFile);
            return ResponseEntity.status(HttpStatus.CREATED).body("{\"message\": \"News added successfully!\"}");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("{\"error\": \"Error saving news: " + e.getMessage() + "\"}");
        }
    }

    @GetMapping("/addnews")
    public String showAddNewsPage() {
        return "addnewsalumni"; // Corresponds to addnews.html or addnews.jsp
    }


}
