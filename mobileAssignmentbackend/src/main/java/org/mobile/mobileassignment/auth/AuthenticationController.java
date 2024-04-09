package org.mobile.mobileassignment.auth;

import lombok.RequiredArgsConstructor;
import org.mobile.mobileassignment.dtos.RequestAuthentication;
import org.mobile.mobileassignment.dtos.ResponseAuthentication;
import org.mobile.mobileassignment.dtos.RequestEditUser;
import org.mobile.mobileassignment.dtos.RequestRegister;
import org.mobile.mobileassignment.user.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/api/v1/auth")
@RequiredArgsConstructor
public class AuthenticationController {

    private final AuthenticationService authenticationService;

    @PostMapping("/register")
    public ResponseEntity<ResponseAuthentication> register(
            @RequestPart("user") RequestRegister request,
            @RequestPart("image") MultipartFile image
    ) {
        return ResponseEntity.ok(authenticationService.register(request, image));
    }

    @PostMapping("/login")
    public ResponseEntity<ResponseAuthentication> login(
            @RequestBody RequestAuthentication request
    ) {
        return ResponseEntity.ok(authenticationService.login(request));
    }

    @PatchMapping("/editUser/{id}")
    public ResponseEntity<User> editUser(
            @PathVariable Integer id,
            @RequestBody RequestEditUser request,
            @RequestParam(value = "file", required = false) MultipartFile file
    ) {
        return ResponseEntity.ok(authenticationService.editUser(id, request, file));
    }


}
