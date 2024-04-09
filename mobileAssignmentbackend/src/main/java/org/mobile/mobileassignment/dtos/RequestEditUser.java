package org.mobile.mobileassignment.dtos;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.mobile.mobileassignment.enums.EducationLevel;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class RequestEditUser {

    private String name;
    private String gender;
    private String email;

    private EducationLevel level;
    private String password;
    private String imageUrl;

}
