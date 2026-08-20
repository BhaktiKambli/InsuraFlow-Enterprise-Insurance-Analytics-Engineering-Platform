SET search_path TO insurance;

-- ============================================================
-- 1. LOCATIONS
-- ============================================================
CREATE TABLE locations (
    location_id      BIGSERIAL PRIMARY KEY,
    city             VARCHAR(100) NOT NULL,
    state            VARCHAR(100) NOT NULL,
    state_code       VARCHAR(10) NOT NULL,
    pincode          VARCHAR(10) NOT NULL,
    region           VARCHAR(50) NOT NULL,
    created_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================
-- 2. CUSTOMERS
-- ============================================================
CREATE TABLE customers (
    customer_id          BIGSERIAL PRIMARY KEY,
    customer_code        VARCHAR(30) NOT NULL,
    first_name            VARCHAR(100) NOT NULL,
    last_name             VARCHAR(100) NOT NULL,
    date_of_birth         DATE NOT NULL,
    gender                VARCHAR(20) NOT NULL,
    email                 VARCHAR(255) NOT NULL,
    phone                 VARCHAR(20) NOT NULL,
    occupation            VARCHAR(100),
    marital_status        VARCHAR(30),
    location_id           BIGINT NOT NULL,
    customer_type         VARCHAR(30) NOT NULL DEFAULT 'Individual',
    kyc_status            VARCHAR(30) NOT NULL DEFAULT 'Pending',
    kyc_verified_date     DATE,
    registration_date     DATE NOT NULL,
    created_at            TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_customer_location
        FOREIGN KEY (location_id)
        REFERENCES locations(location_id)
);


-- ============================================================
-- 3. AGENTS
-- ============================================================
CREATE TABLE agents (
    agent_id              BIGSERIAL PRIMARY KEY,
    agent_code            VARCHAR(30) NOT NULL,
    first_name            VARCHAR(100) NOT NULL,
    last_name             VARCHAR(100) NOT NULL,
    email                 VARCHAR(255) NOT NULL,
    phone                 VARCHAR(20) NOT NULL,
    location_id           BIGINT NOT NULL,
    branch_name           VARCHAR(150),
    joining_date          DATE NOT NULL,
    agent_status          VARCHAR(30) NOT NULL DEFAULT 'Active',
    created_at            TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_agent_location
        FOREIGN KEY (location_id)
        REFERENCES locations(location_id)
);


-- ============================================================
-- 4. VEHICLES
-- ============================================================
CREATE TABLE vehicles (
    vehicle_id            BIGSERIAL PRIMARY KEY,
    customer_id           BIGINT NOT NULL,
    registration_number   VARCHAR(30) NOT NULL,
    make                  VARCHAR(100) NOT NULL,
    model                 VARCHAR(100) NOT NULL,
    variant               VARCHAR(100),
    manufacture_year      INT NOT NULL,
    registration_date     DATE,
    fuel_type             VARCHAR(30) NOT NULL,
    vehicle_type          VARCHAR(50) NOT NULL,
    engine_capacity_cc    INT,
    vehicle_value         NUMERIC(15,2) NOT NULL,
    created_at            TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_vehicle_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);


-- ============================================================
-- 5. POLICIES
-- ============================================================
CREATE TABLE policies (
    policy_id             BIGSERIAL PRIMARY KEY,
    policy_number         VARCHAR(40) NOT NULL,
    customer_id           BIGINT NOT NULL,
    vehicle_id            BIGINT NOT NULL,
    agent_id              BIGINT NOT NULL,
    policy_type            VARCHAR(50) NOT NULL,
    issue_date             DATE NOT NULL,
    start_date             DATE NOT NULL,
    end_date               DATE NOT NULL,
    renewal_date           DATE,
    premium_amount        NUMERIC(15,2) NOT NULL,
    sum_insured            NUMERIC(15,2) NOT NULL,
    deductible_amount      NUMERIC(15,2) DEFAULT 0,
    policy_status          VARCHAR(30) NOT NULL,
    created_at             TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_policy_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    CONSTRAINT fk_policy_vehicle
        FOREIGN KEY (vehicle_id)
        REFERENCES vehicles(vehicle_id),

    CONSTRAINT fk_policy_agent
        FOREIGN KEY (agent_id)
        REFERENCES agents(agent_id)
);


-- ============================================================
-- 6. POLICY COVERAGE
-- ============================================================
CREATE TABLE policy_coverage (
    policy_coverage_id     BIGSERIAL PRIMARY KEY,
    policy_id              BIGINT NOT NULL,
    coverage_type          VARCHAR(100) NOT NULL,
    coverage_limit         NUMERIC(15,2) NOT NULL,
    deductible_amount      NUMERIC(15,2) DEFAULT 0,
    premium_component      NUMERIC(15,2) NOT NULL,
    coverage_status        VARCHAR(30) NOT NULL DEFAULT 'Active',
    created_at             TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_coverage_policy
        FOREIGN KEY (policy_id)
        REFERENCES policies(policy_id)
);


-- ============================================================
-- 7. PREMIUM PAYMENTS
-- ============================================================
CREATE TABLE premium_payments (
    premium_payment_id     BIGSERIAL PRIMARY KEY,
    policy_id              BIGINT NOT NULL,
    payment_date           DATE NOT NULL,
    amount                 NUMERIC(15,2) NOT NULL,
    payment_method         VARCHAR(50) NOT NULL,
    payment_status         VARCHAR(30) NOT NULL,
    transaction_reference  VARCHAR(100),
    created_at             TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_premium_payment_policy
        FOREIGN KEY (policy_id)
        REFERENCES policies(policy_id)
);


-- ============================================================
-- 8. CLAIMS
-- ============================================================
CREATE TABLE claims (
    claim_id               BIGSERIAL PRIMARY KEY,
    claim_number           VARCHAR(40) NOT NULL,
    policy_id              BIGINT NOT NULL,
    vehicle_id             BIGINT NOT NULL,
    claim_date             DATE NOT NULL,
    incident_date          DATE NOT NULL,
    claim_type             VARCHAR(50) NOT NULL,
    incident_location_id   BIGINT,
    incident_description   TEXT,
    estimated_amount       NUMERIC(15,2) NOT NULL,
    approved_amount        NUMERIC(15,2),
    claim_status           VARCHAR(30) NOT NULL,
    created_at             TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_claim_policy
        FOREIGN KEY (policy_id)
        REFERENCES policies(policy_id),

    CONSTRAINT fk_claim_vehicle
        FOREIGN KEY (vehicle_id)
        REFERENCES vehicles(vehicle_id),

    CONSTRAINT fk_claim_location
        FOREIGN KEY (incident_location_id)
        REFERENCES locations(location_id)
);


-- ============================================================
-- 9. CLAIM ASSESSMENTS
-- ============================================================
CREATE TABLE claim_assessments (
    assessment_id          BIGSERIAL PRIMARY KEY,
    claim_id               BIGINT NOT NULL,
    assessor_name          VARCHAR(150) NOT NULL,
    assessment_date        DATE NOT NULL,
    estimated_damage       NUMERIC(15,2) NOT NULL,
    approved_amount        NUMERIC(15,2),
    assessment_status      VARCHAR(30) NOT NULL,
    remarks                TEXT,
    created_at             TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_assessment_claim
        FOREIGN KEY (claim_id)
        REFERENCES claims(claim_id)
);


-- ============================================================
-- 10. CLAIM DOCUMENTS
-- ============================================================
CREATE TABLE claim_documents (
    claim_document_id      BIGSERIAL PRIMARY KEY,
    claim_id               BIGINT NOT NULL,
    document_type          VARCHAR(100) NOT NULL,
    document_status        VARCHAR(30) NOT NULL,
    uploaded_date          DATE NOT NULL,
    verification_status    VARCHAR(30) NOT NULL,
    created_at             TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_claim_document_claim
        FOREIGN KEY (claim_id)
        REFERENCES claims(claim_id)
);


-- ============================================================
-- 11. GARAGES
-- ============================================================
CREATE TABLE garages (
    garage_id              BIGSERIAL PRIMARY KEY,
    garage_name            VARCHAR(150) NOT NULL,
    location_id            BIGINT NOT NULL,
    network_type           VARCHAR(50) NOT NULL,
    approved_status        VARCHAR(30) NOT NULL DEFAULT 'Approved',
    contact_phone          VARCHAR(20),
    created_at             TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_garage_location
        FOREIGN KEY (location_id)
        REFERENCES locations(location_id)
);


-- ============================================================
-- 12. HOSPITALS
-- ============================================================
CREATE TABLE hospitals (
    hospital_id            BIGSERIAL PRIMARY KEY,
    hospital_name          VARCHAR(150) NOT NULL,
    location_id            BIGINT NOT NULL,
    hospital_type          VARCHAR(50),
    network_status         VARCHAR(30) NOT NULL DEFAULT 'Network',
    contact_phone          VARCHAR(20),
    created_at             TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_hospital_location
        FOREIGN KEY (location_id)
        REFERENCES locations(location_id)
);


-- ============================================================
-- 13. CLAIM PAYMENTS
-- ============================================================
CREATE TABLE claim_payments (
    claim_payment_id       BIGSERIAL PRIMARY KEY,
    claim_id               BIGINT NOT NULL,
    garage_id              BIGINT,
    hospital_id            BIGINT,
    payment_date           DATE,
    payment_amount         NUMERIC(15,2) NOT NULL,
    payment_method         VARCHAR(50),
    payment_status         VARCHAR(30) NOT NULL,
    transaction_reference  VARCHAR(100),
    created_at             TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_claim_payment_claim
        FOREIGN KEY (claim_id)
        REFERENCES claims(claim_id),

    CONSTRAINT fk_claim_payment_garage
        FOREIGN KEY (garage_id)
        REFERENCES garages(garage_id),

    CONSTRAINT fk_claim_payment_hospital
        FOREIGN KEY (hospital_id)
        REFERENCES hospitals(hospital_id)
);




-- SET search_path TO insurance;

-- SELECT table_name
-- FROM information_schema.tables
-- WHERE table_schema = 'insurance'
-- ORDER BY table_name;