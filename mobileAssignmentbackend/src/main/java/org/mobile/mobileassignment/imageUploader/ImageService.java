package org.mobile.mobileassignment.imageUploader;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Objects;
import java.util.UUID;

@Service
public class ImageService {
    @Value("${upload-image}")
    private String uploadDir;

    public String storeFile(MultipartFile file) {
        // Normalize file name
        String fileName = StringUtils.cleanPath(Objects.requireNonNull(file.getOriginalFilename()));

        try {
            // Check if the file's name contains invalid characters
            if(fileName.contains("..")) {
                throw new RuntimeException("Invalid file name: " + fileName);
            }

            // Generate a unique filename to prevent conflicts
            String uniqueFileName = UUID.randomUUID().toString() + "_" + fileName;

            // Copy file to the target location (e.g., a directory on the server)
            Path targetLocation = Paths.get(uploadDir).resolve(uniqueFileName);
            Files.copy(file.getInputStream(), targetLocation);

            return uniqueFileName; // Return the filename for storage in the database
        } catch (IOException ex) {
            throw new RuntimeException("Failed to store file " + fileName, ex);
        }
    }

    public String getFileUrl(String filename) {
        // Generate URL for accessing the uploaded file
        return "/images/" + filename; // Example URL format: /uploads/filename.ext
    }
}
