package com.samco.mobileproject.service;

import com.samco.mobileproject.mappers.StoreMapper;
import com.samco.mobileproject.repositories.StoreRepository;
import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class StoreService {
    private final StoreRepository storeRepository;

    public List<?> findAllStores() {
        return storeRepository.findAll().stream().map(StoreMapper::storeToDto).toList();
    }

    @SneakyThrows
    public List<?> findStoreProducts(Long storeId) {
        var store = storeRepository.findById(storeId).orElseThrow(()-> new Exception("Store not found"));
        return store.getProducts().stream().toList();
    }
}
