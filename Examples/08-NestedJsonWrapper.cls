public class CustomerWrapper {

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

String jsonResponse = '{
    "account":{
        "name":"ABC Corp",
        "industry":"Technology"
    },
    "contacts":[
        {
            "name":"Raj",
            "email":"raj@test.com"
        },
        {
            "name":"Amit",
            "email":"amit@test.com"
        }
    ]
}';

CustomerWrapper customer =
    (CustomerWrapper)
    JSON.deserialize(
        jsonResponse,
        CustomerWrapper.class
    );

System.debug(customer.account.name);
System.debug(customer.account.industry);

for(ContactWrapper con : customer.contacts) {

    System.debug(con.name);
    System.debug(con.email);
}
