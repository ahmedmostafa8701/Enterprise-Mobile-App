package com.samco.mobileproject.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
@Setter
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Store {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;
    private String name;
    private double lat;
    private double lng;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name = "store_product", joinColumns = @JoinColumn(name = "store_id"), inverseJoinColumns = @JoinColumn(name = "product_id"))
    private Set<Product> products = new HashSet<>();

    public void addProducts(List<Product> productsToAdd){
        for(var product : productsToAdd){
            products.add(product);
            product.getStores().add(this);
        }
    }
}
