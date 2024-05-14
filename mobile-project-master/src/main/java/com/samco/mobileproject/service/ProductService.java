package com.samco.mobileproject.service;

import com.samco.mobileproject.entity.Store;
import com.samco.mobileproject.mappers.StoreMapper;
import com.samco.mobileproject.repositories.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ProductService {
    private final ProductRepository productRepository;

    public List<?> getRestaurants(String term) {
        List<Store> stores = productRepository.findByTerm(term.toLowerCase());
        return stores.stream().map(StoreMapper::storeToDto).toList();
    }
}
