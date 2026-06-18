# Wrapper Classes in Salesforce - Introduction

## What is a Wrapper Class?

A Wrapper Class is a custom Apex class used to group multiple pieces of data into a single object.

Think of a Wrapper Class as a container that can hold:

* Salesforce Objects
* Multiple Salesforce Objects
* Primitive Data Types
* Lists
* Calculated Values
* UI-specific Fields

### Real Life Analogy

Think of a school bag.

```text
School Bag
│
├── Books
├── Pens
├── Water Bottle
└── Lunch Box
```

A school bag groups different items together.

Similarly:

```text
Wrapper Class
│
├── Account
├── Contact
├── Boolean
└── Integer
```

groups different data together.

---

## Basic Example

```apex
public class StudentWrapper {

    public String studentName;

    public Integer marks;
}
```

Creating an object:

```apex
StudentWrapper sw = new StudentWrapper();

sw.studentName = 'Raj';

sw.marks = 95;
```

---

## Why Do We Use Wrapper Classes?

Salesforce objects can store only their own fields.

Example:

```apex
Account acc = new Account();
```

can store:

```text
Name
Industry
Rating
AnnualRevenue
```

but cannot store:

```text
Checkbox for UI
Total Contacts
Temporary Data
Contact List
Case List
```

Wrapper Classes solve this problem.

---

## Common Reasons to Use Wrapper Classes

### 1. Combine Multiple Objects

Example:

```apex
public class AccountContactWrapper {

    public Account account;

    public List<Contact> contacts;
}
```

Used when displaying:

```text
Account
+
Related Contacts
```

together.

---

### 2. Add UI Fields

Example:

```apex
public class AccountWrapper {

    public Account acc;

    public Boolean isSelected;
}
```

Used in:

* LWC Datatables
* Visualforce Pages
* Screen Flows

The checkbox does not exist on Account but is required for the UI.

---

### 3. Store Calculated Values

Example:

```apex
public class AccountWrapper {

    public Account acc;

    public Integer totalContacts;
}
```

The Account object does not have a Total Contacts field.

The wrapper stores this calculated value.

---

### 4. API Response Handling

Example:

```apex
public class ApiResponseWrapper {

    public Boolean success;

    public String message;

    public List<DataWrapper> data;
}
```

Used in:

* REST Integrations
* SOAP Integrations
* External APIs

---

### 5. Parent-Child Data

Example:

```apex
public class AccountCaseWrapper {

    public Account account;

    public List<Case> cases;
}
```

Used when displaying:

```text
Account
+
Related Cases
```

on one screen.

---

# Wrapper Class vs Salesforce Object

## Salesforce Object

A Salesforce Object represents a database record.

Example:

```apex
Account acc = new Account();
```

Can contain only Account fields.

```text
Name
Industry
Phone
Rating
AnnualRevenue
```

---

## Wrapper Class

A Wrapper Class is a custom container created by the developer.

Example:

```apex
public class AccountWrapper {

    public Account acc;

    public Boolean isSelected;

    public Integer totalContacts;
}
```

Can contain:

```text
Salesforce Objects
Lists
Booleans
Integers
Strings
Other Wrapper Classes
```

---

## Comparison Table

| Salesforce Object                | Wrapper Class                       |
| -------------------------------- | ----------------------------------- |
| Represents database record       | Represents custom data structure    |
| Stores actual Salesforce data    | Stores combined/custom data         |
| Limited to object fields         | Can contain anything                |
| Can be inserted/updated directly | Cannot be inserted/updated directly |
| Standard Salesforce structure    | Developer-defined structure         |

---

# When to Use Wrapper Classes

Use a Wrapper Class when:

### Multiple Objects Need to Travel Together

Example:

```text
Account
+
Contacts
```

---

### UI Requires Additional Fields

Example:

```text
Account
+
Checkbox
```

---

### You Need Calculated Values

Example:

```text
Account
+
Total Contacts
```

---

### Working with Complex JSON

Example:

```json
{
    "account":{
        "name":"ABC Corp"
    },
    "contacts":[]
}
```

---

### API Response Does Not Match Salesforce Objects

Example:

```json
{
    "success":true,
    "message":"Success"
}
```

---

### LWC Requires Custom Data Structure

Example:

```apex
public class AccountWrapper {

    @AuraEnabled
    public Account acc;

    @AuraEnabled
    public Boolean isSelected;
}
```

---

# When NOT to Use Wrapper Classes

Do NOT use a Wrapper Class when a Salesforce Object alone is sufficient.

Example:

```apex
List<Account> accounts =
[
    SELECT Id, Name
    FROM Account
];
```

No wrapper required.

---

Do NOT use a Wrapper Class if you only need one object and no extra fields.

Wrong:

```apex
public class AccountWrapper {

    public Account acc;
}
```

Correct:

```apex
Account acc;
```

---

# Decision Formula

Ask yourself:

```text
Do I need only one Salesforce Object?
            │
            ├── YES
            │      ↓
            │ Use Salesforce Object
            │
            └── NO
                   ↓
            Use Wrapper Class
```

Or:

```text
Multiple Objects?
Extra Fields?
Calculated Values?
Custom JSON?
UI Checkboxes?

YES
 ↓
Wrapper Class
```

---

# Key Takeaways

### Wrapper Class

```text
Custom Container
```

### Salesforce Object

```text
Database Record
```

### Wrapper Class Can Hold

```text
Objects
Lists
Strings
Booleans
Integers
Decimals
Other Wrappers
```

### Most Common Use Cases

```text
LWC
Integrations
REST APIs
Parent-Child Data
UI Checkboxes
Calculated Values
```

### Memory Trick

```text
Salesforce Object
        ↓
Stores Data

Wrapper Class
        ↓
Groups Data
```
