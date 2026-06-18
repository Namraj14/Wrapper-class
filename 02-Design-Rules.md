# Wrapper Classes in Salesforce - Design Rules

## Why Design Rules Matter

A Wrapper Class can quickly become difficult to understand if it is not designed properly.

Good Wrapper Design helps:

* Improve readability
* Reduce complexity
* Simplify maintenance
* Improve performance
* Make integrations easier to understand

---

# Rule 1: Single Record → Object

If you need only one record, use a single object.

### Example

Displaying one Account:

```apex
public class AccountWrapper {

    public Account acc;
}
```

### Visual

```text
AccountWrapper
│
└── Account
```

### Use Case

```text
Account Detail Page
Single Customer Record
Single Workspace Record
```

---

# Rule 2: Multiple Records → List<Object>

If you need multiple records, use a List.

### Example

Displaying multiple Contacts:

```apex
public class AccountWrapper {

    public List<Contact> contacts;
}
```

### Visual

```text
AccountWrapper
│
└── List<Contact>
```

### Use Case

```text
Related Contacts
Search Results
Datatables
```

---

# Rule 3: Use Wrapper Only When Needed

Wrong:

```apex
public class AccountWrapper {

    public Account acc;
}
```

If only Account data is required:

```apex
Account acc;
```

is enough.

### Rule

```text
One Object
No Extra Fields

→ No Wrapper Needed
```

---

# Rule 4: Group Related Data Together

Good Example:

```apex
public class AccountContactWrapper {

    public Account account;

    public List<Contact> contacts;
}
```

Reason:

```text
Account
+
Related Contacts
```

belong together.

---

# Rule 5: Add UI-Specific Fields in Wrapper

Sometimes the UI needs fields that do not exist in Salesforce.

Example:

```apex
public class AccountWrapper {

    public Account acc;

    public Boolean isSelected;
}
```

### Use Cases

```text
Checkboxes
Row Selection
Expand/Collapse
Icons
Buttons
```

---

# Rule 6: Store Calculated Values in Wrapper

Example:

```apex
public class AccountWrapper {

    public Account acc;

    public Integer totalContacts;
}
```

The Account object does not have:

```text
Total Contacts
```

The wrapper stores this calculated value.

---

# Rule 7: Keep Wrapper Focused

Bad Design:

```apex
public class MegaWrapper {

    public Account account;

    public Contact contact;

    public Case caseRecord;

    public Opportunity opp;

    public Lead lead;

    public User owner;
}
```

Too much unrelated data.

Good Design:

```apex
public class AccountCaseWrapper {

    public Account account;

    public List<Case> cases;
}
```

### Rule

```text
One Purpose
One Wrapper
```

---

# Rule 8: Use Meaningful Names

Bad:

```apex
public class DataWrapper {

    public Account a;

    public List<Contact> c;
}
```

Good:

```apex
public class AccountContactWrapper {

    public Account account;

    public List<Contact> contacts;
}
```

### Rule

```text
Names Should Explain Purpose
```

---

# Rule 9: Avoid Duplicate Data

Bad:

```apex
public class AccountWrapper {

    public Account account;

    public String accountName;
}
```

Account already contains:

```text
Name
```

No need to store it again.

Good:

```apex
public class AccountWrapper {

    public Account account;
}
```

---

# Rule 10: Use Nested Wrappers for Nested Data

Example:

```apex
public class CustomerWrapper {

    public AccountWrapper account;

    public List<ContactWrapper> contacts;
}
```

Useful for:

```text
Complex JSON
API Responses
Nested Data Structures
```

---

# Rule 11: Match JSON Keys with Wrapper Variables

JSON:

```json
{
    "account":{
        "name":"ABC Corp"
    }
}
```

Wrapper:

```apex
public AccountWrapper account;
```

Not:

```apex
public AccountWrapper customer;
```

### Rule

```text
JSON Key
        ↓
Wrapper Variable Name
```

---

# Rule 12: Use Salesforce Objects Directly When Possible

JSON:

```json
{
    "Id":"001...",
    "Name":"ABC Corp"
}
```

Use:

```apex
Account account;
```

No custom wrapper needed.

---

# Rule 13: Create Custom Wrapper for Custom Data

JSON:

```json
{
    "accountName":"ABC Corp",
    "totalContacts":5
}
```

Use:

```apex
public class AccountWrapper {

    public String accountName;

    public Integer totalContacts;
}
```

Reason:

```text
Custom Structure
```

does not match Account object.

---

# Rule 14: Wrapper Classes Are Temporary Containers

A Wrapper Class:

```text
Does Not Create Records
Does Not Store Data in Database
Does Not Replace Objects
```

It only helps move data around.

Think:

```text
Wrapper = Container
Object = Record
```

---

# Wrapper Design Decision Tree

```text
Need Only One Salesforce Object?
            │
            ├── YES
            │
            │  Extra Fields Needed?
            │
            │       ├── NO
            │       │
            │       └── Use Object Directly
            │
            │
            │       └── YES
            │
            │            Use Wrapper
            │
            └── NO
                 │
                 Multiple Objects?
                 │
                 YES
                 │
                 Use Wrapper
```

---

# Common Design Patterns

## Pattern 1

Account + Checkbox

```apex
public Account acc;

public Boolean isSelected;
```

---

## Pattern 2

Account + Contacts

```apex
public Account account;

public List<Contact> contacts;
```

---

## Pattern 3

Account + Contact Count

```apex
public Account account;

public Integer totalContacts;
```

---

## Pattern 4

API Response

```apex
public Boolean success;

public String message;

public List<DataWrapper> data;
```

---

## Pattern 5

Nested JSON

```apex
public AccountWrapper account;

public List<ContactWrapper> contacts;
```

---

# Memory Tricks

## Object vs List

```text
One Record
    ↓
Object

Many Records
    ↓
List<Object>
```

---

## Wrapper Need

```text
Multiple Objects?
Extra Fields?
Calculated Values?
Custom JSON?

YES
 ↓
Wrapper Class
```

---

## Wrapper Purpose

```text
Wrapper
    ↓
Group Data

Object
    ↓
Store Data
```

---

# Quick Revision Sheet

```text
Single Record → Object

Multiple Records → List

One Object + No Extra Fields
→ No Wrapper

Multiple Objects
→ Wrapper

UI Fields
→ Wrapper

Calculated Values
→ Wrapper

Custom JSON
→ Wrapper

Salesforce Fields
→ Use Salesforce Object

Custom Structure
→ Use Wrapper

Wrapper = Container

Object = Record
```

