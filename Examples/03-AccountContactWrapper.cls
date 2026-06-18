public class AccountContactWrapper {

    public Account acc;

    public List<Contact> contacts;
}


Account a = new Account(
    Name = 'ABC Corp'
);

List<Contact> contacts = new List<Contact>();

for(Integer i = 1; i <= 3; i++) {

    contacts.add(
        new Contact(
            LastName = 'Contact ' + i
        )
    );
}

AccountContactWrapper wrapper =
    new AccountContactWrapper();

wrapper.acc = a;
wrapper.contacts = contacts;

System.debug(wrapper.acc.Name);
System.debug(wrapper.contacts);
