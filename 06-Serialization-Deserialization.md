# Wrapper Classes in Salesforce - Serialization & Deserialization

## Introduction

Serialization and Deserialization are two of the most important concepts in Salesforce Integrations.

Whenever Salesforce communicates with:

* LWC
* REST APIs
* External Systems
* Middleware
* Mobile Apps

data is usually exchanged in JSON format.

Wrapper Classes act as the bridge between Apex Objects and JSON.

---

# What is Serialization?

Serialization means:

```text id="s6h7jw"
Apex Object
      ↓
JSON String
```

Salesforce converts an Apex Object into JSON.

---

## Memory Trick

```text id="lm1x3q"
Serialize
=
Object → String
```

---

# Example

## Wrapper Class

```apex id="r0xk0u"
public class EmployeeWrapper {

    public String name;

    public Integer age;
}
```

---

## Create Object

```apex id="znl11y"
EmployeeWrapper emp =
    new EmployeeWrapper();

emp.name = 'Raj';

emp.age = 23;
```

---

## Serialize

```apex id="2xzytt"
String jsonString =
    JSON.serialize(emp);
```

---

## Result

```json id="8ehlf4"
{
    "name":"Raj",
    "age":23
}
```

---

# Visual Flow

```text id="h5t7j0"
EmployeeWrapper
│
├── name = Raj
└── age = 23

        ↓

JSON.serialize()

        ↓

{
    "name":"Raj",
    "age":23
}
```

---

# What is Deserialization?

Deserialization means:

```text id="krjlwm"
JSON String
      ↓
Apex Object
```

Salesforce converts JSON into an Apex Object.

---

## Memory Trick

```text id="a24s6n"
Deserialize
=
String → Object
```

---

# Example

## JSON

```json id="5n66wr"
{
    "name":"Raj",
    "age":23
}
```

---

## Wrapper

```apex id="jkh3cx"
public class EmployeeWrapper {

    public String name;

    public Integer age;
}
```

---

## Deserialize

```apex id="4tx1pz"
String jsonString =
'{"name":"Raj","age":23}';

EmployeeWrapper emp =
    (EmployeeWrapper)
    JSON.deserialize(
        jsonString,
        EmployeeWrapper.class
    );
```

---

## Access Values

```apex id="ehpqdf"
System.debug(emp.name);

System.debug(emp.age);
```

Output:

```text id="xyg8r8"
Raj

23
```

---

# Serialization vs Deserialization

| Serialization    | Deserialization    |
| ---------------- | ------------------ |
| Object → JSON    | JSON → Object      |
| Apex → String    | String → Apex      |
| JSON.serialize() | JSON.deserialize() |
| Sending Data     | Receiving Data     |

---

# Most Common Interview Question

## Serialization

```apex id="74fgcf"
String jsonString =
    JSON.serialize(wrapper);
```

Meaning:

```text id="hlv5l3"
Wrapper
 ↓
JSON
```

---

## Deserialization

```apex id="b1e6iw"
Wrapper wrapper =
    (Wrapper)
    JSON.deserialize(
        jsonString,
        Wrapper.class
    );
```

Meaning:

```text id="jlwmjz"
JSON
 ↓
Wrapper
```

---

# Example with Account Wrapper

## Wrapper

```apex id="l9z62g"
public class AccountWrapper {

    public String accountName;

    public Boolean isSelected;
}
```

---

## Object

```apex id="dxg8zm"
AccountWrapper aw =
    new AccountWrapper();

aw.accountName = 'ABC Corp';

aw.isSelected = true;
```

---

## Serialize

```apex id="yshhgs"
String jsonString =
    JSON.serialize(aw);
```

---

## Result

```json id="l7ft6l"
{
    "accountName":"ABC Corp",
    "isSelected":true
}
```

---

# Deserialize Example

## JSON

```json id="v8xzz4"
{
    "accountName":"ABC Corp",
    "isSelected":true
}
```

---

## Apex

```apex id="ff2wpo"
AccountWrapper aw =
    (AccountWrapper)
    JSON.deserialize(
        jsonString,
        AccountWrapper.class
    );
```

---

## Result

```apex id="v2f76w"
aw.accountName

aw.isSelected
```

contains:

```text id="rf54uq"
ABC Corp

true
```

---

# Serialization with Lists

## Wrapper

```apex id="j0edzb"
public class ContactWrapper {

    public String name;
}
```

---

## Create List

```apex id="tl4zba"
List<ContactWrapper> contacts =
    new List<ContactWrapper>();
```

---

## Serialize

```apex id="v9c8vw"
String jsonString =
    JSON.serialize(contacts);
```

---

## Result

```json id="cx3g3l"
[
    {
        "name":"Raj"
    },
    {
        "name":"Amit"
    }
]
```

---

# Deserialize List

```apex id="c2d4fh"
List<ContactWrapper> contacts =
(List<ContactWrapper>)
JSON.deserialize(
    jsonString,
    List<ContactWrapper>.class
);
```

---

# Nested Wrapper Example

## Wrapper

```apex id="vzk5m7"
public class CustomerWrapper {

    public AccountWrapper account;

    public List<ContactWrapper> contacts;
}
```

---

## Serialize

```apex id="mbt4d8"
String jsonString =
    JSON.serialize(customer);
```

---

## Result

```json id="u6vbhq"
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

---

# Real World Scenario 1 - REST API Callout

## API Returns

```json id="wh74y8"
{
    "success":true,
    "message":"Records Retrieved"
}
```

---

## Deserialize

```apex id="r6huy8"
ApiResponseWrapper response =
(ApiResponseWrapper)
JSON.deserialize(
    responseBody,
    ApiResponseWrapper.class
);
```

---

## Use

```apex id="ifg0wv"
System.debug(response.success);

System.debug(response.message);
```

---

# Real World Scenario 2 - LWC to Apex

## LWC Sends

```json id="3i6ljd"
{
    "accountName":"ABC Corp",
    "isSelected":true
}
```

---

## Salesforce Automatically Deserializes

```apex id="hnccm0"
@AuraEnabled
public static void saveData(
    AccountWrapper wrapperData
)
{
}
```

Salesforce converts JSON into:

```apex id="d5l1t6"
AccountWrapper
```

automatically.

---

# Unknown Fields Behavior

## JSON

```json id="40czfo"
{
    "name":"Raj",
    "age":23,
    "city":"Mumbai"
}
```

---

## Wrapper

```apex id="4rjv6n"
public class EmployeeWrapper {

    public String name;

    public Integer age;
}
```

---

## Result

```text id="ahmxg7"
name → Raj

age → 23

city → Ignored
```

Extra fields are ignored.

---

# Missing Fields Behavior

## JSON

```json id="a8kw2q"
{
    "name":"Raj"
}
```

---

## Wrapper

```apex id="3glzq3"
public class EmployeeWrapper {

    public String name;

    public Integer age;
}
```

---

## Result

```text id="6z9exd"
name → Raj

age → null
```

Missing fields become:

```text id="d0ggnw"
null
```

---

# Common Mistakes

## Mistake 1

Using serialize when you need deserialize.

Wrong:

```apex id="8g7ffg"
JSON.serialize(jsonString);
```

---

Correct:

```apex id="3c0kv5"
JSON.deserialize(
    jsonString,
    Wrapper.class
);
```

---

## Mistake 2

Wrapper variable names do not match JSON keys.

JSON:

```json id="pbahmn"
{
    "accountName":"ABC"
}
```

Wrapper:

```apex id="zvkzhm"
public String customerName;
```

Result:

```text id="h7y86v"
customerName = null
```

---

Correct:

```apex id="gcdglv"
public String accountName;
```

---

# Quick Revision Sheet

```text id="2t3e7j"
Serialization
    ↓
Object → JSON

Deserialization
    ↓
JSON → Object

JSON.serialize()

JSON.deserialize()

Wrapper → JSON

JSON → Wrapper

Extra JSON Fields
    ↓
Ignored

Missing JSON Fields
    ↓
null

Most Common Usage:
    REST APIs
    LWC
    Integrations
    External Systems
```

---

# Memory Formula

```text id="ihv3t6"
Object
  ↓ Serialize
JSON
  ↓ Deserialize
Object
```

This is the entire foundation of Salesforce integrations and API communication.

