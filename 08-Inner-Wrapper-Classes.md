# Wrapper Classes in Salesforce - Inner Wrapper Classes

## Introduction

Until now, we have created separate Wrapper Classes:

```apex
public class EmployeeWrapper {

    public String name;
}

public class ContactWrapper {

    public String email;
}
```

This works perfectly.

However, in integrations and complex JSON structures, developers often keep related wrapper classes inside a single parent wrapper.

These are called **Inner Wrapper Classes**.

---

# What is an Inner Wrapper Class?

An Inner Wrapper Class is a wrapper class defined inside another wrapper class.

Example:

```apex
public class EmployeeWrapper {

    public AccountWrapper account;

    public class AccountWrapper {

        public String name;

        public String industry;
    }
}
```

---

# Visual Representation

```text
EmployeeWrapper
│
└── AccountWrapper
      │
      ├── name
      └── industry
```

---

# Why Use Inner Wrapper Classes?

Inner wrappers help:

* Organize related classes together
* Reduce file clutter
* Improve readability
* Keep API response structures in one place
* Make maintenance easier

---

# Separate Wrapper vs Inner Wrapper

## Separate Wrapper Classes

```apex
public class AccountWrapper {

    public String name;
}

public class ContactWrapper {

    public String email;
}
```

---

## Inner Wrapper Classes

```apex
public class CustomerWrapper {

    public AccountWrapper account;

    public ContactWrapper contact;

    public class AccountWrapper {

        public String name;
    }

    public class ContactWrapper {

        public String email;
    }
}
```

---

# When Should We Use Inner Wrappers?

Use Inner Wrappers when:

```text
The Wrapper Classes are related

Used together

Belong to same API Response

Not reused elsewhere
```

---

# Example 1 - API Response

## JSON

```json
{
    "success": true,
    "message": "Records Retrieved"
}
```

---

## Wrapper

```apex
public class ApiResponseWrapper {

    public Boolean success;

    public String message;
}
```

No inner wrappers needed because JSON is simple.

---

# Example 2 - Nested API Response

## JSON

```json
{
    "success": true,
    "data": {
        "name": "ABC Corp",
        "city": "Mumbai"
    }
}
```

---

## Wrapper

```apex
public class ApiResponseWrapper {

    public Boolean success;

    public DataWrapper data;

    public class DataWrapper {

        public String name;

        public String city;
    }
}
```

---

# Visual

```text
ApiResponseWrapper
│
├── success
│
└── DataWrapper
      │
      ├── name
      └── city
```

---

# Example 3 - Array Response

## JSON

```json
{
    "accounts": [
        {
            "name": "ABC Corp"
        },
        {
            "name": "XYZ Corp"
        }
    ]
}
```

---

## Wrapper

```apex
public class ResponseWrapper {

    public List<AccountWrapper> accounts;

    public class AccountWrapper {

        public String name;
    }
}
```

---

# Example 4 - Complex Nested JSON

## JSON

```json
{
  "success": true,
  "data": {
      "account": {
          "name": "ABC Corp",
          "industry": "IT"
      },
      "contacts": [
          {
              "name": "Raj"
          }
      ]
  }
}
```

---

## Wrapper

```apex
public class ApiResponseWrapper {

    public Boolean success;

    public DataWrapper data;

    public class DataWrapper {

        public AccountWrapper account;

        public List<ContactWrapper> contacts;
    }

    public class AccountWrapper {

        public String name;

        public String industry;
    }

    public class ContactWrapper {

        public String name;
    }
}
```

---

# Visual Structure

```text
ApiResponseWrapper
│
├── success
│
└── DataWrapper
      │
      ├── AccountWrapper
      │      ├── name
      │      └── industry
      │
      └── ContactWrapper
             └── name
```

---

# Accessing Inner Wrapper Classes

## Create Parent Wrapper

```apex
ApiResponseWrapper response =
    new ApiResponseWrapper();
```

---

## Create Inner Wrapper

```apex
ApiResponseWrapper.AccountWrapper account =
    new ApiResponseWrapper.AccountWrapper();
```

---

## Assign Values

```apex
account.name = 'ABC Corp';

account.industry = 'Technology';
```

---

# Inner Wrapper with Serialization

## Wrapper

```apex
public class CustomerWrapper {

    public AccountWrapper account;

    public class AccountWrapper {

        public String name;
    }
}
```

---

## Serialize

```apex
String jsonString =
    JSON.serialize(customer);
```

---

## Result

```json
{
    "account":{
        "name":"ABC Corp"
    }
}
```

---

# Inner Wrapper with Deserialization

## JSON

```json
{
    "account":{
        "name":"ABC Corp"
    }
}
```

---

## Deserialize

```apex
CustomerWrapper customer =
(CustomerWrapper)
JSON.deserialize(
    jsonString,
    CustomerWrapper.class
);
```

---

## Access Data

```apex
customer.account.name;
```

---

# Real Integration Example

Suppose an API returns:

```json
{
  "status":"SUCCESS",
  "message":"Records Retrieved",
  "data":[
      {
          "id":101,
          "name":"ABC Corp"
      }
  ]
}
```

---

## Wrapper

```apex
public class ApiResponseWrapper {

    public String status;

    public String message;

    public List<DataWrapper> data;

    public class DataWrapper {

        public Integer id;

        public String name;
    }
}
```

Everything stays inside a single class.

---

# When NOT to Use Inner Wrappers

Avoid Inner Wrappers when:

```text
Same Wrapper is reused
Across Multiple Classes

Across Multiple Projects

Across Multiple APIs
```

---

## Example

If AccountWrapper is used everywhere:

```apex
AccountController

ContactController

OpportunityController
```

then create a separate wrapper file.

---

# Benefits of Inner Wrappers

## Better Organization

```text
One API
One Wrapper File
```

---

## Easier Maintenance

```text
Everything Together
```

---

## Less Clutter

Instead of:

```text
AccountWrapper.cls

ContactWrapper.cls

DataWrapper.cls

ApiResponseWrapper.cls
```

You have:

```text
ApiResponseWrapper.cls
```

only.

---

# Interview Questions

## What is an Inner Wrapper Class?

A wrapper class defined inside another wrapper class.

---

## Why use Inner Wrapper Classes?

To group related wrapper classes together and improve maintainability.

---

## Can Inner Wrapper Classes contain Lists?

Yes.

Example:

```apex
public List<ContactWrapper> contacts;
```

---

## Can Inner Wrapper Classes be Serialized?

Yes.

```apex
JSON.serialize()
```

works exactly the same.

---

## Can Inner Wrapper Classes be Deserialized?

Yes.

```apex
JSON.deserialize()
```

works exactly the same.

---

# Separate Wrapper vs Inner Wrapper

| Separate Wrapper        | Inner Wrapper            |
| ----------------------- | ------------------------ |
| Multiple Files          | Single File              |
| Reusable                | Usually API Specific     |
| Better for Shared Logic | Better for API Responses |
| Easier Reuse            | Easier Organization      |

---

# Quick Revision Sheet

```text
Inner Wrapper
        ↓
Wrapper Inside Wrapper

Use When:
    Same API
    Same JSON
    Same Response

Benefits:
    Better Organization
    Less Clutter
    Easier Maintenance

Access:
    ParentWrapper.InnerWrapper

Example:
    ApiResponseWrapper.DataWrapper

Serialization:
    Supported

Deserialization:
    Supported
```

