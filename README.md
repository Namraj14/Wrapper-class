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

#### Example
public class AccountWrapper {
    public Account acc;
    public Boolean isSelected;
}
#### Anonymous window
AccountWrapper acc = new AccountWrapper();
List<Account> accList = new List<Account>();
accList.add(new Account(
	Name = 'ABC Corp'
));
acc.acc= accList[0];
acc.isSelected = true;
