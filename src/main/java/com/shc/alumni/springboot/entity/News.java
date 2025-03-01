package com.shc.alumni.springboot.entity;

import jakarta.persistence.*;

//import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Base64;

@Entity
@Table(name = "news")
public class News {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String title;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String content;

    @Lob
    @Column(length = 90485760)
    private byte[] image;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    @Transient // Not persisted in the database
    private String imageBase64;

    public News() {
    }

    public News(String title, String content, byte[] image, LocalDateTime  createdAt) {
        this.title = title;
        this.content = content;
        this.image = image;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }

    public LocalDateTime  getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime  createdAt) {
        this.createdAt = createdAt;
    }

    public String getImageBase64() {
        if (this.image != null) {
            return Base64.getEncoder().encodeToString(this.image);
        }
        return null;
    }

    public void setImageBase64(String imageBase64) {
        this.imageBase64 = imageBase64;
        if (imageBase64 != null) {
            this.image = Base64.getDecoder().decode(imageBase64);
        }
    }
}
