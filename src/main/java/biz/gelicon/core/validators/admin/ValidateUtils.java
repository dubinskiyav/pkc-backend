package biz.gelicon.core.validators.admin;

import org.springframework.validation.Errors;

import javax.validation.ConstraintViolation;
import java.util.Set;

public class ValidateUtils {
    public static void fillErrors(Errors errors, Set<ConstraintViolation<Object>> validates) {
        for (ConstraintViolation<Object> constraintViolation : validates) {
            errors.rejectValue(constraintViolation.getPropertyPath().toString(), "",
                    constraintViolation.getMessage());
        }
    }
}
