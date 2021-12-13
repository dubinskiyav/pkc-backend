package biz.gelicon.core.response.exceptions;

public class IncorrectAuthenticationTypeException extends RuntimeException {
    public IncorrectAuthenticationTypeException() {
        super("Неподдерживаемый тип доступа");
    }

    public IncorrectAuthenticationTypeException(String message) {
        super(message);
    }
}
