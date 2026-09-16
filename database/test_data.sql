USE insurance_qa;

INSERT INTO customers
(full_name, email, phone, date_of_birth)
VALUES
('Aarav Sharma', 'aarav.sharma@test.com', '9876543210', '1992-05-15');

INSERT INTO vehicles
(customer_id, registration_number, manufacturer, model, manufacture_year, vehicle_type)
VALUES
(1, 'HR26AB1234', 'Hyundai', 'Creta', 2022, 'SUV');

INSERT INTO policies
(policy_number, customer_id, vehicle_id, policy_type, premium, start_date, end_date, status)
VALUES
('POL-MOTOR-1001', 1, 1, 'Comprehensive', 18500.00,
 '2026-09-16', '2027-09-15', 'ACTIVE');