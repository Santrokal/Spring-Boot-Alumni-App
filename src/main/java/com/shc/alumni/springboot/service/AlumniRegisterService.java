package com.shc.alumni.springboot.service;

import java.time.LocalDate;
//import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shc.alumni.springboot.entity.AlumniRegisterEntity;

import com.shc.alumni.springboot.repository.AlumniRegisterRepository;


@Service
public class AlumniRegisterService {

    @Autowired
    private AlumniRegisterRepository alumniRegisterRepository;
    
   
    
    public List<AlumniRegisterEntity> findAll() {
        List<AlumniRegisterEntity> alumniList = alumniRegisterRepository.findAll();

        // Ensure filePath contains only the filename, not the full path
        return alumniList.stream().map(alumni -> {
            if (alumni.getFilePath() != null && alumni.getFilePath().contains("/")) {
                alumni.setFilePath(alumni.getFilePath().substring(alumni.getFilePath().lastIndexOf("/") + 1));
            }
            return alumni;
        }).collect(Collectors.toList());
    }
    
   
    public List<AlumniRegisterEntity> getAllAlumni() {
        return alumniRegisterRepository.findAll();
    }
    
    public void saveAll(List<AlumniRegisterEntity> alumniList) {
        alumniRegisterRepository.saveAll(alumniList);
    }
    
    public void deleteAlumni(int id) {
        alumniRegisterRepository.deleteById(id);
    }
    
    public AlumniRegisterEntity getAlumniDetails(String emailAddress) {
        return alumniRegisterRepository.findByEmailaddress(emailAddress);
    }

    // Find alumni by email address and date of birth
    public AlumniRegisterEntity findByEmailaddressAndDob(String emailaddress, LocalDate dob) {
        return alumniRegisterRepository.findByEmailaddressAndDob(emailaddress, dob);
    }

    // Check if email address or full name exists in the database
    public boolean isEmailaddressOrFullnameTaken(String emailaddress, String fullname) {
        return alumniRegisterRepository.existsByEmailaddressOrFullname(emailaddress, fullname);
    }

    // Find alumni by email address
 // Find alumni by email address
    public AlumniRegisterEntity findByEmail(String emailaddress) {
        return alumniRegisterRepository.findByEmailaddress(emailaddress);
    }
    
    public AlumniRegisterEntity findByFullname(String fullname) {
        return alumniRegisterRepository.findByFullname(fullname);
    }

    public List<AlumniRegisterEntity> getAlumniByYear(int year) {
        return alumniRegisterRepository.findByShcStayTo(String.valueOf(year));
    }


    // Find alumni by ID
    public AlumniRegisterEntity findById(int id) {
        return alumniRegisterRepository.findById(id).orElse(null);
    }



    // Retrieve an alumni record by ID
    public Optional<AlumniRegisterEntity> getAlumniById(int id) {
        return alumniRegisterRepository.findById(id);
    }
    
    public void saveAlumni(AlumniRegisterEntity alumni) {
        alumniRegisterRepository.save(alumni);
    }

    // Delete an alumni record by ID
    public void deleteAlumniById(int id) {
        alumniRegisterRepository.deleteById(id);
    }
}
