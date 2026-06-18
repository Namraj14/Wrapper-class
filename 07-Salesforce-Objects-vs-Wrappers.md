# Wrapper Classes in Salesforce - Salesforce Objects vs Custom Wrappers

## Introduction

One of the most common mistakes Salesforce developers make is creating Wrapper Classes when they are not needed.

Before creating a Wrapper Class, always ask:

```text
Can I use a Salesforce Object directly?
```

If the answer is yes, avoid creating unnecessary wrappers.

---

# Rule

```text
JSON matches Salesforce Object
            ↓
Use Salesforce Object

JSON contains Custom Structure
            ↓
Create Wrapper Class
```

---

# What is a Salesforce Object?

Examples:

```apex
Account
Contact
Case
Lead
Opportunity
User
```

These objects already exist in Salesforce and contain predefined fields.

Example:

```apex
Account acc = new Account();
```

contains:

```text
Id
Name
Industry
Phone
Rating
AnnualRevenue
```

---

# When to Use Salesforce Objects Directly

## Example 1

### JSON

```json
{
    "Id":"001xx000001ABC",
    "Name":"ABC Corp",
    "Industry":"Technology"
}
```

### Apex

```apex
Account acc;
```

No Wrapper Required.

---

## Why?

Because:

```text
Id
Name
Industry
```

already belong to Account.

---

# Example 2

### JSON

```json
{
    "Id":"003xx000001ABC",
    "FirstName":"Raj",
    "LastName":"Joshi",
    "Email":"raj@test.com"
}
```

### Apex

```apex
Contact con;
```

No Wrapper Required.

---

# Example 3

### JSON

```json
{
    "Id":"500xx000001ABC",
    "CaseNumber":"00001001",
    "Priority":"High",
    "Subject":"Login Issue"
}
```

### Apex

```apex
Case caseRecord;
```

No Wrapper Required.

---

# Example 4 - List of Accounts

### JSON

```json
[
    {
        "Id":"001xxx",
        "Name":"ABC Corp"
    },
    {
        "Id":"001yyy",
        "Name":"XYZ Corp"
    }
]
```

### Apex

```apex
List<Account> accounts;
```

No Wrapper Required.

---

# When to Create a Custom Wrapper

Create a Wrapper when the JSON does NOT match a Salesforce object.

---

## Example 1

### JSON

```json
{
    "accountName":"ABC Corp",
    "totalContacts":15
}
```

### Wrapper

```apex
public class AccountWrapper {

    public String accountName;

    public Integer totalContacts;
}
```

---

## Why?

Because:

```text
accountName
totalContacts
```

are not Account fields.

---

# Example 2

### JSON

```json
{
    "account":{
        "Name":"ABC Corp"
    },
    "isSelected":true
}
```

### Wrapper

```apex
public class AccountWrapper {

    public Account account;

    public Boolean isSelected;
}
```

---

## Why?

Account does not contain:

```text
isSelected
```

---

# Example 3

### JSON

```json
{
    "account":{
        "Name":"ABC Corp"
    },
    "contactCount":10
}
```

### Wrapper

```apex
public class AccountWrapper {

    public Account account;

    public Integer contactCount;
}
```

---

## Why?

```text
contactCount
```

is a calculated value.

It does not exist on Account.

---

# Real Project Example

Suppose you have:

```text
Account
Related Contacts
Open Cases
```

---

## Wrapper

```apex
public class Customer360Wrapper {

    public Account account;

    public List<Contact> contacts;

    public List<Case> cases;
}
```

---

## Why?

Because:

```text
Account
+
Contacts
+
Cases
```

cannot be represented by a single Salesforce object.

---

# Example from Integrations

### JSON

```json
{
    "success":true,
    "message":"Records Retrieved"
}
```

---

### Wrapper

```apex
public class ApiResponseWrapper {

    public Boolean success;

    public String message;
}
```

---

## Why?

No Salesforce object contains:

```text
success
message
```

---

# Account + Checkbox Example

## Wrong Approach

Create field:

```text
Account.IsSelected__c
```

just for UI purposes.

---

## Correct Approach

```apex
public class AccountWrapper {

    public Account acc;

    public Boolean isSelected;
}
```

---

## Why?

The checkbox exists only while the page is open.

No database storage is required.

---

# Using Salesforce Objects Inside Wrappers

Very common.

Example:

```apex
public class AccountWrapper {

    public Account account;

    public Boolean isSelected;
}
```

Wrapper contains:

```text
Salesforce Object
+
Custom Field
```

---

# Common Pattern

```apex
public class CustomerWrapper {

    public Account account;

    public List<Contact> contacts;

    public Integer totalContacts;
}
```

Contains:

```text
Salesforce Object
+
Salesforce Object List
+
Calculated Value
```

---

# Example from Your Practice

### JSON

```json
{
  "accList": [
    {
      "Id": "001...",
      "Name": "Acme Inc",
      "Industry": "Technology"
    }
  ],
  "conList": [
    {
      "Id": "003...",
      "FirstName": "John"
    }
  ],
  "caseList": [
    {
      "Id": "500...",
      "CaseNumber": "00001001"
    }
  ]
}
```

---

### Wrapper

```apex
public class AccountContactCaseWrapper {

    public List<Account> accList;

    public List<Contact> conList;

    public List<Case> caseList;
}
```

---

## Why No AccountWrapper?

Because:

```text
Account Fields
Contact Fields
Case Fields
```

already map directly to Salesforce objects.

---

# Comparison Table

| Scenario                | Use Salesforce Object | Use Wrapper |
| ----------------------- | --------------------- | ----------- |
| Account Data            | ✅                     | ❌           |
| Contact Data            | ✅                     | ❌           |
| Case Data               | ✅                     | ❌           |
| Account + Checkbox      | ❌                     | ✅           |
| Account + Contacts      | ❌                     | ✅           |
| Account + Contact Count | ❌                     | ✅           |
| API Response            | ❌                     | ✅           |
| Nested JSON             | ❌                     | ✅           |
| Parent + Child Data     | ❌                     | ✅           |

---

# Decision Tree

```text
Does JSON match a Salesforce Object?
            │
            ├── YES
            │
            │   Use Salesforce Object
            │
            └── NO
                │
                Create Wrapper
```

---

# Memory Tricks

## Salesforce Object

```text
Represents a Record
```

Examples:

```apex
Account

Contact

Case

Opportunity
```

---

## Wrapper Class

```text
Represents a Custom Structure
```

Examples:

```apex
Account + Checkbox

Account + Contacts

Account + Contact Count

API Response
```

---

# Interview Questions

## Can a Wrapper Class contain Salesforce Objects?

Yes.

Example:

```apex
public Account account;
```

---

## Can we use Salesforce Objects instead of Wrappers?

Yes, if the incoming JSON directly matches Salesforce fields.

---

## When should we avoid Wrapper Classes?

When a Salesforce Object alone can solve the requirement.

---

## Can a Wrapper contain multiple Salesforce Objects?

Yes.

Example:

```apex
public Account account;

public List<Contact> contacts;

public List<Case> cases;
```

---

# Quick Revision Sheet

```text
Salesforce Fields
        ↓
Use Salesforce Object

Custom Structure
        ↓
Use Wrapper

Account
Contact
Case
Opportunity
        ↓
Objects

Account + Checkbox
Account + Contacts
Account + Count
API Response
Nested JSON
        ↓
Wrappers

Object = Record

Wrapper = Container
```

