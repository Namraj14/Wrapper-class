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
