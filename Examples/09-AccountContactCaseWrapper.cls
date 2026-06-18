public class AccountContactCaseWrapper {

    public List<Account> accList;

    public List<Contact> conList;

    public List<Case> caseList;
}

String jsonResponse = '{
    "accList":[
        {
            "Id":"001xx000001ABC",
            "Name":"Acme Inc",
            "Industry":"Technology",
            "Rating":"Hot",
            "AnnualRevenue":5000000
        }
    ],
    "conList":[
        {
            "Id":"003xx000001ABC",
            "FirstName":"John",
            "LastName":"Doe",
            "Email":"john.doe@example.com"
        }
    ],
    "caseList":[
        {
            "Id":"500xx000001ABC",
            "CaseNumber":"00001001",
            "Priority":"High",
            "Subject":"Login Issue"
        }
    ]
}';

AccountContactCaseWrapper response =
    (AccountContactCaseWrapper)
    JSON.deserialize(
        jsonResponse,
        AccountContactCaseWrapper.class
    );

System.debug(response.accList);
System.debug(response.conList);
System.debug(response.caseList);
