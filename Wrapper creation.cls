{
  "success": true,
  "message": "Records Retrieved",
  "errors":[
    {
        "code":"1001",
        "message":"Invalid Account"
    }
],
  "data": [
    {
      "id": 101,
      "name": "ABC Corp"
    },
    {
      "id": 102,
      "name": "XYZ Corp"
    }
  ]
}


public class EmployeeWrapper {
    public Boolean success;
    public String message;
    public List<ErrorWrapper> errors;
    public List<DataWrapper> data;
}
public class ErrorWrapper {
    public Integer code;
    public String message;
    
}
public class DataWrapper {
    public Integer id;
    public String name;
}
