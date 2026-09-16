USE insurance_qa;

-- =====================================================
-- 1. CUSTOMER DATA VALIDATION
-- =====================================================

SELECT * FROM customers;


-- =====================================================
-- 2. VEHICLE DATA VALIDATION
-- =====================================================

SELECT * FROM vehicles;


-- =====================================================
-- 3. POLICY DATA VALIDATION
-- =====================================================

SELECT * FROM policies;


-- =====================================================
-- 4. CUSTOMER - VEHICLE - POLICY JOIN VALIDATION
-- =====================================================

SELECT
    p.policy_number,
    c.full_name,
    v.registration_number,
    v.manufacturer,
    v.model,
    p.policy_type,
    p.premium,
    p.status
FROM policies p
JOIN customers c
    ON p.customer_id = c.customer_id
JOIN vehicles v
    ON p.vehicle_id = v.vehicle_id
WHERE p.policy_number = 'POL-MOTOR-1001';


-- =====================================================
-- 5. POLICY DATE BUSINESS-RULE VALIDATION
-- =====================================================

SELECT
    policy_number,
    start_date,
    end_date,
    CASE
        WHEN end_date > start_date THEN 'PASS'
        ELSE 'FAIL'
    END AS date_validation
FROM policies;


-- =====================================================
-- 6. ORPHAN VEHICLE VALIDATION
-- =====================================================

SELECT
    v.vehicle_id,
    v.registration_number,
    v.customer_id
FROM vehicles v
LEFT JOIN customers c
    ON v.customer_id = c.customer_id
WHERE c.customer_id IS NULL;


-- =====================================================
-- 7. ORPHAN POLICY VALIDATION
-- =====================================================

SELECT
    p.policy_id,
    p.policy_number,
    p.customer_id,
    p.vehicle_id
FROM policies p
LEFT JOIN customers c
    ON p.customer_id = c.customer_id
LEFT JOIN vehicles v
    ON p.vehicle_id = v.vehicle_id
WHERE c.customer_id IS NULL
   OR v.vehicle_id IS NULL;


-- =====================================================
-- 8. DUPLICATE POLICY VALIDATION
-- =====================================================

SELECT
    policy_number,
    COUNT(*) AS duplicate_count
FROM policies
GROUP BY policy_number
HAVING COUNT(*) > 1;


-- =====================================================
-- 9. SECOND-HIGHEST PREMIUM
-- =====================================================

SELECT MAX(premium) AS second_highest_premium
FROM policies
WHERE premium < (
    SELECT MAX(premium)
    FROM policies
);


-- =====================================================
-- 10. POLICY COUNT BY TYPE
-- =====================================================

SELECT
    policy_type,
    COUNT(*) AS total_policies
FROM policies
GROUP BY policy_type;


-- =====================================================
-- 11. POLICIES ABOVE AVERAGE PREMIUM
-- =====================================================

SELECT
    policy_number,
    premium
FROM policies
WHERE premium > (
    SELECT AVG(premium)
    FROM policies
);


-- =====================================================
-- 12. HIGHEST-PREMIUM POLICY
-- =====================================================

SELECT
    policy_number,
    premium
FROM policies
ORDER BY premium DESC
LIMIT 1;