package org.mobile.mobileassignment.enums;

import lombok.Getter;

@Getter
public enum EducationLevel {
    FIRST(1),
    SECOND(2),
    THIRD(3),
    FOURTH(4);

    private final int level;

    EducationLevel(int level) {
        this.level = level;
    }

}
