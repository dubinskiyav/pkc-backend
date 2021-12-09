package biz.gelicon.core.response.exceptions;

public class InTransactionException extends RuntimeException {
    public InTransactionException(Throwable cause) {
        super(cause.getMessage(),cause);
    }
}
