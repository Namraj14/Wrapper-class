# Wrapper-class

# Salesforce Wrapper Class - Complete Guide

## What is a Wrapper Class?

A Wrapper Class is a custom Apex class that groups multiple related data elements into a single object.

It can contain:

* Salesforce objects (Account, Contact, Opportunity, etc.)
* Collections (List, Set, Map)
* Primitive data types (String, Integer, Boolean, Decimal)
* Custom values used by the UI

Think of a Wrapper Class as a container that carries multiple pieces of related information together.

---

## Why Do We Use Wrapper Classes?

Wrapper classes are commonly used when:

* Combining data from multiple objects
* Sending complex data from Apex to LWC/Aura/Visualforce
* Adding UI-specific fields such as checkboxes
* Structuring API request and response payloads

---

## Basic Example

```apex
public class StudentWrapper {
    public String name;
    public Integer marks;
}
```

Usage:

```apex
StudentWrapper sw = new StudentWrapper();
sw.name = 'Raj';
sw.marks = 90;
```

---

## Wrapper with Salesforce Objects

```apex
public class AccountContactWrapper {
    public Account acc;
    public List<Contact> contacts;
}
```

Usage:

```apex
AccountContactWrapper acw = new AccountContactWrapper();
acw.acc = accountRecord;
acw.contacts = contactList;
```

---

## Common Interview Example

Displaying Accounts with a checkbox:

```apex
public class AccountWrapper {
    public Account acc;
    public Boolean isSelected;
}
```

Usage:

```apex
List<AccountWrapper> wrappers = new List<AccountWrapper>();

for(Account acc : accountList) {
    AccountWrapper aw = new AccountWrapper();
    aw.acc = acc;
    aw.isSelected = false;
    wrappers.add(aw);
}
```

---

## Wrapper Class with Constructor

```apex
public class AccountWrapper {

    public Account acc;
    public Boolean isSelected;

    public AccountWrapper(Account acc, Boolean isSelected) {
        this.acc = acc;
        this.isSelected = isSelected;
    }
}
```

Usage:

```apex
AccountWrapper aw = new AccountWrapper(acc, false);
```

---

## Wrapper Class in LWC

Apex:

```apex
public class EmployeeWrapper {

    @AuraEnabled
    public String name;

    @AuraEnabled
    public Integer age;
}
```

```apex
@AuraEnabled
public static EmployeeWrapper getEmployee() {

    EmployeeWrapper emp = new EmployeeWrapper();
    emp.name = 'Raj';
    emp.age = 28;

    return emp;
}
```

Response sent to LWC:

```json
{
  "name": "Raj",
  "age": 28
}
```

---

## Advantages

* Combines multiple data types into one object
* Simplifies Apex-to-LWC communication
* Improves code readability
* Provides strong typing
* Useful for complex UI requirements

---

## Limitations

* Additional code to maintain
* Consumes more heap memory
* Larger payloads when serialized to JSON
* Can become difficult to manage if overloaded with fields

---

## When to Use

✅ Combining Account + Contact + Opportunity data

✅ Sending custom data structures to LWC

✅ UI checkboxes and temporary values

✅ API request and response models

✅ Complex dashboards and reservation systems

---

## When Not to Use

❌ When a standard Salesforce object is sufficient

❌ When only a single field/value is needed

❌ When there is no need to combine multiple data sources

---

## Interview Definition

A Wrapper Class in Salesforce is a custom Apex class used to encapsulate multiple related data elements, including Salesforce records, collections, and primitive data types, into a single object for easier processing and transfer between Apex, LWC, Aura, Visualforce, or external systems.

---

## Quick Memory Trick

**Object = Item**

```text
Account
Contact
Opportunity
```

**Wrapper = Bag**

```text
Account
+ Contact
+ Opportunity
+ Boolean
+ String
```

If you need to carry multiple related pieces of information together, use a Wrapper Class.

## Wrapper Class Example: Account with Checkbox Selection

### Wrapper Class

##### Example1
```apex
public class AccountWrapper {
    public Account acc;
    public Boolean isSelected;
}
```

### Using the Wrapper

```apex
AccountWrapper aw = new AccountWrapper();

List<Account> accList = new List<Account>();

accList.add(
    new Account(
        Name = 'ABC Corp'
    )
);

aw.acc = accList[0];
aw.isSelected = true;
```

### Explanation

In this example, the wrapper class combines:

* An `Account` record
* A custom Boolean field (`isSelected`)

The `Account` object does not have a field that represents whether a user has selected the record in the UI. The wrapper allows us to store both the Salesforce record and the UI-specific state together.


### Common Use Case

This pattern is commonly used in:

* Lightning Web Components (LWC)
* Aura Components
* Visualforce Pages

Example UI:

```text
☑ ABC Corp
☐ XYZ Corp
☐ Test Corp
```
## Wrapper Class Example: Account and Related Contacts

### Wrapper Class
#### Example 2
```apex
public class AccountWrapper {
    public Account acc;
    public List<Contact> contacts;
}
```

### Creating and Populating the Wrapper

```apex
Account a = new Account(
    Name = 'ABC'
);

List<Contact> con = new List<Contact>();

for(Integer i = 0; i <= 2; i++) {

    Contact cont = new Contact();
    cont.LastName = 'xyz' + i;

    con.add(cont);
}

AccountWrapper aw = new AccountWrapper();

aw.acc = a;
aw.contacts = con;
```

### Explanation

This wrapper combines:

* An `Account` record
* A `List<Contact>` containing related contacts

Instead of sending the Account and Contacts separately, the wrapper groups them into a single object.

# Wrapper Class Design Rules & Memory Tricks

## Rule 1: Ask "Can a Single Object Solve This?"

If all required data comes from a single object, a wrapper is usually not needed.

### Example

```text
Account Name
Account Phone
Account Industry
```

All fields belong to the Account object.

```apex
List<Account> accounts;
```

✅ No Wrapper Needed

---

## Rule 2: Multiple Objects = Wrapper

If the required data comes from multiple objects, use a wrapper.

### Example

```text
Account Name
Contact Name
Opportunity Name
```

Data comes from:

```text
Account
Contact
Opportunity
```

✅ Wrapper Needed

---

## Rule 3: Calculated Data = Wrapper

Use a wrapper when you need to send calculated values that do not exist on the object.

### Example

```text
Account Name
Total Contacts
```

```apex
Integer totalContacts;
```

`totalContacts` is calculated in Apex.

✅ Wrapper Needed

---

## Rule 4: UI-Specific Fields = Wrapper

Use a wrapper when the UI requires additional fields that do not exist on the Salesforce object.

### Example

```text
Account Name
Checkbox Selected/Not Selected
```

```apex
public Account acc;
public Boolean isSelected;
```

The Account object does not contain an `isSelected` field.

✅ Wrapper Needed

---

## Rule 5: One Record = Single Object

When the wrapper represents a single record, use a single object.

### Example

```text
Workspace Name
Building Name
Floor Name
```

```apex
public Workspace__c workspace;
```

✅ Correct

```apex
public List<Workspace__c> workspaces;
```

❌ Incorrect for a single record

---

## Rule 6: Multiple Records = List

When the wrapper represents multiple records, use a list.

### Example

```text
Account
All Related Contacts
```

```apex
public Account acc;
public List<Contact> contacts;
```

✅ Correct

---

## Rule 7: Send Only What the UI Needs

Avoid sending entire objects when only a few fields are required.

### Bad Design

```apex
public Building__c building;
```

If the UI only displays:

```text
Building Name
```

### Better Design

```apex
public String buildingName;
```

Benefits:

* Smaller payload
* Better performance
* Easier maintenance

---

## Rule 8: Wrapper = Custom Container

A Wrapper Class is simply a custom container.

It can store:

```apex
Account
Contact
Opportunity
String
Integer
Boolean
Decimal
List
Map
Custom Classes
Other Wrappers
```

---

## Rule 9: Wrapper Does Not Create Records

A wrapper only stores data.

### Example

```apex
AccountWrapper aw = new AccountWrapper();
```

This does NOT create an Account record.

It only creates a wrapper object in memory.

---

## Rule 10: Think of a Wrapper as a School Bag

### Individual Items

```text
Account     = Book
Contact     = Notebook
Boolean     = Pen
String      = ID Card
```

### Wrapper

```text
School Bag
```

The bag carries everything together.

This is exactly what a Wrapper Class does.

---

# Common Interview Questions

## What is a Wrapper Class?

A Wrapper Class is a custom Apex class used to combine multiple related pieces of data into a single object.

---

## Why Do We Use Wrapper Classes?

* Combine data from multiple objects
* Send calculated values
* Add UI-specific fields
* Transfer structured data to LWC, Aura, Visualforce, or APIs

---

## Most Common Use Case

Displaying records with a checkbox.

### Example

```apex
public class AccountWrapper {
    public Account acc;
    public Boolean isSelected;
}
```

---

## Wrapper vs Map

### Wrapper

```apex
wrapper.acc;
wrapper.isSelected;
```

### Map

```apex
map.get('acc');
map.get('selected');
```

Advantages of Wrapper:

* Strongly typed
* Easier to read
* Easier to maintain
* Better code completion support

---

## Can a Wrapper Contain Lists?

Yes.

```apex
public List<Contact> contacts;
```

---

## Can a Wrapper Contain Salesforce Objects?

Yes.

```apex
public Account acc;
```

---

## Can a Wrapper Contain Another Wrapper?

Yes.

```apex
public AddressWrapper address;
```

---

# Wrapper Class Decision Formula

Before creating a wrapper, ask:

```text
Is my data coming from:
1. Multiple Objects?
OR
2. Calculated Values?
OR
3. UI-Specific Fields?
```

If the answer is YES to any of the above:

✅ Use a Wrapper Class

If the answer is NO:

✅ Return the Salesforce Object Directly

---

# Quick Memory Formula

```text
Single Object + Existing Fields
= No Wrapper

Multiple Objects
= Wrapper

Calculated Values
= Wrapper

UI-Specific Fields
= Wrapper
```

Remember:

```text
Wrapper = Custom Container for Related Data
```
