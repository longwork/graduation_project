package wimi.student.util;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
 * @author Administrator
 */
@Getter
@Setter
public class JsonResult<T> implements Serializable {
    private static final long serialVersionUID = -3644950655568598241L;

    private int state;
    private String message;
    private T data;

    public static final int SUCCESS = 0;
    public static final int ERROR = 1;

    public JsonResult() {
        state = SUCCESS;
        message = "";
    }

    public JsonResult(T data) {
        state = SUCCESS;
        this.data = data;
    }

    public JsonResult(Throwable e) {
        state = ERROR;
        message = e.getMessage();
    }

    public JsonResult(int state, String message) {
        this.state = state;
        this.message = message;
    }

    public JsonResult(int state, Throwable e) {
        this.state = state;
        this.message = e.getMessage();
    }

    public JsonResult(int state, T data) {
        this.state = state;
        this.data = data;
    }

    @Override
    public String toString() {
        return "JsonResult [state=" + state + ", message=" + message + ", data=" + data + "]";
    }
}
