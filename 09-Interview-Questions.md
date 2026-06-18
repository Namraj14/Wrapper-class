# Wrapper Classes in Salesforce - Interview Questions

## Introduction

Wrapper Classes are one of the most frequently asked Apex topics in Salesforce interviews.

Questions usually focus on:

* Basic Concepts
* LWC Usage
* Integrations
* JSON
* Serialization
* Real-Time Scenarios

---

# Beginner Level Questions

## 1. What is a Wrapper Class?

### Answer

A Wrapper Class is a custom Apex class used to group multiple pieces of related data into a single object.

It can contain:

* Salesforce Objects
* Lists
* Primitive Variables
* Other Wrapper Classes

---

## 2. Why do we use Wrapper Classes?

### Answer

Wrapper Classes are used when:

* Multiple objects need to be sent together
* Additional UI fields are required
* Calculated values are needed
* Complex JSON needs to be handled

---

## 3. Can a Wrapper Class contain Salesforce Objects?

### Answer

Yes.

Example:

```apex id="x6od57"
public class AccountWrapper {

    public Account account;
}
```

---

## 4. Can a Wrapper Class contain Lists?

### Answer

Yes.

Example:

```apex id="knw8j6"
public List<Contact> contacts;
```

---

## 5. Can a Wrapper Class contain another Wrapper Class?

### Answer

Yes.

Example:

```apex id="96vbz8"
public AccountWrapper account;
```

inside another wrapper.

---

## 6. Is a Wrapper Class a Salesforce Object?

### Answer

No.

Wrapper Class:

```text id="nkjh6u"
Custom Container
```

Salesforce Object:

```text id="f5h2l8"
Database Record
```

---

## 7. Can we perform DML on a Wrapper Class?

### Answer

No.

Wrong:

```apex id="4nuhwb"
insert wrapperObj;
```

Correct:

```apex id="1c0zzq"
insert wrapperObj.account;
```

DML works only on Salesforce Objects.

---

# Intermediate Level Questions

## 8. Difference Between Wrapper Class and Salesforce Object

| Salesforce Object     | Wrapper Class        |
| --------------------- | -------------------- |
| Database Record       | Custom Container     |
| Supports DML          | Does Not Support DML |
| Fixed Fields          | Custom Structure     |
| Standard Object Model | Developer Defined    |

---

## 9. When Should You Use a Wrapper Class?

### Answer

Use a Wrapper when:

```text id="1vqboq"
Multiple Objects

Calculated Values

UI Fields

API Responses

Nested JSON
```

---

## 10. When Should You NOT Use a Wrapper Class?

### Answer

When a Salesforce Object alone is sufficient.

Example:

```apex id="m4f90o"
Account acc;
```

No Wrapper needed.

---

## 11. Difference Between Single Object and List

### Example

Single Record:

```apex id="ikz8ck"
public Account account;
```

Multiple Records:

```apex id="a5stdu"
public List<Account> accounts;
```

---

## 12. Can Wrapper Classes Be Returned From Apex Methods?

### Answer

Yes.

Example:

```apex id="1xb6w3"
@AuraEnabled
public static AccountWrapper getData()
{
    return wrapperObj;
}
```

---

## 13. Can Wrapper Classes Be Passed to Apex Methods?

### Answer

Yes.

Example:

```apex id="y2qlzu"
@AuraEnabled
public static void saveData(
    AccountWrapper wrapperData
)
{
}
```

---

# LWC Questions

## 14. Why Are Wrapper Classes Used in LWC?

### Answer

To send multiple values between Apex and LWC in a single object.

---

## 15. What Annotation Is Required?

### Answer

```apex id="8n0eeh"
@AuraEnabled
```

---

## 16. Can LWC Send Wrapper Classes to Apex?

### Answer

Yes.

LWC sends JSON and Salesforce automatically converts it into a Wrapper Class.

---

## 17. How Do You Access Wrapper Data in LWC?

Wrapper:

```apex id="eqjlwm"
public Account acc;
```

JavaScript:

```javascript id="57lrya"
wrapperResult.acc.Name;
```

---

## 18. How Do You Access List Data?

```javascript id="9hkg0k"
wrapperResult.contacts[0].LastName;
```

---

# JSON Questions

## 19. What Does `{}` Represent?

### Answer

```text id="mvbuxz"
Single Object
```

Usually:

```apex id="7n7dl0"
Wrapper Class
```

---

## 20. What Does `[]` Represent?

### Answer

```text id="slpl2l"
Array
```

Usually:

```apex id="e3tpny"
List<Wrapper>
```

---

## 21. How Do You Design a Wrapper From JSON?

### Answer

1. Identify `{}` → Wrapper
2. Identify `[]` → List
3. Map datatypes
4. Build structure

---

## 22. What Happens If JSON Contains Extra Fields?

### Answer

Extra fields are ignored.

---

## 23. What Happens If JSON Fields Are Missing?

### Answer

Missing fields become:

```text id="4mzc3y"
null
```

---

# Serialization Questions

## 24. What is Serialization?

### Answer

```text id="u2qf4h"
Object → JSON
```

---

## 25. Which Method Is Used?

### Answer

```apex id="vbp5mb"
JSON.serialize()
```

---

## Example

```apex id="2x8y0j"
String jsonString =
    JSON.serialize(wrapper);
```

---

## 26. What is Deserialization?

### Answer

```text id="mjlwmn"
JSON → Object
```

---

## 27. Which Method Is Used?

### Answer

```apex id="91ydkz"
JSON.deserialize()
```

---

## Example

```apex id="qv3t4u"
Wrapper wrapper =
(Wrapper)
JSON.deserialize(
    jsonString,
    Wrapper.class
);
```

---

# Nested JSON Questions

## 28. What Is a Nested Wrapper?

### Answer

A Wrapper containing another Wrapper.

Example:

```apex id="yvwhj0"
public AccountWrapper account;
```

inside another wrapper.

---

## 29. What Is an Inner Wrapper Class?

### Answer

A Wrapper Class defined inside another Wrapper Class.

---

## Example

```apex id="a5j45r"
public class ParentWrapper {

    public class ChildWrapper {

    }
}
```

---

## 30. Why Use Inner Wrapper Classes?

### Answer

To keep related wrapper classes together.

Common in API responses.

---

# Scenario Based Questions

## 31. You Need Account + Checkbox

What Will You Use?

### Answer

```apex id="w6m5yw"
public Account account;

public Boolean isSelected;
```

inside a Wrapper.

---

## 32. You Need Account + Contacts

### Answer

```apex id="e1mkvu"
public Account account;

public List<Contact> contacts;
```

---

## 33. You Need Account + Contact Count

### Answer

```apex id="8v89l9"
public Account account;

public Integer contactCount;
```

---

## 34. API Returns

```json id="1p5bfu"
{
    "success":true,
    "message":"Success"
}
```

### Answer

```apex id="hdu8h3"
public Boolean success;

public String message;
```

---

## 35. API Returns

```json id="9rbjmx"
{
    "data":[]
}
```

### Answer

```apex id="h7ybj6"
public List<DataWrapper> data;
```

Because:

```text id="g3u9o0"
[]
=
List
```

---

## 36. API Returns

```json id="10t9j4"
{
    "data":{}
}
```

### Answer

```apex id="wk99h7"
public DataWrapper data;
```

Because:

```text id="z4u3xt"
{}
=
Object
```

---

# Advanced Questions

## 37. Can Wrapper Classes Be Used in REST APIs?

### Answer

Yes.

They are commonly used for request and response payloads.

---

## 38. Can Wrapper Classes Be Serialized?

### Answer

Yes.

```apex id="j0qnm2"
JSON.serialize()
```

---

## 39. Can Wrapper Classes Be Deserialized?

### Answer

Yes.

```apex id="e0e6es"
JSON.deserialize()
```

---

## 40. Can Wrapper Classes Contain Salesforce Objects and Custom Fields Together?

### Answer

Yes.

Example:

```apex id="63wh2y"
public Account account;

public Boolean isSelected;

public Integer totalContacts;
```

---

# Frequently Asked Real Interview Question

## Wrapper vs Map

### Wrapper

```apex id="k8x5uk"
public String name;

public Integer age;
```

Advantages:

```text id="qdyfzl"
Strongly Typed

Easy To Read

Compile Time Validation
```

---

### Map

```apex id="kh0zk6"
Map<String,Object>
```

Advantages:

```text id="58hvlz"
Dynamic Structure
```

---

### Which Is Preferred?

For known structures:

```text id="lqbhaw"
Wrapper Class
```

For unknown structures:

```text id="dksc6w"
Map<String,Object>
```

---

# One-Line Revision

```text id="dwhjlwm"
Wrapper = Custom Container

Object = Record

{} = Wrapper

[] = List

Serialize = Object → JSON

Deserialize = JSON → Object

LWC = @AuraEnabled

Multiple Objects = Wrapper

UI Fields = Wrapper

API Responses = Wrapper

Nested JSON = Wrapper
```

