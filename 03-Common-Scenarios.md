# Wrapper Classes in Salesforce - Common Scenarios

## Introduction

The best way to understand Wrapper Classes is through real-world scenarios.

In Salesforce projects, Wrapper Classes are commonly used for:

* UI Development
* Lightning Web Components (LWC)
* Integrations
* Parent-Child Relationships
* Calculated Values
* Custom Data Structures

---

# Scenario 1: Account + Checkbox

## Requirement

Display Accounts in a datatable with a checkbox.

### Problem

Account object does not have:

```text
isSelected
```

field.

### Solution

Create a Wrapper Class.

```apex
public class AccountWrapper {

    public Account acc;

    public Boolean isSelected;
}
```

---

## Visual

```text
Account Name       Selected
--------------------------------
ABC Corp           ☑
XYZ Corp           ☐
```

---

## Why Wrapper?

```text
Account
+
Checkbox

Different Data Types
```

---

## Common Usage

* LWC Datatables
* Visualforce Pages
* Bulk Actions
* Multi-Select Screens

---

# Scenario 2: Account + Contacts

## Requirement

Display an Account and all its Contacts together.

### Wrapper

```apex
public class AccountContactWrapper {

    public Account account;

    public List<Contact> contacts;
}
```

---

## Visual

```text
ABC Corp
│
├── John Doe
├── Jane Smith
└── Mike Ross
```

---

## Why Wrapper?

```text
Account
+
Related Contacts
```

need to travel together.

---

## Common Usage

* Account Detail Screens
* Customer 360 Views
* Related Record Displays

---

# Scenario 3: Account + Cases

## Requirement

Show Account information with all open Cases.

### Wrapper

```apex
public class AccountCaseWrapper {

    public Account account;

    public List<Case> cases;
}
```

---

## Visual

```text
ABC Corp
│
├── Case 1001
├── Case 1002
└── Case 1003
```

---

## Common Usage

* Service Cloud
* Support Dashboards
* Customer Service Portals

---

# Scenario 4: Account + Opportunities

## Requirement

Show Account and related Opportunities.

### Wrapper

```apex
public class AccountOpportunityWrapper {

    public Account account;

    public List<Opportunity> opportunities;
}
```

---

## Visual

```text
ABC Corp
│
├── Opportunity A
├── Opportunity B
└── Opportunity C
```

---

## Common Usage

* Sales Cloud
* Pipeline Management
* Revenue Dashboards

---

# Scenario 5: Account + Contact Count

## Requirement

Display Account and total number of Contacts.

### Wrapper

```apex
public class AccountWrapper {

    public Account account;

    public Integer totalContacts;
}
```

---

## Example

```text
ABC Corp

Total Contacts: 15
```

---

## Why Wrapper?

Account object does not contain:

```text
Total Contacts
```

This value is calculated.

---

# Scenario 6: Account + Case Count

## Requirement

Display Account and number of open Cases.

### Wrapper

```apex
public class AccountWrapper {

    public Account account;

    public Integer openCaseCount;
}
```

---

## Example

```text
ABC Corp

Open Cases: 4
```

---

## Why Wrapper?

The value is calculated at runtime.

---

# Scenario 7: Workspace Reservation System

## Requirement

Display:

```text
Workspace Name
Building Name
Floor Name
Available Seats
```

### Wrapper

```apex
public class WorkspaceWrapper {

    public Workspace__c workspace;

    public String buildingName;

    public String floorName;

    public Integer availableSeats;
}
```

---

## Visual

```text
Workspace : WS-101
Building  : Tower A
Floor     : 5th Floor
Seats     : 12
```

---

## Why Wrapper?

Data comes from:

```text
Workspace
Building
Floor
Calculated Seats
```

---

# Scenario 8: API Response Wrapper

## API Response

```json
{
    "success": true,
    "message": "Records Retrieved"
}
```

### Wrapper

```apex
public class ApiResponseWrapper {

    public Boolean success;

    public String message;
}
```

---

## Why Wrapper?

The response does not match any Salesforce object.

---

# Scenario 9: API Response with Data

## JSON

```json
{
    "success": true,
    "message": "Records Retrieved",
    "data": [
        {
            "id": 101,
            "name": "ABC Corp"
        }
    ]
}
```

---

## Wrapper

```apex
public class ApiResponseWrapper {

    public Boolean success;

    public String message;

    public List<DataWrapper> data;
}

public class DataWrapper {

    public Integer id;

    public String name;
}
```

---

## Why Wrapper?

Custom API response structure.

---

# Scenario 10: Nested JSON Response

## JSON

```json
{
    "account": {
        "name": "ABC Corp"
    },
    "contacts": [
        {
            "name": "Raj"
        }
    ]
}
```

---

## Wrapper

```apex
public class CustomerWrapper {

    public AccountWrapper account;

    public List<ContactWrapper> contacts;
}

public class AccountWrapper {

    public String name;
}

public class ContactWrapper {

    public String name;
}
```

---

## Why Wrapper?

JSON contains:

```text
Nested Objects
+
Lists
```

---

# Scenario 11: Account + UI Icon

## Requirement

Show an icon beside each Account.

### Wrapper

```apex
public class AccountWrapper {

    public Account account;

    public String iconName;
}
```

---

## Example

```text
🏢 ABC Corp
🏢 XYZ Corp
🏢 Global Tech
```

---

## Common Usage

* LWC Datatables
* Dynamic Icons
* Record Status Indicators

---

# Scenario 12: Account + Row Actions

## Requirement

Control button visibility.

### Wrapper

```apex
public class AccountWrapper {

    public Account account;

    public Boolean showEditButton;

    public Boolean showDeleteButton;
}
```

---

## Example

```text
ABC Corp

[Edit] [Delete]
```

---

## Why Wrapper?

UI-specific fields do not exist on Account.

---

# Common Scenario Formula

## Use Wrapper When

```text
Object + Object

Account + Contacts

Account + Cases

Account + Opportunities
```

---

## Use Wrapper When

```text
Object + UI Fields

Account + Checkbox

Account + Icon

Account + Button Visibility
```

---

## Use Wrapper When

```text
Object + Calculated Values

Account + Contact Count

Account + Open Case Count
```

---

## Use Wrapper When

```text
Custom JSON

API Responses

Nested JSON

Complex Integrations
```

---

# Most Common Interview Examples

### Example 1

```apex
public Account acc;

public Boolean isSelected;
```

---

### Example 2

```apex
public Account account;

public List<Contact> contacts;
```

---

### Example 3

```apex
public Account account;

public Integer totalContacts;
```

---

### Example 4

```apex
public Boolean success;

public String message;

public List<DataWrapper> data;
```

---

### Example 5

```apex
public AccountWrapper account;

public List<ContactWrapper> contacts;
```

---

# Quick Revision Sheet

```text
Account + Checkbox
→ Wrapper

Account + Contacts
→ Wrapper

Account + Cases
→ Wrapper

Account + Opportunities
→ Wrapper

Account + Calculated Value
→ Wrapper

API Response
→ Wrapper

Nested JSON
→ Wrapper

UI Fields
→ Wrapper
```

