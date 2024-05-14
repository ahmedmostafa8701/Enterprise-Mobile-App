package com.samco.mobileproject.mappers;

import com.samco.mobileproject.dtos.StoreDto;
import com.samco.mobileproject.entity.Store;

public class StoreMapper {
    public static StoreDto storeToDto(Store store) {
        return StoreDto.builder()
                .id(store.getId())
                .name(store.getName())
                .lat(store.getLat())
                .lng(store.getLng())
                .build();
    }
}
