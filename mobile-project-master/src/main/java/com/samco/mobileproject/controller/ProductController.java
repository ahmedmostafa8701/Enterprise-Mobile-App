package com.samco.mobileproject.controller;

import com.samco.mobileproject.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("api/v1/product")
public class ProductController {
    private final ProductService productService;

    @GetMapping()
    public ResponseEntity<?> searchProduct(@RequestParam("term") String term) {
        return ResponseEntity.ok(productService.getRestaurants(term));
    }
}
