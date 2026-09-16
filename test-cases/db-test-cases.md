# Motor Insurance Database – Test Cases

## Scope

Database testing was performed on a local MySQL insurance database containing three related entities:

Customer → Vehicle → Policy

Testing covered schema validation, data integrity, constraints, relationships, negative testing, JOIN validation, and business-rule validation.

---

## Database Test Cases

| TC ID    | Test Scenario                                                                   | Test Type                      | Expected Result                                       | Actual Result                |
| -------- | ------------------------------------------------------------------------------- | ------------------------------ | ----------------------------------------------------- | ---------------------------- |
| DB_TC_01 | Insert customer with valid mandatory data                                       | Positive                       | Customer should be inserted successfully              | PASS                         |
| DB_TC_02 | Insert customer with duplicate email                                            | Negative / UNIQUE Constraint   | Database should reject duplicate email                | PASS – Error 1062            |
| DB_TC_03 | Insert customer with NULL full name                                             | Negative / NOT NULL Constraint | Database should reject NULL mandatory field           | PASS – Error 1048            |
| DB_TC_04 | Insert valid vehicle linked to existing customer                                | Positive / FK                  | Vehicle should be inserted successfully               | PASS                         |
| DB_TC_05 | Insert vehicle with non-existing customer ID                                    | Negative / FK Constraint       | Database should reject invalid foreign key            | PASS – Error 1452            |
| DB_TC_06 | Insert valid motor insurance policy                                             | Positive                       | Policy should be inserted successfully                | PASS                         |
| DB_TC_07 | Validate Customer → Vehicle → Policy relationship using JOIN                    | Integration / Data Validation  | Correct related records should be returned            | PASS                         |
| DB_TC_08 | Validate policy end date is greater than start date using CASE                  | Business Rule                  | Valid policy should return PASS                       | PASS                         |
| DB_TC_09 | Insert policy where end date is earlier than start date before CHECK constraint | Negative / Business Rule       | Validation query should identify invalid policy       | PASS – Invalid data detected |
| DB_TC_10 | Add CHECK constraint for policy dates                                           | Constraint Validation          | Constraint should enforce end date > start date       | PASS                         |
| DB_TC_11 | Insert invalid policy after CHECK constraint                                    | Negative / CHECK Constraint    | Database should reject invalid dates                  | PASS – Error 3819            |
| DB_TC_12 | Check for vehicles without valid customers                                      | Referential Integrity          | No orphan vehicle records should exist                | PASS – 0 rows                |
| DB_TC_13 | Check for policies without valid customer/vehicle relationships                 | Referential Integrity          | No orphan policy records should exist                 | PASS – 0 rows                |
| DB_TC_14 | Check for duplicate policy numbers using GROUP BY and HAVING                    | Data Quality                   | No duplicate policy numbers should exist              | PASS – 0 rows                |
| DB_TC_15 | Count policies by policy type                                                   | Aggregation                    | Correct policy count should be returned for each type | PASS                         |
| DB_TC_16 | Find policy with highest premium using ORDER BY and LIMIT                       | Data Validation                | Highest-premium policy should be returned             | PASS                         |

---

## Key SQL Concepts Demonstrated

- Primary Keys
- Foreign Keys
- UNIQUE constraints
- NOT NULL constraints
- CHECK constraints
- INSERT and DELETE operations
- INNER JOIN
- LEFT JOIN
- CASE expressions
- GROUP BY
- HAVING
- COUNT
- MAX and AVG
- Subqueries
- ORDER BY
- LIMIT
- Referential-integrity validation
- Positive and negative database testing

---

## Defect Prevention Example

During testing, a policy with an end date earlier than its start date could initially be inserted into the database.

A SQL validation query using `CASE` detected the invalid business data.

A database CHECK constraint was subsequently introduced:

```sql
CHECK (end_date > start_date)
```
