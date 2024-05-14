package com.samco.mobileproject.controller;

import com.samco.mobileproject.service.StoreService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("api/v1/store")
public class StoreController {
    private final StoreService storeService;

    @GetMapping
    public ResponseEntity<?> findAllStores() {
        System.out.println(storeService.findAllStores());
        return ResponseEntity.ok(storeService.findAllStores());
    }

    @GetMapping("{storeId}")
    public ResponseEntity<?> findStoreProducts(@PathVariable("storeId") Long storeId){
        return ResponseEntity.ok(storeService.findStoreProducts(storeId));
    }
}
