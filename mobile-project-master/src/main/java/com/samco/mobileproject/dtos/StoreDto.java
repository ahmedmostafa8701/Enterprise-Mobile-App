package com.samco.mobileproject.dtos;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class StoreDto {
    private Long id;
    private String name;
    private double lat;
    private double lng;
}
