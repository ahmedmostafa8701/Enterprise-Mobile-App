package com.samco.mobileproject.repositories;

import com.samco.mobileproject.entity.Product;
import com.samco.mobileproject.entity.Store;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    @Query("SELECT product.stores from Product product where lower(product.name) like %:term%")
    List<Store> findByTerm(@Param("term") String term);
}
