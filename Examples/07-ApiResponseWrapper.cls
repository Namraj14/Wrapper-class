public class ApiResponseWrapper {

    public Boolean success;

    public String message;

    public List<DataWrapper> data;
}

public class DataWrapper {

    public Integer id;

    public String name;
}

String jsonResponse =
'{' +
'"success":true,' +
'"message":"Records Retrieved",' +
'"data":[' +
'{"id":101,"name":"ABC Corp"},' +
'{"id":102,"name":"XYZ Corp"}' +
']' +
'}';

ApiResponseWrapper response =
    (ApiResponseWrapper)
    JSON.deserialize(
        jsonResponse,
        ApiResponseWrapper.class
    );

System.debug(response.success);
System.debug(response.message);

for(DataWrapper d : response.data) {

    System.debug(d.id);
    System.debug(d.name);
}
