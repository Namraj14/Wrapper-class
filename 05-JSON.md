# Wrapper Classes in Salesforce - JSON

## Introduction

JSON (JavaScript Object Notation) is the most common format used to exchange data between Salesforce and external systems.

Wrapper Classes are heavily used with JSON because Salesforce needs a structure to store incoming and outgoing JSON data.

Think of a Wrapper Class as the Apex representation of JSON.

```text
JSON
 ↓
Wrapper Class

Wrapper Class
 ↓
JSON
```

---

# Why Use Wrapper Classes with JSON?

Suppose an API sends:

```json
{
    "success": true,
    "message": "Records Retrieved"
}
```

Salesforce needs somewhere to store:

```text
success
message
```

Solution:

```apex
public class ApiResponseWrapper {

    public Boolean success;

    public String message;
}
```

---

# JSON Basics

JSON consists of:

## Key-Value Pairs

```json
{
    "name":"Raj"
}
```

### Mapping

```apex
public String name;
```

---

## Multiple Fields

```json
{
    "name":"Raj",
    "age":23
}
```

### Mapping

```apex
public String name;

public Integer age;
```

---

# JSON Data Type Mapping

| JSON    | Apex    |
| ------- | ------- |
| "Raj"   | String  |
| 23      | Integer |
| 5000.50 | Decimal |
| true    | Boolean |
| false   | Boolean |
| null    | null    |

---

## Examples

JSON:

```json
{
    "name":"Raj"
}
```

Apex:

```apex
public String name;
```

---

JSON:

```json
{
    "age":23
}
```

Apex:

```apex
public Integer age;
```

---

JSON:

```json
{
    "salary":50000.50
}
```

Apex:

```apex
public Decimal salary;
```

---

JSON:

```json
{
    "isActive":true
}
```

Apex:

```apex
public Boolean isActive;
```

---

# Golden Rule 1

## Curly Braces `{}`

```text
{} = Object
```

Example:

```json
{
    "customer":{
        "name":"ABC Corp"
    }
}
```

### Wrapper

```apex
public class ResponseWrapper {

    public CustomerWrapper customer;
}

public class CustomerWrapper {

    public String name;
}
```

---

# Golden Rule 2

## Square Brackets `[]`

```text
[] = List
```

Example:

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

### Wrapper

```apex
public class ResponseWrapper {

    public List<ContactWrapper> contacts;
}

public class ContactWrapper {

    public String name;
}
```

---

# Memory Formula

```text
{} → Wrapper

[] → List<Wrapper>
```

This is the most important JSON rule.

---

# Simple JSON Example

## JSON

```json
{
    "success":true,
    "message":"Records Retrieved"
}
```

### Wrapper

```apex
public class ResponseWrapper {

    public Boolean success;

    public String message;
}
```

---

# JSON with Array

## JSON

```json
{
    "accounts":[
        {
            "name":"ABC Corp"
        },
        {
            "name":"XYZ Corp"
        }
    ]
}
```

### Wrapper

```apex
public class ResponseWrapper {

    public List<AccountWrapper> accounts;
}

public class AccountWrapper {

    public String name;
}
```

---

# JSON with Nested Object

## JSON

```json
{
    "account":{
        "name":"ABC Corp",
        "industry":"Technology"
    }
}
```

### Wrapper

```apex
public class ResponseWrapper {

    public AccountWrapper account;
}

public class AccountWrapper {

    public String name;

    public String industry;
}
```

---

# JSON with Nested Object and Array

## JSON

```json
{
    "account":{
        "name":"ABC Corp"
    },
    "contacts":[
        {
            "name":"Raj"
        }
    ]
}
```

### Wrapper

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

# Real API Example

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

# Salesforce Objects in JSON

Sometimes JSON directly matches Salesforce Objects.

## JSON

```json
{
    "Id":"001xxx",
    "Name":"ABC Corp"
}
```

### Use

```apex
Account account;
```

No custom wrapper needed.

---

# Salesforce Objects vs Wrapper Classes

## Use Salesforce Object

JSON:

```json
{
    "Id":"001xxx",
    "Name":"ABC Corp"
}
```

Apex:

```apex
Account account;
```

---

## Use Wrapper Class

JSON:

```json
{
    "accountName":"ABC Corp",
    "totalContacts":5
}
```

Apex:

```apex
public class AccountWrapper {

    public String accountName;

    public Integer totalContacts;
}
```

---

# JSON Key Matching Rule

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

Correct.

---

Wrong:

```apex
public AccountWrapper customer;
```

Because:

```text
JSON Key
     ↓
Wrapper Variable Name
```

must match.

---

# Common Mistakes

## Mistake 1

JSON:

```json
{
    "data":{
    }
}
```

Wrong:

```apex
List<DataWrapper> data;
```

Correct:

```apex
DataWrapper data;
```

Reason:

```text
{} = Single Object
```

---

## Mistake 2

JSON:

```json
{
    "data":[
    ]
}
```

Wrong:

```apex
DataWrapper data;
```

Correct:

```apex
List<DataWrapper> data;
```

Reason:

```text
[] = Multiple Objects
```

---

## Mistake 3

JSON:

```json
{
    "success":true
}
```

Wrong:

```apex
String success;
```

Correct:

```apex
Boolean success;
```

---

## Mistake 4

JSON:

```json
{
    "id":101
}
```

Wrong:

```apex
Id id;
```

Correct:

```apex
Integer id;
```

---

# JSON Design Process

Whenever you see JSON:

## Step 1

Identify:

```text
{}
```

Create Wrapper Classes.

---

## Step 2

Identify:

```text
[]
```

Create Lists.

---

## Step 3

Identify:

```text
String
Integer
Decimal
Boolean
```

Map to Apex datatypes.

---

## Step 4

Build Wrapper Structure.

---

# Architect Approach

When given JSON:

```json
{
    "account":{
    },
    "contacts":[
    ]
}
```

Think:

```text
account
    ↓
AccountWrapper

contacts
    ↓
List<ContactWrapper>
```

before writing any code.

---

# Quick Revision Sheet

```text
JSON = Data Format

Wrapper = Apex Representation

{} → Wrapper

[] → List<Wrapper>

"Raj" → String

23 → Integer

5000.50 → Decimal

true/false → Boolean

JSON Key
      ↓
Wrapper Variable Name

Salesforce Fields
      ↓
Use Salesforce Object

Custom Structure
      ↓
Use Wrapper Class
```

