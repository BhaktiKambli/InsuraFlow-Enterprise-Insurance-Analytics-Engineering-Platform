SET search_path TO insurance;

-- ============================================================
-- CUSTOMER INDEXES
-- ============================================================

CREATE INDEX idx_customers_location
    ON customers(location_id);

CREATE INDEX idx_customers_registration_date
    ON customers(registration_date);

CREATE INDEX idx_customers_kyc_status
    ON customers(kyc_status);


-- ============================================================
-- AGENT INDEXES
-- ============================================================

CREATE INDEX idx_agents_location
    ON agents(location_id);

CREATE INDEX idx_agents_status
    ON agents(agent_status);


-- ============================================================
-- VEHICLE INDEXES
-- ============================================================

CREATE INDEX idx_vehicles_customer
    ON vehicles(customer_id);

CREATE INDEX idx_vehicles_make_model
    ON vehicles(make, model);

CREATE INDEX idx_vehicles_fuel_type
    ON vehicles(fuel_type);


-- ============================================================
-- POLICY INDEXES
-- ============================================================

CREATE INDEX idx_policies_customer
    ON policies(customer_id);

CREATE INDEX idx_policies_vehicle
    ON policies(vehicle_id);

CREATE INDEX idx_policies_agent
    ON policies(agent_id);

CREATE INDEX idx_policies_status
    ON policies(policy_status);

CREATE INDEX idx_policies_dates
    ON policies(start_date, end_date);

CREATE INDEX idx_policies_policy_type
    ON policies(policy_type);


-- ============================================================
-- POLICY COVERAGE INDEXES
-- ============================================================

CREATE INDEX idx_policy_coverage_policy
    ON policy_coverage(policy_id);

CREATE INDEX idx_policy_coverage_type
    ON policy_coverage(coverage_type);


-- ============================================================
-- PREMIUM PAYMENT INDEXES
-- ============================================================

CREATE INDEX idx_premium_payments_policy
    ON premium_payments(policy_id);

CREATE INDEX idx_premium_payments_date
    ON premium_payments(payment_date);

CREATE INDEX idx_premium_payments_status
    ON premium_payments(payment_status);


-- ============================================================
-- CLAIM INDEXES
-- ============================================================

CREATE INDEX idx_claims_policy
    ON claims(policy_id);

CREATE INDEX idx_claims_vehicle
    ON claims(vehicle_id);

CREATE INDEX idx_claims_location
    ON claims(incident_location_id);

CREATE INDEX idx_claims_date
    ON claims(claim_date);

CREATE INDEX idx_claims_incident_date
    ON claims(incident_date);

CREATE INDEX idx_claims_status
    ON claims(claim_status);

CREATE INDEX idx_claims_type
    ON claims(claim_type);


-- ============================================================
-- CLAIM ASSESSMENT INDEXES
-- ============================================================

CREATE INDEX idx_claim_assessments_claim
    ON claim_assessments(claim_id);

CREATE INDEX idx_claim_assessments_date
    ON claim_assessments(assessment_date);

CREATE INDEX idx_claim_assessments_status
    ON claim_assessments(assessment_status);


-- ============================================================
-- CLAIM DOCUMENT INDEXES
-- ============================================================

CREATE INDEX idx_claim_documents_claim
    ON claim_documents(claim_id);

CREATE INDEX idx_claim_documents_status
    ON claim_documents(document_status);

CREATE INDEX idx_claim_documents_verification
    ON claim_documents(verification_status);


-- ============================================================
-- GARAGE INDEXES
-- ============================================================

CREATE INDEX idx_garages_location
    ON garages(location_id);

CREATE INDEX idx_garages_network
    ON garages(network_type);


-- ============================================================
-- HOSPITAL INDEXES
-- ============================================================

CREATE INDEX idx_hospitals_location
    ON hospitals(location_id);

CREATE INDEX idx_hospitals_network
    ON hospitals(network_status);


-- ============================================================
-- CLAIM PAYMENT INDEXES
-- ============================================================

CREATE INDEX idx_claim_payments_claim
    ON claim_payments(claim_id);

CREATE INDEX idx_claim_payments_garage
    ON claim_payments(garage_id);

CREATE INDEX idx_claim_payments_hospital
    ON claim_payments(hospital_id);

CREATE INDEX idx_claim_payments_date
    ON claim_payments(payment_date);

CREATE INDEX idx_claim_payments_status
    ON claim_payments(payment_status);


-- ============================================================
-- VERIFY INDEXES
-- ============================================================

SELECT
    schemaname,
    tablename,
    indexname
FROM pg_indexes
WHERE schemaname = 'insurance'
ORDER BY tablename, indexname;




-- SELECT
--     table_name,
--     COUNT(*) AS column_count
-- FROM information_schema.columns
-- WHERE table_schema = 'insurance'
-- GROUP BY table_name
-- ORDER BY table_name;