public class AccountCheckboxWrapper {

    public Account acc;

    public Boolean isSelected;
}

AccountCheckboxWrapper wrapper =
    new AccountCheckboxWrapper();

wrapper.acc = new Account(
    Name = 'ABC Corp'
);

wrapper.isSelected = true;

System.debug(wrapper.acc.Name);
System.debug(wrapper.isSelected);
