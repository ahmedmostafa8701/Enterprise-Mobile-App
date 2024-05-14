package com.samco.mobileproject.controller;

import com.samco.mobileproject.dtos.LoginDto;
import com.samco.mobileproject.entity.User;
import com.samco.mobileproject.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("api/v1/auth")
public class AuthController {
    private final UserService userService;

    @PostMapping("signup")
    public ResponseEntity<?> signUp(@RequestBody User user) {
        userService.signUp(user);
        return ResponseEntity.ok("sign up success");
    }

    @PostMapping("signin")
    public ResponseEntity<?> signIn(@RequestBody LoginDto loginDto) {
        userService.signIn(loginDto);
        return ResponseEntity.ok("welcome back, " + loginDto.getUsername());
    }
}
