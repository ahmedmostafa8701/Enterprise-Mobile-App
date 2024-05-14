package com.samco.mobileproject.service;

import com.samco.mobileproject.dtos.LoginDto;
import com.samco.mobileproject.entity.User;
import com.samco.mobileproject.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;

    @SneakyThrows
    public void signUp(User user) {
        var dbUser = userRepository.findByEmail(user.getEmail());
        if (dbUser.isPresent()) throw new Exception("email already exists");
        userRepository.save(user);
    }

    @SneakyThrows
    public void signIn(LoginDto loginDto) {
        var dbUser = userRepository.findByEmailAndPassword(loginDto.getUsername(), loginDto.getPassword());
        if (dbUser.isEmpty()) throw new Exception("invalid credentials");
    }
}
