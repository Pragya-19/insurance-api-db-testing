# Test Strategy – Insurance API & Database Testing

## 1. Objective

The objective of this project is to demonstrate practical API and database testing techniques in the Motor Insurance domain.

The project contains two independent testing modules:

1. Motor Insurance REST API testing using Postman and Newman.
2. Local Insurance database testing using MySQL.

> Note: The CyberNotes API is not connected to the local MySQL database. The modules share the same insurance business domain but are tested independently.

---

## 2. Scope

### API Testing

API testing is performed against the CyberNotes Motor Insurance demo API.

Coverage includes:

- Authentication and credential generation
- Access-token handling
- Motor policy creation
- Policy retrieval
- Dynamic request chaining
- Environment-variable handling
- Positive scenarios
- Negative scenarios
- HTTP status-code validation
- Response-body validation
- Response-time validation
- Newman command-line execution

### Database Testing

Database testing is performed against a locally created MySQL insurance database containing:

Customer → Vehicle → Policy

Coverage includes:

- Schema validation
- Primary-key validation
- Foreign-key validation
- UNIQUE constraints
- NOT NULL constraints
- CHECK constraints
- Positive and negative inserts
- JOIN validation
- Referential-integrity testing
- Orphan-record detection
- Business-rule validation
- Duplicate-data detection
- Aggregate and subquery validation

---

## 3. Test Approach

### Positive Testing

Valid requests and database records are used to verify expected system behaviour.

Examples:

- Generate valid API credentials
- Create a motor insurance policy
- Retrieve a policy
- Insert valid customer, vehicle and policy records
- Validate relationships between database entities

### Negative Testing

Invalid inputs and operations are intentionally executed to verify error handling and data protection.

Examples:

- Duplicate policy creation through API
- API request without authentication
- Duplicate customer email
- NULL mandatory customer name
- Vehicle referencing a non-existing customer
- Policy end date earlier than start date

---

## 4. Automation Approach

Postman test scripts use JavaScript assertions to validate API responses.

Dynamic values such as credentials, access tokens and policy identifiers are stored in environment variables and reused across requests.

The Postman collection is also executed from the command line using Newman to support repeatable regression execution.

---

## 5. Database Validation Approach

SQL queries validate both structural constraints and business data.

Database relationships are validated using INNER JOIN and LEFT JOIN queries.

Negative SQL operations verify that MySQL constraints prevent invalid data.

A policy-date business rule was specifically tested by:

1. Inserting a policy where `end_date < start_date`.
2. Detecting the invalid record using a CASE-based validation query.
3. Adding a CHECK constraint enforcing `end_date > start_date`.
4. Re-running the invalid insert.
5. Confirming MySQL rejected the record.

---

## 6. Tools

| Area              | Tool                         |
| ----------------- | ---------------------------- |
| API Testing       | Postman                      |
| API Assertions    | JavaScript / Postman Scripts |
| CLI API Execution | Newman                       |
| Database          | MySQL                        |
| Database Client   | MySQL Workbench              |
| Query Language    | SQL                          |
| Source Control    | Git / GitHub                 |

---

## 7. Entry Criteria

- CyberNotes demo API is accessible.
- Required Postman environment is configured.
- MySQL is available locally.
- Insurance database schema and test data are available.

---

## 8. Exit Criteria

Testing is considered complete when:

- Planned positive and negative scenarios have been executed.
- API assertions execute successfully.
- Newman collection execution completes successfully.
- Database relationships and constraints are validated.
- Critical data-integrity issues are not present in the final test data.
- Test assets and execution evidence are available in the repository.

---

## 9. Limitations

- The API and local MySQL database are independent systems.
- API-to-database integration testing is therefore outside the scope of this project.
- The project uses demo/test data only.
- Performance testing is limited to basic API response-time assertions and is not a load/performance test.
