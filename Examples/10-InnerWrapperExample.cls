public class ApiResponseWrapper {

    public Boolean success;

    public DataWrapper data;

    public class DataWrapper {

        public AccountWrapper account;

        public List<ContactWrapper> contacts;
    }

    public class AccountWrapper {

        public String name;

        public String industry;
    }

    public class ContactWrapper {

        public String name;

        public String email;
    }
}


String jsonResponse = '{
    "success": true,
    "data": {
        "account": {
            "name": "ABC Corp",
            "industry": "Technology"
        },
        "contacts": [
            {
                "name": "Raj",
                "email": "raj@test.com"
            },
            {
                "name": "Amit",
                "email": "amit@test.com"
            }
        ]
    }
}';

ApiResponseWrapper response =
    (ApiResponseWrapper)
    JSON.deserialize(
        jsonResponse,
        ApiResponseWrapper.class
    );

System.debug(response.success);
System.debug(response.data.account.name);
System.debug(response.data.account.industry);

for(ApiResponseWrapper.ContactWrapper con :
    response.data.contacts) {

    System.debug(con.name);
    System.debug(con.email);
}
