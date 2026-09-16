# Insurance API & Database Testing Portfolio

A hands-on QA portfolio project demonstrating **REST API testing, Postman automation, Newman CLI execution, SQL database testing, data-integrity validation, and negative testing** in the Motor Insurance domain.

The project contains two independent testing modules:

- **API Testing:** CyberNotes Motor Insurance Demo API
- **Database Testing:** Local MySQL Insurance Database

> **Architecture Note:** The CyberNotes API and local MySQL database are independent systems. This project does not claim API-to-database integration testing.

---

## Project Objectives

The objective of this project is to demonstrate practical QA skills across API and database testing, including:

- REST API testing
- Positive and negative API scenarios
- Authentication testing
- Dynamic request chaining
- Postman JavaScript assertions
- Environment-variable management
- Newman command-line execution
- Relational database testing
- SQL validation queries
- Database constraint testing
- Referential-integrity validation
- Business-rule validation

---

## Technology Stack

| Area             | Technology                 |
| ---------------- | -------------------------- |
| API Testing      | Postman                    |
| API Automation   | Postman JavaScript Scripts |
| CLI Execution    | Newman                     |
| API Type         | REST                       |
| Database         | MySQL                      |
| Database Client  | MySQL Workbench            |
| Database Testing | SQL                        |
| Version Control  | Git & GitHub               |
| CI               | GitHub Actions             |

---

## Project Structure

```text
insurance-api-db-testing/
│
├── database/
│   ├── schema.sql
│   ├── test_data.sql
│   └── validation_queries.sql
│
├── docs/
│   ├── architecture.md
│   └── test-strategy.md
│
├── newman/
│   └── reports/
│       └── newman-report.json
│
├── postman/
│   ├── Motor Insurance API - Postman Automation.postman_collection.json
│   └── Insurance QA.postman_environment.json
│
├── test-cases/
│   ├── api-test-cases.md
│   └── db-test-cases.md
│
├── .github/
│   └── workflows/
│       └── api-tests.yml
│
├── .gitignore
└── README.md
```

---

# Module 1 – Motor Insurance API Testing

API testing is performed against the **CyberNotes Motor Insurance Demo API** using Postman.

## API Coverage

The API module demonstrates:

- Demo client credential generation
- Authentication and access-token handling
- Motor insurance policy operations
- Policy retrieval
- Dynamic environment variables
- Request chaining
- Positive testing
- Negative testing
- HTTP status-code validation
- Response-body validation
- Response-time validation
- Newman regression execution

---

## Dynamic Data Handling

Runtime values are extracted from API responses and stored as Postman environment variables.

Examples include:

```text
client_id
client_secret
access_token
reg_number
policy_id
```

This allows subsequent requests to reuse dynamically generated values instead of relying on hardcoded runtime credentials or identifiers.

Sensitive runtime credentials and tokens are not stored in the repository.

---

## Example Postman Assertion

```javascript
pm.test("Status code is 201", function () {
  pm.response.to.have.status(201);
});

pm.test("Response time is below 2000 ms", function () {
  pm.expect(pm.response.responseTime).to.be.below(2000);
});

pm.test("Client credentials are returned", function () {
  const jsonData = pm.response.json();

  pm.expect(jsonData).to.have.property("client_id");
  pm.expect(jsonData).to.have.property("client_secret");
});
```

---

## Newman Execution

The Postman collection can be executed from the command line using Newman:

```bash
newman run "postman/Motor Insurance API - Postman Automation.postman_collection.json" -e "postman/Insurance QA.postman_environment.json"
```

A JSON execution report is stored under:

```text
newman/reports/
```

---

# Module 2 – MySQL Database Testing

A local relational database was created to model a simplified Motor Insurance data structure.

## Data Model

```text
Customer
   |
   | 1:N
   v
Vehicle
   |
   | 1:N
   v
Policy
```

The database contains three primary entities:

- `customers`
- `vehicles`
- `policies`

---

## Database Testing Coverage

Testing includes:

- Primary-key validation
- Foreign-key validation
- UNIQUE constraint validation
- NOT NULL constraint validation
- CHECK constraint validation
- Positive inserts
- Negative inserts
- INNER JOIN validation
- LEFT JOIN validation
- Referential-integrity checks
- Orphan-record detection
- Duplicate-data detection
- Aggregate queries
- Subqueries
- Business-rule validation

---

## Negative Database Testing

Several invalid database operations were intentionally executed to verify data integrity.

| Scenario                                  | Expected Behaviour                 | Result     |
| ----------------------------------------- | ---------------------------------- | ---------- |
| Duplicate customer email                  | UNIQUE constraint rejects record   | Error 1062 |
| NULL customer name                        | NOT NULL constraint rejects record | Error 1048 |
| Vehicle referencing non-existing customer | Foreign key rejects record         | Error 1452 |
| Policy with invalid date range            | CHECK constraint rejects record    | Error 3819 |

---

## Business Rule Validation

One business rule requires:

```text
Policy End Date > Policy Start Date
```

Testing was performed in multiple stages.

An invalid policy was initially inserted with an end date earlier than its start date.

A SQL validation query detected the problem:

```sql
SELECT
    policy_number,
    start_date,
    end_date,
    CASE
        WHEN end_date > start_date THEN 'PASS'
        ELSE 'FAIL'
    END AS date_validation
FROM policies;
```

A database CHECK constraint was subsequently introduced:

```sql
CHECK (end_date > start_date)
```

The invalid insert was executed again and MySQL rejected it, demonstrating both **defect detection** and **database-level defect prevention**.

---

## Referential Integrity Testing

LEFT JOIN queries are used to identify orphan records.

Example:

```sql
SELECT
    v.vehicle_id,
    v.registration_number,
    v.customer_id
FROM vehicles v
LEFT JOIN customers c
    ON v.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
```

Zero returned records indicate that no orphan vehicles exist in the test dataset.

---

## Duplicate Detection

Duplicate policy numbers can be identified using:

```sql
SELECT
    policy_number,
    COUNT(*) AS duplicate_count
FROM policies
GROUP BY policy_number
HAVING COUNT(*) > 1;
```

This demonstrates the common SQL pattern:

```text
GROUP BY + HAVING COUNT(*) > 1
```

---

# Test Strategy

The project uses a combination of:

**Positive Testing**  
Valid API requests and database records verify expected behaviour.

**Negative Testing**  
Invalid inputs and operations verify error handling and database protection.

**Data Integrity Testing**  
SQL queries and constraints verify relationships and business rules.

**Automation / Regression Testing**  
Postman assertions and Newman provide repeatable API execution.

The complete strategy is available in:

```text
docs/test-strategy.md
```

---

# Test Cases

Documented test scenarios are available under:

```text
test-cases/
├── api-test-cases.md
└── db-test-cases.md
```

The test cases include positive, negative, authentication, data-integrity, constraint and business-rule scenarios.

---

# Running the Database Tests

## 1. Create the database schema

Run:

```text
database/schema.sql
```

## 2. Insert valid test data

Run:

```text
database/test_data.sql
```

## 3. Execute validation queries

Run:

```text
database/validation_queries.sql
```

---

# Running the API Tests

## Using Postman

1. Import the collection from the `postman` directory.
2. Import the QA environment.
3. Select the environment.
4. Execute the collection.

Dynamic credentials and runtime values are generated during execution.

## Using Newman

From the project root:

```bash
newman run "postman/Motor Insurance API - Postman Automation.postman_collection.json" -e "postman/Insurance QA.postman_environment.json"
```

---

# Key QA Skills Demonstrated

This project demonstrates practical experience with:

- REST API testing
- Postman
- API authentication
- JavaScript API assertions
- Dynamic request chaining
- Environment variables
- Positive and negative testing
- Newman CLI
- MySQL
- SQL
- Relational database concepts
- PK/FK constraints
- Database integrity testing
- JOINs
- Subqueries
- Aggregate functions
- Duplicate detection
- Business-rule validation
- Test-case design
- Test strategy
- Git & GitHub

---

# Project Limitations

This is a QA portfolio project using demo/test systems and synthetic data.

The CyberNotes Motor Insurance API and the local MySQL database are **independent testing modules**.

Therefore, this project does not represent:

- API-to-database integration testing
- Production insurance data
- Full performance/load testing
- Production security testing

Basic API response-time and authentication validations are included, but they should not be interpreted as dedicated performance or penetration testing.

---

## Author

**Pragya Kapil**

QA Automation | API Testing | Database Testing | SDET
