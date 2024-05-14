package com.samco.mobileproject.config;

import com.github.javafaker.Faker;
import com.samco.mobileproject.entity.Product;
import com.samco.mobileproject.entity.Store;
import com.samco.mobileproject.repositories.ProductRepository;
import com.samco.mobileproject.repositories.StoreRepository;
import com.samco.mobileproject.service.StoreService;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Configuration;

import java.util.Collections;
import java.util.List;
import java.util.Random;

@Configuration
@RequiredArgsConstructor
public class Startup implements CommandLineRunner {
    private final StoreRepository storeRepository;
    private final ProductRepository productRepository;

    @Override
    public void run(String... args) {
        Faker faker = new Faker();
        List<String> restaurants = List.of(
                "Primo's Pizza",
                "Pizza Roma",
                "Pizza King",
                "Papa Johns",
                "Pizza Station",
                "Pizza Hut",
                "Pizza Master",
                "Pizza Time",
                "Action Pizza",
                "Pizza Hum",
                "Domino's Pizza",
                "Milano Pizza",
                "Pizza Lovers"
        );
        List<String> pizzas = List.of(
                "Margherita",
                "Pepperoni",
                "Hawaiian",
                "Meat Lovers",
                "Vegetarian",
                "BBQ Chicken",
                "Four Cheese",
                "Supreme",
                "Buffalo Chicken",
                "White Pizza",
                "Mediterranean",
                "Capricciosa",
                "Prosciutto and Arugula",
                "Taco Pizza",
                "Shrimp Scampi",
                "Breakfast Pizza",
                "Philly Cheesesteak",
                "Spinach and Feta"
        );

        for (String restaurant : restaurants) {
            var store = Store.builder()
                    .name(restaurant)
                    .lat(Double.parseDouble(faker.address().latitude()))
                    .lng(Double.parseDouble(faker.address().longitude()))
                    .build();
            storeRepository.save(store);
        }

        for (String pizza : pizzas) {
            var product = Product.builder()
                    .name(pizza)
                    .build();
            productRepository.save(product);
        }

        storeRepository.findAll().forEach(store -> {
            Random random = new Random();
            var products = productRepository.findAll();
            Collections.shuffle(products);
            int start = 0;
            int end = random.nextInt(start, products.size());
            store.addProducts(products.subList(start, end));
            storeRepository.save(store);
        });
    }
}
