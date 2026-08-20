SET search_path TO insurance;

-- ============================================================
-- UNIQUE BUSINESS IDENTIFIERS
-- ============================================================

ALTER TABLE locations
    ADD CONSTRAINT uq_location
    UNIQUE (city, state, pincode);

ALTER TABLE customers
    ADD CONSTRAINT uq_customer_code
    UNIQUE (customer_code);

ALTER TABLE customers
    ADD CONSTRAINT uq_customer_email
    UNIQUE (email);

ALTER TABLE agents
    ADD CONSTRAINT uq_agent_code
    UNIQUE (agent_code);

ALTER TABLE agents
    ADD CONSTRAINT uq_agent_email
    UNIQUE (email);

ALTER TABLE vehicles
    ADD CONSTRAINT uq_vehicle_registration
    UNIQUE (registration_number);

ALTER TABLE policies
    ADD CONSTRAINT uq_policy_number
    UNIQUE (policy_number);

ALTER TABLE premium_payments
    ADD CONSTRAINT uq_premium_transaction
    UNIQUE (transaction_reference);

ALTER TABLE claims
    ADD CONSTRAINT uq_claim_number
    UNIQUE (claim_number);

ALTER TABLE claim_payments
    ADD CONSTRAINT uq_claim_transaction
    UNIQUE (transaction_reference);


-- ============================================================
-- LOCATION VALIDATIONS
-- ============================================================

ALTER TABLE locations
    ADD CONSTRAINT chk_location_region
    CHECK (region IN ('North', 'South', 'East', 'West', 'Central', 'Northeast'));


-- ============================================================
-- CUSTOMER VALIDATIONS
-- ============================================================

ALTER TABLE customers
    ADD CONSTRAINT chk_customer_gender
    CHECK (gender IN ('Male', 'Female', 'Other'));

ALTER TABLE customers
    ADD CONSTRAINT chk_customer_type
    CHECK (customer_type IN ('Individual', 'Corporate'));

ALTER TABLE customers
    ADD CONSTRAINT chk_customer_kyc_status
    CHECK (kyc_status IN ('Pending', 'Verified', 'Rejected'));

ALTER TABLE customers
    ADD CONSTRAINT chk_customer_dob
    CHECK (date_of_birth < registration_date);


-- ============================================================
-- AGENT VALIDATIONS
-- ============================================================

ALTER TABLE agents
    ADD CONSTRAINT chk_agent_status
    CHECK (agent_status IN ('Active', 'Inactive', 'Suspended'));

ALTER TABLE agents
    ADD CONSTRAINT chk_agent_joining_date
    CHECK (joining_date <= CURRENT_DATE);


-- ============================================================
-- VEHICLE VALIDATIONS
-- ============================================================

ALTER TABLE vehicles
    ADD CONSTRAINT chk_vehicle_year
    CHECK (
        manufacture_year BETWEEN 1980
        AND EXTRACT(YEAR FROM CURRENT_DATE)::INT
    );

ALTER TABLE vehicles
    ADD CONSTRAINT chk_vehicle_value
    CHECK (vehicle_value > 0);

ALTER TABLE vehicles
    ADD CONSTRAINT chk_engine_capacity
    CHECK (engine_capacity_cc IS NULL OR engine_capacity_cc > 0);

ALTER TABLE vehicles
    ADD CONSTRAINT chk_fuel_type
    CHECK (
        fuel_type IN (
            'Petrol',
            'Diesel',
            'CNG',
            'Electric',
            'Hybrid'
        )
    );


-- ============================================================
-- POLICY VALIDATIONS
-- ============================================================

ALTER TABLE policies
    ADD CONSTRAINT chk_policy_dates
    CHECK (end_date > start_date);

ALTER TABLE policies
    ADD CONSTRAINT chk_policy_issue_date
    CHECK (issue_date <= start_date);

ALTER TABLE policies
    ADD CONSTRAINT chk_policy_premium
    CHECK (premium_amount > 0);

ALTER TABLE policies
    ADD CONSTRAINT chk_policy_sum_insured
    CHECK (sum_insured > 0);

ALTER TABLE policies
    ADD CONSTRAINT chk_policy_deductible
    CHECK (deductible_amount >= 0);

ALTER TABLE policies
    ADD CONSTRAINT chk_policy_type
    CHECK (
        policy_type IN (
            'Comprehensive',
            'Third Party',
            'Own Damage'
        )
    );

ALTER TABLE policies
    ADD CONSTRAINT chk_policy_status
    CHECK (
        policy_status IN (
            'Active',
            'Expired',
            'Cancelled',
            'Pending',
            'Lapsed'
        )
    );


-- ============================================================
-- POLICY COVERAGE VALIDATIONS
-- ============================================================

ALTER TABLE policy_coverage
    ADD CONSTRAINT chk_coverage_limit
    CHECK (coverage_limit > 0);

ALTER TABLE policy_coverage
    ADD CONSTRAINT chk_coverage_deductible
    CHECK (deductible_amount >= 0);

ALTER TABLE policy_coverage
    ADD CONSTRAINT chk_coverage_premium
    CHECK (premium_component > 0);

ALTER TABLE policy_coverage
    ADD CONSTRAINT chk_coverage_status
    CHECK (
        coverage_status IN (
            'Active',
            'Inactive',
            'Expired'
        )
    );


-- ============================================================
-- PREMIUM PAYMENT VALIDATIONS
-- ============================================================

ALTER TABLE premium_payments
    ADD CONSTRAINT chk_premium_payment_amount
    CHECK (amount > 0);

ALTER TABLE premium_payments
    ADD CONSTRAINT chk_premium_payment_method
    CHECK (
        payment_method IN (
            'Bank Transfer',
            'Credit Card',
            'Debit Card',
            'UPI',
            'Cheque',
            'Cash'
        )
    );

ALTER TABLE premium_payments
    ADD CONSTRAINT chk_premium_payment_status
    CHECK (
        payment_status IN (
            'Completed',
            'Pending',
            'Failed',
            'Refunded'
        )
    );


-- ============================================================
-- CLAIM VALIDATIONS
-- ============================================================

ALTER TABLE claims
    ADD CONSTRAINT chk_claim_dates
    CHECK (claim_date >= incident_date);

ALTER TABLE claims
    ADD CONSTRAINT chk_claim_estimated_amount
    CHECK (estimated_amount > 0);

ALTER TABLE claims
    ADD CONSTRAINT chk_claim_approved_amount
    CHECK (
        approved_amount IS NULL
        OR (
            approved_amount >= 0
            AND approved_amount <= estimated_amount
        )
    );

ALTER TABLE claims
    ADD CONSTRAINT chk_claim_type
    CHECK (
        claim_type IN (
            'Accident',
            'Theft',
            'Fire',
            'Natural Disaster',
            'Third Party Damage'
        )
    );

ALTER TABLE claims
    ADD CONSTRAINT chk_claim_status
    CHECK (
        claim_status IN (
            'Submitted',
            'Under Review',
            'Approved',
            'Rejected',
            'Settled',
            'Closed'
        )
    );


-- ============================================================
-- CLAIM ASSESSMENT VALIDATIONS
-- ============================================================

ALTER TABLE claim_assessments
    ADD CONSTRAINT chk_assessment_date
    CHECK (assessment_date >= CURRENT_DATE - INTERVAL '10 years');

ALTER TABLE claim_assessments
    ADD CONSTRAINT chk_estimated_damage
    CHECK (estimated_damage > 0);

ALTER TABLE claim_assessments
    ADD CONSTRAINT chk_assessment_approved_amount
    CHECK (
        approved_amount IS NULL
        OR (
            approved_amount >= 0
            AND approved_amount <= estimated_damage
        )
    );

ALTER TABLE claim_assessments
    ADD CONSTRAINT chk_assessment_status
    CHECK (
        assessment_status IN (
            'Pending',
            'Approved',
            'Rejected',
            'Requires Review'
        )
    );


-- ============================================================
-- CLAIM DOCUMENT VALIDATIONS
-- ============================================================

ALTER TABLE claim_documents
    ADD CONSTRAINT chk_document_status
    CHECK (
        document_status IN (
            'Uploaded',
            'Missing',
            'Rejected'
        )
    );

ALTER TABLE claim_documents
    ADD CONSTRAINT chk_document_verification
    CHECK (
        verification_status IN (
            'Pending',
            'Verified',
            'Rejected'
        )
    );


-- ============================================================
-- GARAGE VALIDATIONS
-- ============================================================

ALTER TABLE garages
    ADD CONSTRAINT chk_garage_network_type
    CHECK (
        network_type IN (
            'Network',
            'Non-Network'
        )
    );

ALTER TABLE garages
    ADD CONSTRAINT chk_garage_status
    CHECK (
        approved_status IN (
            'Approved',
            'Pending',
            'Suspended'
        )
    );


-- ============================================================
-- HOSPITAL VALIDATIONS
-- ============================================================

ALTER TABLE hospitals
    ADD CONSTRAINT chk_hospital_network
    CHECK (
        network_status IN (
            'Network',
            'Non-Network'
        )
    );


-- ============================================================
-- CLAIM PAYMENT VALIDATIONS
-- ============================================================

ALTER TABLE claim_payments
    ADD CONSTRAINT chk_claim_payment_amount
    CHECK (payment_amount > 0);

ALTER TABLE claim_payments
    ADD CONSTRAINT chk_claim_payment_method
    CHECK (
        payment_method IS NULL
        OR payment_method IN (
            'Bank Transfer',
            'Cheque',
            'UPI',
            'NEFT',
            'RTGS'
        )
    );

ALTER TABLE claim_payments
    ADD CONSTRAINT chk_claim_payment_status
    CHECK (
        payment_status IN (
            'Pending',
            'Processing',
            'Completed',
            'Failed',
            'Reversed'
        )
    );


-- ============================================================
-- VERIFY CONSTRAINTS
-- ============================================================

SELECT
    COUNT(*) AS constraint_count
FROM information_schema.table_constraints
WHERE constraint_schema = 'insurance';