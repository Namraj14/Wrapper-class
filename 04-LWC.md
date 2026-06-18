# Wrapper Classes in Salesforce - LWC

## Introduction

Wrapper Classes are widely used in Lightning Web Components (LWC) to send and receive complex data between Apex and LWC.

Instead of sending multiple variables separately, a Wrapper Class allows us to send everything in a single object.

---

# Why Use Wrapper Classes in LWC?

Without Wrapper:

```text
Account
Contacts
Checkbox
Total Contacts
Status
```

would need to be sent separately.

With Wrapper:

```text
Wrapper
│
├── Account
├── Contacts
├── Checkbox
├── Total Contacts
└── Status
```

Everything travels together.

---

# Rule for LWC

If a Wrapper Class needs to be accessed in LWC:

```apex
@AuraEnabled
```

must be added.

---

# Basic Wrapper for LWC

```apex
public class AccountWrapper {

    @AuraEnabled
    public Account acc;

    @AuraEnabled
    public Boolean isSelected;
}
```

---

# Why @AuraEnabled?

Without:

```apex
@AuraEnabled
```

LWC cannot access the field.

Think:

```text
Apex
 │
 └── @AuraEnabled
         ↓
       LWC
```

---

# Scenario 1: Account + Checkbox

## Apex Wrapper

```apex
public class AccountWrapper {

    @AuraEnabled
    public Account acc;

    @AuraEnabled
    public Boolean isSelected;
}
```

---

## Apex Method

```apex
@AuraEnabled(cacheable=true)
public static AccountWrapper getAccount() {

    AccountWrapper aw =
        new AccountWrapper();

    aw.acc = [
        SELECT Id, Name
        FROM Account
        LIMIT 1
    ];

    aw.isSelected = true;

    return aw;
}
```

---

## Data Sent to LWC

```json
{
    "acc": {
        "Id": "001xxxx",
        "Name": "ABC Corp"
    },
    "isSelected": true
}
```

---

# Receiving Wrapper in LWC

## JavaScript

```javascript
import getAccount
from '@salesforce/apex/AccountController.getAccount';

connectedCallback() {

    getAccount()
        .then(result => {

            this.wrapperResult = result;

        })
        .catch(error => {

            console.error(error);

        });
}
```

---

# Accessing Wrapper Data

## Account Name

```javascript
this.wrapperResult.acc.Name;
```

---

## Checkbox Value

```javascript
this.wrapperResult.isSelected;
```

---

# Visual Mapping

```text
Wrapper
│
├── acc
│     └── Name
│
└── isSelected
```

JavaScript:

```javascript
wrapperResult.acc.Name

wrapperResult.isSelected
```

---

# Scenario 2: Account + Contacts

## Wrapper

```apex
public class AccountWrapper {

    @AuraEnabled
    public Account acc;

    @AuraEnabled
    public List<Contact> contacts;
}
```

---

## Example Data

```json
{
    "acc": {
        "Name": "ABC Corp"
    },
    "contacts": [
        {
            "LastName": "Raj"
        },
        {
            "LastName": "Amit"
        }
    ]
}
```

---

# Accessing Contact Data

First Contact:

```javascript
this.wrapperResult.contacts[0].LastName;
```

Second Contact:

```javascript
this.wrapperResult.contacts[1].LastName;
```

---

# Looping Through Contacts

```javascript
for(let con of this.wrapperResult.contacts) {

    console.log(con.LastName);
}
```

---

# Scenario 3: Account + Contact Count

## Wrapper

```apex
public class AccountWrapper {

    @AuraEnabled
    public Account acc;

    @AuraEnabled
    public Integer totalContacts;
}
```

---

## JSON

```json
{
    "acc": {
        "Name": "ABC Corp"
    },
    "totalContacts": 15
}
```

---

## Accessing Data

```javascript
this.wrapperResult.totalContacts;
```

---

# Scenario 4: Datatable Checkbox Selection

## Wrapper

```apex
public class AccountWrapper {

    @AuraEnabled
    public Account acc;

    @AuraEnabled
    public Boolean isSelected;
}
```

---

## Use Cases

```text
Datatables

Multi-Select Rows

Bulk Update

Bulk Delete
```

---

# Scenario 5: UI Control Fields

Sometimes UI-specific fields are required.

Example:

```apex
public class AccountWrapper {

    @AuraEnabled
    public Account acc;

    @AuraEnabled
    public Boolean showButton;

    @AuraEnabled
    public String iconName;
}
```

---

## Why Wrapper?

Account does not contain:

```text
showButton

iconName
```

These fields exist only for the UI.

---

# Passing Wrapper from LWC to Apex

## Wrapper

```apex
public class AccountWrapper {

    @AuraEnabled
    public String accountName;

    @AuraEnabled
    public Boolean isSelected;
}
```

---

## Apex Method

```apex
@AuraEnabled
public static void saveData(
    AccountWrapper wrapperData
) {

    System.debug(wrapperData.accountName);

    System.debug(wrapperData.isSelected);
}
```

---

## JavaScript

```javascript
let wrapperData = {

    accountName : 'ABC Corp',

    isSelected : true
};

saveData({
    wrapperData : wrapperData
});
```

---

# JSON Structure Behind the Scenes

When LWC calls Apex:

```javascript
let wrapperData = {

    accountName : 'ABC Corp',

    isSelected : true
};
```

Salesforce converts it to:

```json
{
    "accountName":"ABC Corp",
    "isSelected":true
}
```

Then Apex automatically converts it back into:

```apex
AccountWrapper
```

using deserialization.

---

# Wrapper Flow Between Apex and LWC

```text
Apex Wrapper
      ↓
JSON
      ↓
LWC
      ↓
JSON
      ↓
Apex Wrapper
```

---

# Common Mistakes

## Missing @AuraEnabled

Wrong:

```apex
public class AccountWrapper {

    public Account acc;
}
```

LWC cannot access it.

---

Correct:

```apex
public class AccountWrapper {

    @AuraEnabled
    public Account acc;
}
```

---

## Wrong Access

Wrapper:

```apex
public Account acc;
```

Wrong:

```javascript
wrapperResult.Name
```

Correct:

```javascript
wrapperResult.acc.Name
```

---

## List Access

Wrapper:

```apex
public List<Contact> contacts;
```

Wrong:

```javascript
wrapperResult.contacts.LastName
```

Correct:

```javascript
wrapperResult.contacts[0].LastName
```

---

# Interview Questions

## Why use Wrapper Classes in LWC?

To send multiple pieces of data between Apex and LWC in a single object.

---

## Why use @AuraEnabled?

To expose Apex fields and methods to Lightning Components.

---

## Can Wrapper Classes contain Salesforce Objects?

Yes.

Example:

```apex
public Account acc;
```

---

## Can Wrapper Classes contain Lists?

Yes.

Example:

```apex
public List<Contact> contacts;
```

---

## Can LWC send Wrapper Classes to Apex?

Yes.

LWC sends JSON.

Salesforce automatically converts JSON into the Wrapper Class.

---

# Quick Revision Sheet

```text
Apex → LWC
      ↓
@AuraEnabled Required

Wrapper
      ↓
JSON
      ↓
LWC

wrapperResult.acc.Name

wrapperResult.contacts[0].LastName

Wrapper can contain:
    Account
    Contact
    Lists
    Boolean
    Integer
    String

UI Fields
      ↓
Wrapper

Checkbox
Icon
Button Visibility

Most Common Use:
    Datatables
    Parent Child Data
    UI Control Fields
    LWC ↔ Apex Communication
```

