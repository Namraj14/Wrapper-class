public class SimpleJsonResponseWrapper {

    public Boolean success;

    public String message;
}

String jsonResponse =
'{' +
'"success":true,' +
'"message":"Records Retrieved"' +
'}';

SimpleJsonResponseWrapper response =
    (SimpleJsonResponseWrapper)
    JSON.deserialize(
        jsonResponse,
        SimpleJsonResponseWrapper.class
    );

System.debug(response.success);
System.debug(response.message);
