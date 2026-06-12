# When to Use a Single Object vs List of Objects in a Wrapper Class

## 1. Use a Single Object

Use a single object when the wrapper represents **one row of data**.

### Example

```text
Workspace Name: WS-101
Building Name: Tower A
Floor Name: 5th Floor
Available Seats: 12
```

Notice that this represents:

* One Workspace
* One Building Name
* One Floor Name
* One Available Seat Count

### Wrapper Design

```apex
public class WorkspaceWrapper {
    public Workspace__c workspace;
    public String buildingName;
    public String floorName;
    public Integer availableSeats;
}
```

### Why?

The UI is displaying information for a single workspace record. Therefore, a single `Workspace__c` object is sufficient.

---

## 2. Use a List of Objects

Use a list when the wrapper needs to represent **multiple records**.

### Example

```text
Many Workspaces
Many Buildings
Many Floors
```

### Wrapper Design

```apex
public class WorkspaceWrapper {
    public List<Workspace__c> workspaces;
    public List<Building__c> buildings;
    public List<Floor__c> floors;
    public Integer availableSeats;
}
```

### Why?

The wrapper is now holding collections of records rather than a single record.

---

## Rule of Thumb

### Use a Single Object When:

* The UI displays one record.
* The wrapper represents one row.
* Only one object instance is required.

Example:

```apex
public Account acc;
public Contact con;
public Workspace__c workspace;
```

---

### Use a List When:

* The UI displays multiple records.
* The wrapper represents a collection of data.
* Multiple object instances are required.

Example:

```apex
public List<Account> accounts;
public List<Contact> contacts;
public List<Workspace__c> workspaces;
```

---

## Quick Memory Trick

### Single Record

```text
1 Account
1 Contact
1 Workspace
```

Use:

```apex
Account acc;
Contact con;
Workspace__c workspace;
```

### Multiple Records

```text
Many Accounts
Many Contacts
Many Workspaces
```

Use:

```apex
List<Account> accounts;
List<Contact> contacts;
List<Workspace__c> workspaces;
```

### Key Principle

Ask yourself:

"Am I representing one record or many records?"

* One record → Use a single object.
* Many records → Use a `List<Object>`.
