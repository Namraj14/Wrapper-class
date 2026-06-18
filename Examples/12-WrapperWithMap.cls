Apex

public class AccountWrapper {

    public Account account;

    public Map<String, String> accountMetadata;
}

AccountWrapper wrapper =
    new AccountWrapper();

wrapper.account = new Account(
    Name = 'ABC Corp'
);

wrapper.accountMetadata =
    new Map<String, String>();

wrapper.accountMetadata.put(
    'Source',
    'Website'
);

wrapper.accountMetadata.put(
    'Region',
    'India'
);

System.debug(wrapper.accountMetadata);


