package com.shc.alumni.springboot.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.shc.alumni.springboot.entity.StoryEntity;

public interface StoryRepository extends JpaRepository<StoryEntity, Long> {
	
	List<StoryEntity> findAll();
    List<StoryEntity> findTop5ByOrderByCreatedAtDesc();


}
