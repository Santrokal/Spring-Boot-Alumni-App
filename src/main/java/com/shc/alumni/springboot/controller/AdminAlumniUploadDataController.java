package com.shc.alumni.springboot.controller;

import com.shc.alumni.springboot.entity.AlumniRegisterEntity;
import com.shc.alumni.springboot.service.AlumniRegisterService;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.HashMap;
import java.lang.String;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

@Controller
public class AdminAlumniUploadDataController {

    @Autowired
    private AlumniRegisterService alumniRegisterService;

    // Display the file upload form
    @GetMapping("/admin/uploaddata")
    public String showAddUserForm() {
        return "uploaddata"; // Points to adminregister.jsp
    }

    // Handle file upload
    @PostMapping("/admin/uploadAlumniData")
    public String uploadAlumniData(MultipartFile file, RedirectAttributes redirectAttributes) {
        if (file.isEmpty()) {
            redirectAttributes.addFlashAttribute("message", "Please select a file to upload.");
            return "redirect:/admin/uploaddata"; // Redirect back to the form
        }

        try {
            String filename = file.getOriginalFilename();
            if (filename != null && (filename.endsWith(".xlsx") || filename.endsWith(".csv"))) {
                List<AlumniRegisterEntity> alumniList = null;

                if (filename.endsWith(".xlsx")) {
                    alumniList = parseXLSXFile(file.getInputStream());
                } else if (filename.endsWith(".csv")) {
                    alumniList = parseCSVFile(file.getInputStream());
                }

                if (alumniList != null && !alumniList.isEmpty()) {
                    alumniRegisterService.saveAll(alumniList);
                    redirectAttributes.addFlashAttribute("message", "File uploaded successfully!");
                } else {
                    redirectAttributes.addFlashAttribute("message", "No valid data found in the file.");
                }
            } else {
                redirectAttributes.addFlashAttribute("message", "Please upload a valid CSV or XLSX file.");
            }
        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("message", "Error reading the file.");
        }

        return "redirect:/admin/uploaddata"; // Redirect back to the form with the message
    }

    // Parse XLSX file
    private List<AlumniRegisterEntity> parseXLSXFile(InputStream inputStream) throws IOException {
        List<AlumniRegisterEntity> alumniList = new ArrayList<>();
        Workbook workbook = new XSSFWorkbook(inputStream);
        Sheet sheet = workbook.getSheetAt(0);
        
        // Read the header row
        Row headerRow = sheet.getRow(0);
        Map<Integer, String> columnMapping = new HashMap<>();
        
        for (Cell cell : headerRow) {
            columnMapping.put(cell.getColumnIndex(), cell.getStringCellValue().trim().toLowerCase());
        }

        // Process data rows
        for (Row row : sheet) {
            if (row.getRowNum() == 0) continue; // Skip the header row
            
            AlumniRegisterEntity alumni = new AlumniRegisterEntity();
            
            for (Cell cell : row) {
                String columnName = columnMapping.get(cell.getColumnIndex());
                String cellValue = getCellValue(cell);
                
                if (columnName == null) continue; // Skip unmapped columns
                
                // Map Excel columns to entity fields
                switch (columnName) {
                    case "fullname":
                        alumni.setFullname(cellValue);
                        break;
                    case "fathersname":
                        alumni.setFathersname(cellValue);
                        break;
                    case "nationality":
                        alumni.setNationality(cellValue);
                        break;
                    case "dob":
                        alumni.setDob(getDateCellValue(cell));
                        break;
                    case "gender":
                        alumni.setGender(cellValue);
                        break;
                    case "house_flat_number":
                        alumni.setHouse_flat_number(cellValue);
                        break;
                    case "street_name":
                        alumni.setStreet_name(cellValue);
                        break;
                    case "city":
                        alumni.setCity(cellValue);
                        break;
                    case "state":
                        alumni.setState(cellValue);
                        break;
                    case "postal_code":
                        alumni.setPostal_code(cellValue);
                        break;
                    case "landmark":
                        alumni.setLandmark(cellValue);
                        break;
                    case "area":
                        alumni.setArea(cellValue);
                        break;
                    case "address_type":
                        alumni.setAddress_type(cellValue);
                        break;
                    case "shift":
                        alumni.setShift(cellValue);
                        break;
                    case "department":
                        alumni.setDepartment(cellValue);
                        break;
                    case "degree_obtained":
                        alumni.setDegree_obtained(cellValue);
                        break;
                    case "shcstayfrom":
                        alumni.setShcStayFrom(cellValue);
                        break;
                    case "shcstayto":
                        alumni.setShcStayTo(cellValue);
                        break;
                    case "marital_status":
                        alumni.setMarital_status(cellValue);
                        break;
                    case "anniversary_year":
                        alumni.setAnniversary_year(getDateCellValue(cell));
                        break;
                    case "whatsappno":
                        alumni.setWhatsappno(cellValue);
                        break;
                    case "phoneno":
                        alumni.setPhoneno(cellValue);
                        break;
                    case "emailaddress":
                        alumni.setEmailaddress(cellValue);
                        break;
                    case "empstatus":
                        alumni.setEmpstatus(cellValue);
                        break;
                    case "jobdesig":
                        alumni.setJobdesig(cellValue);
                        break;
                    case "officephoneno":
                        alumni.setOfficephoneno(cellValue);
                        break;
                    case "officeemail":
                        alumni.setOfficeemail(cellValue);
                        break;
                    case "fieldofexpert":
                        alumni.setFieldofexpert(cellValue);
                        break;
                }
            }
            alumniList.add(alumni);
        }
        workbook.close();
        return alumniList;
    }





    private LocalDate getDateCellValue(Cell cell) {
        if (cell == null) return null; // Return null if the cell is empty
        if (cell.getCellType() == CellType.NUMERIC && DateUtil.isCellDateFormatted(cell)) {
            return cell.getDateCellValue().toInstant()
                    .atZone(ZoneId.systemDefault())
                    .toLocalDate();
        }
        return null; // Return null if the cell is not a valid date
    }


    private String getCellValue(Cell cell) {
        if (cell == null) return "";

        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue().trim();
            case NUMERIC:
                if (DateUtil.isCellDateFormatted(cell)) {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    return sdf.format(cell.getDateCellValue());
                } else {
                    // Check if it's a whole number
                    if (cell.getNumericCellValue() == Math.floor(cell.getNumericCellValue())) {
                        return String.valueOf((long) cell.getNumericCellValue()); // Convert to long to remove .0
                    } else {
                        return String.valueOf(cell.getNumericCellValue()); // Keep as double if not whole
                    }
                }
            case BOOLEAN:
                return String.valueOf(cell.getBooleanCellValue());
            case FORMULA:
                return cell.getCellFormula();
            default:
                return "";
        }
    }



	// Parse CSV file
    private List<AlumniRegisterEntity> parseCSVFile(InputStream inputStream) throws IOException {
        List<AlumniRegisterEntity> alumniList = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new InputStreamReader(inputStream))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] columns = line.split(",");
                AlumniRegisterEntity alumni = new AlumniRegisterEntity();

                alumni.setFullname(columns[0]);
                alumni.setFathersname(columns[1]);
                alumni.setNationality(columns[2]);
                alumni.setDob(parseDate(columns[3]));
                alumni.setGender(columns[4]);
                alumni.setHouse_flat_number(columns[5]);
                alumni.setStreet_name(columns[6]);
                alumni.setCity(columns[7]);
                alumni.setState(columns[8]);
                alumni.setPostal_code(columns[9]);
                alumni.setLandmark(columns[10]);
                alumni.setArea(columns[11]);
                alumni.setAddress_type(columns[12]);
                alumni.setShift(columns[13]);
                alumni.setDepartment(columns[14]);
                alumni.setDegree_obtained(columns[15]);
                alumni.setShcStayFrom(columns[16]);
                alumni.setShcStayTo(columns[17]);
                alumni.setMarital_status(columns[18]);
                alumni.setAnniversary_year(parseDate(columns[19]));
                alumni.setWhatsappno(columns[20]);
                alumni.setPhoneno(columns[21]);
                alumni.setEmailaddress(columns[22]);
                alumni.setEmpstatus(columns[23]);
                alumni.setJobdesig(columns[24]);
                alumni.setOfficephoneno(columns[25]);
                alumni.setOfficeemail(columns[26]);
                alumni.setFieldofexpert(columns[27]);
                alumni.setFilePath(null); // Set this to null, or handle file uploads separately

                alumniList.add(alumni);
            }
        }
        return alumniList;
    }


    // Helper method to parse date from CSV string
    private LocalDate parseDate(String dateStr) {
        try {
            return LocalDate.parse(dateStr);
        } catch (Exception e) {
            return null;
        }
    }
}
