package org.mobile.mobileassignment.auth;

import jakarta.persistence.EntityExistsException;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.mobile.mobileassignment.config.JwtService;
import org.mobile.mobileassignment.dtos.RequestAuthentication;
import org.mobile.mobileassignment.dtos.ResponseAuthentication;
import org.mobile.mobileassignment.dtos.RequestEditUser;
import org.mobile.mobileassignment.dtos.RequestRegister;
import org.mobile.mobileassignment.imageUploader.ImageService;
import org.mobile.mobileassignment.user.User;
import org.mobile.mobileassignment.user.UserRepository;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
@RequiredArgsConstructor
public class AuthenticationService {

    private final UserRepository repository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;
    private final ImageService imageService;

    public ResponseAuthentication register(RequestRegister request, MultipartFile file) {
        if (repository.existsByUserId(request.getUserId())) {
            throw new EntityExistsException("User already exists with id: " + request.getUserId());
        }

        String imageUrl = null;
        if (file != null && !file.isEmpty()) {
            imageUrl = uploadImage(file);
        }

        var user = User.builder()
                .userId(request.getUserId())
                .email(request.getEmail())
                .level(request.getLevel())
                .gender(request.getGender())
                .password(passwordEncoder.encode(request.getPassword()))
                .name(request.getName())
                .imageUrl(imageUrl) // Use the updated imageUrl variable here
                .build();

        repository.save(user);
        var jwtToken = jwtService.generateToken(user);
        return ResponseAuthentication.builder()
                .token(jwtToken).build();
    }


    public User editUser(Integer id, RequestEditUser request, MultipartFile file) {
        // Find the user by id or throw an exception if not found
        User userToUpdate = repository.findUserByUserId(id)
                .orElseThrow(() -> new EntityNotFoundException("User not found with id: " + id));

        // Update user information based on the request
        if (request.getName() != null) {
            userToUpdate.setName(request.getName());
        }
        if (request.getEmail() != null) {
            userToUpdate.setEmail(request.getEmail());
        }
        if (request.getLevel() != null) {
            userToUpdate.setLevel(request.getLevel());
        }
        if (request.getGender() != null) {
            userToUpdate.setGender(request.getGender());
        }
        if (request.getPassword() != null) {
            userToUpdate.setPassword(passwordEncoder.encode(request.getPassword()));
        }

        // Update the user's profile picture if a new image is provided
        if (file != null && !file.isEmpty()) {
            String imageUrl = uploadImage(file);
            userToUpdate.setImageUrl(imageUrl);
        }

        return repository.save(userToUpdate);
    }


    public ResponseAuthentication login(RequestAuthentication request) {
        authenticationManager.authenticate((
                new UsernamePasswordAuthenticationToken(
                        request.getEmail(),
                        request.getPassword()
                )
        ));
        var user = repository.findByEmail(request.getEmail()).orElseThrow();
        var jwtToken = jwtService.generateToken(user);
        return ResponseAuthentication.builder()
                .token(jwtToken)
                .build();
    }

    public String uploadImage(MultipartFile file) {
        // Delegate image storage to ImageService
        return imageService.storeFile(file);
    }
}

