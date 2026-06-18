# Wrapper Classes in Salesforce - Cheat Sheet

## Introduction

This file is designed for quick revision before:

* Interviews
* Certifications
* Client Calls
* Project Work

If you forget everything, revise this file and you'll remember the important concepts.

---

# Wrapper Class Definition

```text id="j7e9wd"
A Wrapper Class is a custom Apex class
used to group multiple pieces of related
data into a single object.
```

---

# Wrapper vs Salesforce Object

| Salesforce Object | Wrapper Class    |
| ----------------- | ---------------- |
| Database Record   | Custom Container |
| Supports DML      | No DML           |
| Fixed Structure   | Custom Structure |
| Standard Fields   | Any Fields       |
| Stores Data       | Groups Data      |

---

## Memory Trick

```text id="fz6bjy"
Object
 ↓
Stores Data

Wrapper
 ↓
Groups Data
```

---

# When To Use Wrapper Classes

Use Wrapper Classes when:

```text id="j6eh3z"
Multiple Objects

UI Fields

Calculated Values

Nested JSON

API Responses

LWC Communication
```

---

# When NOT To Use Wrapper Classes

If only a Salesforce Object is needed:

```apex id="ajywk5"
Account acc;
```

No Wrapper Required.

---

# Decision Formula

```text id="y6v2ci"
Need One Salesforce Object?
            │
            ├── YES
            │
            │ No Extra Fields?
            │
            └── Use Object
            │
            └── Extra Fields?
                   ↓
                Wrapper
```

---

# Single Object vs List

## Single Record

```apex id="jlwmm5"
public Account account;
```

---

## Multiple Records

```apex id="c88zd6"
public List<Account> accounts;
```

---

## Memory Rule

```text id="c7bsxy"
One Record
    ↓
Object

Many Records
    ↓
List<Object>
```

---

# Most Common Wrapper Examples

## Account + Checkbox

```apex id="7ppwmz"
public Account account;

public Boolean isSelected;
```

---

## Account + Contacts

```apex id="a2psdb"
public Account account;

public List<Contact> contacts;
```

---

## Account + Contact Count

```apex id="bg46ci"
public Account account;

public Integer totalContacts;
```

---

## Account + Cases

```apex id="1b8u6v"
public Account account;

public List<Case> cases;
```

---

# Wrapper Class Design Rules

```text id="7zafgq"
Single Record
    ↓
Object

Multiple Records
    ↓
List

Extra Fields
    ↓
Wrapper

Calculated Values
    ↓
Wrapper

UI Fields
    ↓
Wrapper
```

---

# JSON Mapping Rules

## Curly Braces

```json id="r5p80m"
{
}
```

Means:

```text id="0e9qbi"
Object
```

Usually:

```apex id="yqdr3m"
Wrapper
```

---

## Square Brackets

```json id="kjxwvd"
[
]
```

Means:

```text id="l85i0w"
Array
```

Usually:

```apex id="15qj94"
List<Wrapper>
```

---

## Golden Rule

```text id="0a99el"
{} → Wrapper

[] → List<Wrapper>
```

---

# JSON Data Type Mapping

| JSON    | Apex    |
| ------- | ------- |
| "Raj"   | String  |
| 25      | Integer |
| 5000.50 | Decimal |
| true    | Boolean |
| false   | Boolean |
| null    | null    |

---

# Serialization

## Definition

```text id="gfev43"
Object → JSON
```

---

## Method

```apex id="3xvzwu"
JSON.serialize()
```

---

## Example

```apex id="b1wjlwm"
String jsonString =
    JSON.serialize(wrapper);
```

---

# Deserialization

## Definition

```text id="9m11gw"
JSON → Object
```

---

## Method

```apex id="0g8zxt"
JSON.deserialize()
```

---

## Example

```apex id="m07e09"
Wrapper wrapper =
(Wrapper)
JSON.deserialize(
    jsonString,
    Wrapper.class
);
```

---

# Serialization Memory Trick

```text id="97jlwm"
Object
  ↓ Serialize
JSON
  ↓ Deserialize
Object
```

---

# Salesforce Objects vs Wrappers

## Use Salesforce Objects

JSON:

```json id="znh6sl"
{
    "Id":"001xxx",
    "Name":"ABC Corp"
}
```

Apex:

```apex id="rzrcc5"
Account account;
```

---

## Use Wrapper

JSON:

```json id="0rkwe0"
{
    "accountName":"ABC Corp",
    "totalContacts":10
}
```

Apex:

```apex id="f2pn0m"
AccountWrapper
```

---

## Rule

```text id="xjlwmx"
Salesforce Fields
       ↓
Use Salesforce Object

Custom Structure
       ↓
Use Wrapper
```

---

# LWC Rules

## Required Annotation

```apex id="djlwmm"
@AuraEnabled
```

---

## Example

```apex id="jlwmw1"
@AuraEnabled
public Account account;
```

---

## Accessing Wrapper Data

```javascript id="jlwmw2"
wrapperResult.account.Name
```

---

## Accessing List Data

```javascript id="jlwmw3"
wrapperResult.contacts[0].LastName
```

---

# Inner Wrapper Classes

## Definition

```text id="jlwmw4"
Wrapper Inside Wrapper
```

---

## Example

```apex id="jlwmw5"
public class ParentWrapper {

    public class ChildWrapper {

    }
}
```

---

## Access

```apex id="jlwmw6"
ParentWrapper.ChildWrapper
```

---

# Common Mistakes

## Mistake 1

JSON:

```json id="jlwmw7"
{
    "data":{}
}
```

Wrong:

```apex id="jlwmw8"
List<DataWrapper>
```

Correct:

```apex id="jlwmw9"
DataWrapper
```

---

## Mistake 2

JSON:

```json id="jlwmx0"
{
    "data":[]
}
```

Wrong:

```apex id="jlwmx1"
DataWrapper
```

Correct:

```apex id="jlwmx2"
List<DataWrapper>
```

---

## Mistake 3

JSON:

```json id="jlwmx3"
{
    "success":true
}
```

Wrong:

```apex id="jlwmx4"
String success;
```

Correct:

```apex id="jlwmx5"
Boolean success;
```

---

## Mistake 4

JSON:

```json id="jlwmx6"
{
    "id":101
}
```

Wrong:

```apex id="jlwmx7"
Id id;
```

Correct:

```apex id="jlwmx8"
Integer id;
```

---

## Mistake 5

JSON Key Doesn't Match Variable Name

JSON:

```json id="jlwmx9"
{
    "accountName":"ABC"
}
```

Wrapper:

```apex id="jlwmy0"
public String customerName;
```

Result:

```text id="jlwmy1"
null
```

---

# Interview One-Liners

## What is a Wrapper Class?

```text id="jlwmy2"
Custom Apex Container
```

---

## Why Use Wrapper Classes?

```text id="jlwmy3"
To Group Multiple Data Elements
```

---

## Wrapper vs Object?

```text id="jlwmy4"
Object = Record

Wrapper = Container
```

---

## Can Wrapper Contain Salesforce Objects?

```text id="jlwmy5"
Yes
```

---

## Can Wrapper Contain Lists?

```text id="jlwmy6"
Yes
```

---

## Can Wrapper Be Serialized?

```text id="jlwmy7"
Yes
```

---

## Can Wrapper Be Deserialized?

```text id="jlwmy8"
Yes
```

---

## Can Wrapper Be Used In LWC?

```text id="jlwmy9"
Yes
```

---

## Can We Perform DML On Wrapper?

```text id="jlwmz0"
No
```

---

# Ultimate Revision Sheet

```text id="jlwmz1"
Wrapper = Custom Container

Object = Database Record

Single Record
    ↓
Object

Multiple Records
    ↓
List

{} 
 ↓
Wrapper

[]
 ↓
List<Wrapper>

Serialize
 ↓
Object → JSON

Deserialize
 ↓
JSON → Object

Salesforce Fields
 ↓
Use Object

Custom Structure
 ↓
Use Wrapper

@AuraEnabled
 ↓
LWC Access

Wrapper Can Contain:
    Objects
    Lists
    Strings
    Integers
    Decimals
    Booleans
    Wrappers

Most Common Uses:
    LWC
    Integrations
    API Responses
    Parent Child Data
    UI Checkboxes
    Calculated Values
```

---

# 30-Second Interview Revision

```text id="9j7u1s"
Wrapper Class is a custom Apex container
used to group multiple pieces of related
data together.

Used for:
- Multiple Objects
- UI Fields
- Calculated Values
- LWC
- Integrations
- JSON Handling

Serialize = Object → JSON

Deserialize = JSON → Object

{} = Wrapper

[] = List<Wrapper>

Object = Record

Wrapper = Container
```

