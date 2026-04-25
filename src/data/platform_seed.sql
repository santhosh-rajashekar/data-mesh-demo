-- ============================================================
-- Platform Governance Seed Data
-- Run AFTER notebooks 00-04 have created the base tables
-- ============================================================

-- Data Product Registry
INSERT INTO data_mesh_hub.platform.data_product_registry 
(product_id, product_name, domain, owner_group, owner_contact, table_name, status, sla_freshness_hours, quality_score, freshness_status, consumer_count, consumers, created_at, updated_at)
VALUES
('DP-001', 'Application Landscape', 'Enterprise Architecture', 'ea-team', 'ea-team@company.com', 'adoit_product.gold.application_landscape', 'published', 4, 98.5, 'fresh', 10, 'cto-office, risk-committee', current_timestamp(), current_timestamp()),
('DP-002', 'Service Health', 'IT Service Management', 'itsm-team', 'itsm-team@company.com', 'snow_product.gold.service_health', 'published', 2, 95.0, 'fresh', 9, 'cto-office, risk-committee', current_timestamp(), current_timestamp()),
('DP-003', 'Application Risk Profile', 'Cross-Domain', 'data-platform-team', 'platform@company.com', 'data_mesh_hub.cross_domain.application_risk_profile', 'published', 6, 96.0, 'fresh', 10, 'cto-office, risk-committee, compliance', current_timestamp(), current_timestamp());

-- Data Contracts
INSERT INTO data_mesh_hub.platform.data_contracts VALUES
('DC-001', 'DP-001', 'Application Landscape', 'ea-team', 'cto-office', 'active', 4, 95.0, 'v1.0', 30, 'ea-lead@company.com', '#ea-data-products', current_timestamp()),
('DC-002', 'DP-002', 'Service Health', 'itsm-team', 'cto-office', 'active', 2, 90.0, 'v1.0', 14, 'itsm-lead@company.com', '#itsm-data-products', current_timestamp()),
('DC-003', 'DP-002', 'Service Health', 'itsm-team', 'risk-committee', 'active', 2, 90.0, 'v1.0', 14, 'itsm-lead@company.com', '#itsm-data-products', current_timestamp()),
('DC-004', 'DP-003', 'Application Risk Profile', 'data-platform-team', 'cto-office', 'active', 6, 90.0, 'v1.0', 30, 'platform-lead@company.com', '#data-mesh-platform', current_timestamp()),
('DC-005', 'DP-003', 'Application Risk Profile', 'data-platform-team', 'risk-committee', 'active', 6, 90.0, 'v1.0', 30, 'platform-lead@company.com', '#data-mesh-platform', current_timestamp());

-- Domain Maturity Scorecard
INSERT INTO data_mesh_hub.platform.domain_maturity_scorecard VALUES
('Enterprise Architecture', 'Advanced', 92, 95, 90, 98, 88, 95, 92, 90, 85, 2, 3, 99.5),
('IT Service Management', 'Established', 85, 90, 82, 95, 85, 88, 85, 80, 78, 3, 4, 98.0),
('Cross-Domain', 'Established', 88, 85, 88, 96, 90, 92, 90, 82, 80, 2, 5, 99.0);