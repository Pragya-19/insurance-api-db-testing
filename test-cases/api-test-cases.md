# Motor Insurance API – Test Cases

## Scope

API testing was performed against the CyberNotes Motor Insurance demo API using Postman.  
The collection includes authentication, policy creation, policy retrieval, positive scenarios, negative scenarios, dynamic variable handling, and automated assertions.

---

## API Test Cases

| TC ID | Test Scenario | Test Type | Expected Result |
|---|---|---|---|
| API_TC_01 | Generate demo client credentials | Positive | API returns 201 and client credentials are generated |
| API_TC_02 | Validate demo credential response time | Performance Check | Response time should be within the configured threshold |
| API_TC_03 | Validate client credentials are present in response | Response Validation | `client_id` and `client_secret` should be returned |
| API_TC_04 | Generate access token using valid credentials | Positive / Authentication | Access token should be generated successfully |
| API_TC_05 | Create motor insurance policy using valid request | Positive | Policy should be created successfully |
| API_TC_06 | Store dynamically generated policy ID | Data Chaining | Policy ID should be stored in environment for subsequent requests |
| API_TC_07 | Retrieve created policy using policy ID | Positive | Correct policy details should be returned |
| API_TC_08 | Attempt to create duplicate policy | Negative | API should reject duplicate policy creation |
| API_TC_09 | Retrieve policy without authentication token | Negative / Security | API should reject request with unauthorized response |
| API_TC_10 | Validate API response status codes | Validation | Actual HTTP status should match expected status |
| API_TC_11 | Validate API response body | Validation | Required response fields and values should be present |
| API_TC_12 | Execute complete API collection using Newman CLI | Automation / Regression | Collection should execute successfully through command line |

---

## Automation Features

- Postman environment variables
- Dynamic `client_id` and `client_secret` extraction
- Access-token handling
- Dynamic policy data
- Request chaining
- JavaScript assertions using `pm.test()`
- Positive and negative API testing
- HTTP status-code validation
- Response-body validation
- Response-time validation
- Newman command-line execution

---

## Tools

- Postman
- JavaScript (Postman test scripts)
- Newman
- REST API