public class AccountContactCountWrapper {

    public Account acc;

    public Integer totalContacts;
}

AccountContactCountWrapper wrapper =
    new AccountContactCountWrapper();

wrapper.acc = new Account(
    Name = 'ABC Corp'
);

wrapper.totalContacts = 5;

System.debug(wrapper.acc.Name);
System.debug(wrapper.totalContacts);
