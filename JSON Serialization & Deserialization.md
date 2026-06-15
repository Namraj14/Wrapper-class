# JSON Serialization & Deserialization in Apex

## What is Serialization?

Serialization converts an Apex object into a JSON string.

### Syntax

```apex id="a0f6n7"
String jsonString = JSON.serialize(object);
```

### Example

```apex id="r2n5m9"
Account acc = new Account(
    Name = 'ABC Corp'
);

String jsonString = JSON.serialize(acc);
```

### Output

```json id="y5w1x3"
{
  "Name":"ABC Corp"
}
```

### Memory Trick

```text id="z9c4d8"
Serialize
=
Object → String
```

---

## Why Do We Use Serialization?

JSON is a platform-independent format used to exchange data between systems.

Common use cases:

* External APIs
* REST Integrations
* Lightning Web Components (LWC)
* Aura Components
* Mobile Applications
* Third-Party Systems

### Flow

```text id="p7j2k6"
Apex Object
     ↓
JSON.serialize()
     ↓
JSON String
     ↓
External System / LWC / API
```

---

## What is Deserialization?

Deserialization converts a JSON string into an Apex object.

### Syntax

```apex id="n4q8v1"
Object obj =
    JSON.deserialize(
        jsonString,
        Object.class
    );
```

### Example

JSON:

```json id="b6m3t5"
{
  "name":"Raj",
  "age":28
}
```

Wrapper:

```apex id="f1r9w2"
public class EmployeeWrapper {
    public String name;
    public Integer age;
}
```

Deserialization:

```apex id="u8c5s7"
EmployeeWrapper emp =
    (EmployeeWrapper)
    JSON.deserialize(
        jsonString,
        EmployeeWrapper.class
    );
```

Result:

```apex id="g3k7p4"
emp.name = 'Raj';
emp.age = 28;
```

### Memory Trick

```text id="j2x6n8"
Deserialize
=
String → Object
```

---

## Serialization vs Deserialization

| Operation   | Conversion           |
| ----------- | -------------------- |
| Serialize   | Object → JSON String |
| Deserialize | JSON String → Object |

### Quick Memory Formula

```text id="m9v4q7"
Serialize
Pack Data

Deserialize
Unpack Data
```

---

## Extra JSON Fields

### JSON

```json id="c5t8r2"
{
  "name":"Raj",
  "age":28,
  "city":"Mumbai"
}
```

### Wrapper

```apex id="k1p6w9"
public class EmployeeWrapper {
    public String name;
    public Integer age;
}
```

### Result

```apex id="x7n2f4"
emp.name = 'Raj';
emp.age = 28;
```

The `city` field is ignored because no matching field exists in the wrapper.

### Rule

```text id="q4d8m1"
Extra JSON Fields
=
Ignored
```

---

## Missing JSON Fields

### JSON

```json id="h6v9r3"
{
  "name":"Raj"
}
```

### Wrapper

```apex id="t2k5p8"
public class EmployeeWrapper {
    public String name;
    public Integer age;
}
```

### Result

```apex id="d8r1m6"
emp.name = 'Raj';
emp.age = null;
```

### Rule

```text id="w5j7n2"
Missing JSON Fields
=
Null
```

---

## JSON Mapping Rule

Salesforce automatically maps JSON keys to matching Apex fields.

### JSON

```json id="p3v6k9"
{
  "name":"Raj",
  "age":28
}
```

### Wrapper

```apex id="n7r4d1"
public class EmployeeWrapper {
    public String name;
    public Integer age;
}
```

### Automatic Mapping

```apex id="s8m2q5"
name → emp.name
age  → emp.age
```

No manual assignment is required.

---

## Most Asked Interview Questions

### What is Serialization?

Serialization is the process of converting an Apex object into a JSON string.

---

### What is Deserialization?

Deserialization is the process of converting a JSON string into an Apex object.

---

### Why is JSON Used?

JSON is a lightweight, platform-independent format used to exchange data between Salesforce and external systems.

---

### What Happens if JSON Contains Extra Fields?

Extra fields are ignored during deserialization.

---

### What Happens if JSON is Missing Fields?

The corresponding Apex fields are populated with `null`.

---

## Final Memory Formula

```text id="v1q8m3"
Apex Object
     ↓
JSON.serialize()
     ↓
JSON String
     ↓
Send to API / LWC / External System
     ↓
JSON.deserialize()
     ↓
Apex Object
```
# Designing Wrapper Classes from JSON

One of the most common Salesforce integration tasks is converting a JSON payload into Apex Wrapper Classes.

## Golden Rules

### Rule 1: Curly Braces `{}` = Wrapper Class

JSON:

```json
{
    "customer": {
        "name": "ABC Corp",
        "city": "Mumbai"
    }
}
```

Wrapper:

```apex
public CustomerWrapper customer;
```

```apex
public class CustomerWrapper {
    public String name;
    public String city;
}
```

---

### Rule 2: Square Brackets `[]` = List

JSON:

```json
{
    "contacts":[
        {
            "name":"Raj"
        },
        {
            "name":"Amit"
        }
    ]
}
```

Wrapper:

```apex
public List<ContactWrapper> contacts;
```

```apex
public class ContactWrapper {
    public String name;
}
```

---

### Rule 3: Text Values = String

JSON:

```json
{
    "name":"Raj"
}
```

Wrapper:

```apex
public String name;
```

---

### Rule 4: Numbers = Usually Decimal

JSON:

```json
{
    "salary":50000
}
```

Wrapper:

```apex
public Decimal salary;
```

Common examples:

```text
Amount
Salary
Revenue
Balance
Price
Credit Limit
```

Use:

```apex
Decimal
```

---

### Rule 5: True / False = Boolean

JSON:

```json
{
    "isActive":true
}
```

Wrapper:

```apex
public Boolean isActive;
```

---

# Example 1: Nested Object

JSON:

```json
{
    "customer":{
        "name":"ABC Corp",
        "city":"Mumbai"
    },
    "isActive":true
}
```

Wrapper:

```apex
public class EmployeeWrapper {

    public CustomerWrapper customer;

    public Boolean isActive;
}

public class CustomerWrapper {

    public String name;

    public String city;
}
```

---

# Example 2: Array of Objects

JSON:

```json
{
    "customerName":"ABC Corp",
    "contacts":[
        {
            "name":"Raj"
        },
        {
            "name":"Amit"
        }
    ]
}
```

Wrapper:

```apex
public class CustomerWrapper {

    public String customerName;

    public List<ContactWrapper> contacts;
}

public class ContactWrapper {

    public String name;
}
```

---

# Example 3: Nested Object + Array + Boolean

JSON:

```json
{
    "account":{
        "name":"ABC Corp"
    },
    "contacts":[
        {
            "name":"Raj",
            "email":"raj@test.com"
        },
        {
            "name":"Amit",
            "email":"amit@test.com"
        }
    ],
    "isActive":true
}
```

Wrapper:

```apex
public class EmployeeWrapper {

    public AccountWrapper account;

    public List<ContactWrapper> contacts;

    public Boolean isActive;
}

public class AccountWrapper {

    public String name;
}

public class ContactWrapper {

    public String name;

    public String email;
}
```

---

# Important Mapping Rule

JSON Key:

```json
{
    "account":{ }
}
```

Wrapper:

```apex
public AccountWrapper account;
```

JSON Key:

```json
{
    "customer":{ }
}
```

Wrapper:

```apex
public CustomerWrapper customer;
```

JSON Key:

```json
{
    "contacts":[ ]
}
```

Wrapper:

```apex
public List<ContactWrapper> contacts;
```

### Remember

```text
JSON Key
      ↓
Wrapper Variable Name
```

The wrapper variable name should match the JSON key.

---

# Quick JSON-to-Wrapper Cheat Sheet

| JSON Structure    | Apex Wrapper                    |
| ----------------- | ------------------------------- |
| `"name":"Raj"`    | `String name`                   |
| `"salary":50000`  | `Decimal salary`                |
| `"isActive":true` | `Boolean isActive`              |
| `"customer":{}`   | `CustomerWrapper customer`      |
| `"account":{}`    | `AccountWrapper account`        |
| `"contacts":[]`   | `List<ContactWrapper> contacts` |

---

# Memory Formula

```text
{}  → Wrapper Class

[]  → List<Wrapper>

Text → String

Number → Decimal

True/False → Boolean
```

Whenever you receive JSON:

1. Find all `{}` → Create Wrapper Classes.
2. Find all `[]` → Create Lists.
3. Find all text values → String.
4. Find all numbers → Decimal.
5. Find all true/false values → Boolean.

This approach can be used to design most Salesforce integration wrapper classes.

# Understanding `{}` vs `[]` in JSON

This is one of the most important concepts in Salesforce integrations.

## Rule

```text
{}  → Wrapper Class

[]  → List<Wrapper>
```

---

# Example 1: Curly Braces `{}` = Wrapper Class

## JSON

```json
{
    "customer":{
        "name":"ABC Corp",
        "city":"Mumbai"
    }
}
```

Notice:

```json
"customer":{
    "name":"ABC Corp",
    "city":"Mumbai"
}
```

The value of `customer` is enclosed within:

```text
{}
```

which means it is a single object.

---

## Apex Wrapper

```apex
public class ResponseWrapper {

    public CustomerWrapper customer;
}

public class CustomerWrapper {

    public String name;

    public String city;
}
```

---

## Visual Mapping

JSON:

```json
{
    "customer":{
        "name":"ABC Corp",
        "city":"Mumbai"
    }
}
```

Wrapper:

```text
ResponseWrapper
│
└── customer
      │
      ├── name
      └── city
```

---

# Example 2: Square Brackets `[]` = List<Wrapper>

## JSON

```json
{
    "contacts":[
        {
            "name":"Raj"
        },
        {
            "name":"Amit"
        }
    ]
}
```

Notice:

```json
"contacts":[
    { },
    { }
]
```

The value of `contacts` is enclosed within:

```text
[]
```

which means multiple objects.

---

## Apex Wrapper

```apex
public class ResponseWrapper {

    public List<ContactWrapper> contacts;
}

public class ContactWrapper {

    public String name;
}
```

---

## Visual Mapping

JSON:

```json
{
    "contacts":[
        {
            "name":"Raj"
        },
        {
            "name":"Amit"
        }
    ]
}
```

Wrapper:

```text
ResponseWrapper
│
└── contacts
      │
      ├── ContactWrapper
      │      └── Raj
      │
      └── ContactWrapper
             └── Amit
```

---

# Side-by-Side Comparison

## Single Object

JSON:

```json
{
    "customer":{
        "name":"ABC Corp"
    }
}
```

Wrapper:

```apex
public CustomerWrapper customer;
```

Reason:

```text
{}
=
One Object
=
One Wrapper
```

---

## Multiple Objects

JSON:

```json
{
    "customers":[
        {
            "name":"ABC Corp"
        },
        {
            "name":"XYZ Corp"
        }
    ]
}
```

Wrapper:

```apex
public List<CustomerWrapper> customers;
```

Reason:

```text
[]
=
Multiple Objects
=
List<Wrapper>
```

---

# Interview Example

## JSON

```json
{
    "status":"SUCCESS",
    "data":{
        "accountName":"ABC Corp"
    }
}
```

Wrapper:

```apex
public DataWrapper data;
```

Because:

```text
data = {}
```

---

## JSON

```json
{
    "status":"SUCCESS",
    "data":[
        {
            "accountName":"ABC Corp"
        },
        {
            "accountName":"XYZ Corp"
        }
    ]
}
```

Wrapper:

```apex
public List<DataWrapper> data;
```

Because:

```text
data = []
```

---

# Quick Memory Trick

```text
{} = One Thing
   = Wrapper

[] = Many Things
   = List<Wrapper>
```

Whenever you receive JSON:

1. Find `{}` → Create Wrapper Classes.
2. Find `[]` → Create Lists.
3. Find text values → String.
4. Find numeric values → Decimal.
5. Find true/false values → Boolean.

This approach works for most Salesforce integration payloads.
