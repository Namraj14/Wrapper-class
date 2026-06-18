Apex

public class AccountWrapper {

    @AuraEnabled
    public Account account;

    @AuraEnabled
    public Boolean isSelected;

    @AuraEnabled
    public Integer totalContacts;
}

Apex Method

@AuraEnabled(cacheable=true)
public static AccountWrapper getAccountData() {

    AccountWrapper wrapper =
        new AccountWrapper();

    wrapper.account = new Account(
        Name = 'ABC Corp'
    );

    wrapper.isSelected = true;

    wrapper.totalContacts = 5;

    return wrapper;
}

Javascript

getAccountData()
    .then(result => {

        this.wrapperResult = result;

        console.log(
            this.wrapperResult.account.Name
        );

        console.log(
            this.wrapperResult.isSelected
        );

        console.log(
            this.wrapperResult.totalContacts
        );
    });

