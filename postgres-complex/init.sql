-- Complex schema with many interconnected tables for testing pam explain
-- Extended "The Office" themed database with rich relationships

-- Custom types
CREATE TYPE employment_status AS ENUM ('Active', 'On Leave', 'Terminated', 'Resigned');
CREATE TYPE project_status AS ENUM ('Planning', 'In Progress', 'On Hold', 'Completed', 'Cancelled');
CREATE TYPE task_priority AS ENUM ('Low', 'Medium', 'High', 'Critical');
CREATE TYPE meeting_type AS ENUM ('Team', 'Client', 'Training', 'Review', 'Brainstorm');
CREATE TYPE expense_status AS ENUM ('Pending', 'Approved', 'Rejected', 'Reimbursed');
CREATE TYPE leave_type AS ENUM ('Vacation', 'Sick', 'Personal', 'Bereavement', 'Jury Duty');
CREATE TYPE training_level AS ENUM ('Beginner', 'Intermediate', 'Advanced', 'Expert');
CREATE TYPE contract_type AS ENUM ('Permanent', 'Contract', 'Intern', 'Temporary');
CREATE TYPE order_status AS ENUM ('Draft', 'Pending', 'Confirmed', 'Shipped', 'Delivered', 'Cancelled');

CREATE DOMAIN usd_amount AS NUMERIC(12,2);
CREATE DOMAIN percent_range AS NUMERIC(5,2);

-- Core tables
CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL,
    budget usd_amount,
    head_count INT,
    metadata JSONB
);

CREATE TABLE offices (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(200) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL DEFAULT 'USA',
    postal_code VARCHAR(20),
    phone VARCHAR(20),
    manager_id INT,
    established_date DATE
);

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    position VARCHAR(100) NOT NULL,
    status employment_status DEFAULT 'Active',
    contract_type contract_type DEFAULT 'Permanent',
    salary usd_amount,
    salary_grade NUMERIC(5,2),
    date_of_birth DATE,
    hire_date DATE NOT NULL,
    termination_date DATE,
    office_id INT REFERENCES offices(id),
    department_id INT REFERENCES departments(id),
    reports_to INT REFERENCES employees(id),
    metadata JSON
);

-- Projects and related tables
CREATE TABLE clients (
    id SERIAL PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL,
    industry VARCHAR(50),
    contact_person VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(200),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(20),
    status VARCHAR(20) DEFAULT 'Active',
    created_date DATE DEFAULT CURRENT_DATE,
    metadata JSONB
);

CREATE TABLE projects (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    status project_status DEFAULT 'Planning',
    client_id INT REFERENCES clients(id),
    lead_developer_id INT REFERENCES employees(id),
    project_manager_id INT REFERENCES employees(id),
    department_id INT REFERENCES departments(id),
    start_date DATE,
    end_date DATE,
    estimated_budget usd_amount,
    actual_budget usd_amount,
    priority task_priority DEFAULT 'Medium',
    completion_percentage percent_range DEFAULT 0,
    metadata JSONB
);

CREATE TABLE project_assignments (
    id SERIAL PRIMARY KEY,
    project_id INT REFERENCES projects(id),
    employee_id INT REFERENCES employees(id),
    role VARCHAR(50),
    allocation_percent percent_range,
    start_date DATE,
    end_date DATE,
    hourly_rate DECIMAL(10,2),
    billable BOOLEAN DEFAULT TRUE,
    metadata JSONB,
    UNIQUE(project_id, employee_id)
);

CREATE TABLE tasks (
    id SERIAL PRIMARY KEY,
    project_id INT REFERENCES projects(id),
    title VARCHAR(200) NOT NULL,
    description TEXT,
    assigned_to INT REFERENCES employees(id),
    status project_status DEFAULT 'Planning',
    priority task_priority DEFAULT 'Medium',
    estimated_hours DECIMAL(6,2),
    actual_hours DECIMAL(6,2),
    due_date DATE,
    completed_date DATE,
    tags TEXT[],
    metadata JSONB
);

CREATE TABLE time_entries (
    id SERIAL PRIMARY KEY,
    task_id INT REFERENCES tasks(id),
    project_id INT REFERENCES projects(id),
    date_worked DATE NOT NULL,
    hours_worked DECIMAL(6,2) NOT NULL,
    description TEXT,
    billable BOOLEAN DEFAULT TRUE,
    bill_rate DECIMAL(10,2),
    tags TEXT[],
    metadata JSONB
);

-- Financial tables
CREATE TABLE expenses (
    id SERIAL PRIMARY KEY,
    employee_id INT REFERENCES employees(id),
    project_id INT REFERENCES projects(id),
    category VARCHAR(50) NOT NULL,
    amount usd_amount NOT NULL,
    expense_date DATE NOT NULL,
    description TEXT,
    status expense_status DEFAULT 'Pending',
    receipt_url VARCHAR(200),
    submitted_date DATE DEFAULT CURRENT_DATE,
    reimbursed_date DATE,
    receipt_image BYTEA,
    metadata JSONB
);

CREATE TABLE budgets (
    id SERIAL PRIMARY KEY,
    department_id INT REFERENCES departments(id),
    project_id INT REFERENCES projects(id),
    fiscal_year INT NOT NULL,
    quarter INT,
    category VARCHAR(50),
    allocated_amount usd_amount NOT NULL,
    spent_amount usd_amount DEFAULT 0,
    remaining_amount usd_amount GENERATED ALWAYS AS (allocated_amount - spent_amount) STORED,
    start_date DATE,
    end_date DATE,
    metadata JSONB
);

CREATE TABLE invoices (
    id SERIAL PRIMARY KEY,
    client_id INT REFERENCES clients(id),
    project_id INT REFERENCES projects(id),
    invoice_number VARCHAR(50) UNIQUE NOT NULL,
    invoice_date DATE NOT NULL,
    due_date DATE NOT NULL,
    paid_date DATE,
    subtotal usd_amount NOT NULL,
    tax_amount usd_amount DEFAULT 0,
    total_amount usd_amount GENERATED ALWAYS AS (subtotal + tax_amount) STORED,
    status VARCHAR(20) DEFAULT 'Pending',
    created_by INT REFERENCES employees(id),
    notes TEXT,
    metadata JSONB
);

CREATE TABLE invoice_line_items (
    id SERIAL PRIMARY KEY,
    invoice_id INT REFERENCES invoices(id),
    time_entry_id INT REFERENCES time_entries(id),
    description TEXT NOT NULL,
    quantity DECIMAL(10,2) DEFAULT 1,
    unit_price DECIMAL(10,2) NOT NULL,
    line_total usd_amount GENERATED ALWAYS AS (quantity * unit_price) STORED,
    metadata JSONB
);

-- HR tables
CREATE TABLE benefits (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    benefit_type VARCHAR(50) NOT NULL,
    cost_to_company usd_amount,
    cost_to_employee usd_amount DEFAULT 0,
    effective_date DATE,
    termination_date DATE,
    metadata JSONB
);





-- Communication tables



-- Inventory/Supply tables
CREATE TABLE suppliers (
    id SERIAL PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(200),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50) DEFAULT 'USA',
    postal_code VARCHAR(20),
    rating DECIMAL(3,2),
    status VARCHAR(20) DEFAULT 'Active',
    metadata JSONB
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    sku VARCHAR(50) UNIQUE,
    category VARCHAR(50),
    unit_price DECIMAL(10,2) NOT NULL,
    cost_price DECIMAL(10,2),
    supplier_id INT REFERENCES suppliers(id),
    stock_quantity INT DEFAULT 0,
    reorder_level INT DEFAULT 10,
    metadata JSONB
);

CREATE TABLE purchase_orders (
    id SERIAL PRIMARY KEY,
    supplier_id INT REFERENCES suppliers(id),
    order_number VARCHAR(50) UNIQUE NOT NULL,
    order_date DATE DEFAULT CURRENT_DATE,
    expected_delivery_date DATE,
    actual_delivery_date DATE,
    status order_status DEFAULT 'Draft',
    total_amount usd_amount,
    notes TEXT,
    metadata JSONB
);

CREATE TABLE purchase_order_items (
    id SERIAL PRIMARY KEY,
    purchase_order_id INT REFERENCES purchase_orders(id),
    product_id INT REFERENCES products(id),
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    line_total usd_amount GENERATED ALWAYS AS (quantity * unit_price) STORED,
    received_quantity INT DEFAULT 0,
    metadata JSONB
);

CREATE TABLE inventory_transactions (
    id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(id),
    transaction_type VARCHAR(20) NOT NULL,
    quantity INT NOT NULL,
    transaction_date DATE DEFAULT CURRENT_DATE,
    reference_id INT,
    reference_type VARCHAR(50),
    notes TEXT,
    metadata JSONB
);

-- Documents and files

-- Teams and groups

-- Audit and logging
CREATE TABLE audit_logs (
    id SERIAL PRIMARY KEY,
    table_name VARCHAR(100) NOT NULL,
    record_id INT NOT NULL,
    action VARCHAR(20) NOT NULL,
    old_values JSONB,
    new_values JSONB,
    action_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(45),
    user_agent TEXT,
    metadata JSONB
);

-- Insert sample data
INSERT INTO departments (id, name, location, budget, head_count, metadata) VALUES
(1, 'Sales', 'Scranton', 500000.00, 15, '{"notes": "High-performing team"}'),
(2, 'Accounting', 'Scranton', 300000.00, 5, '{"notes": "Strict budget controls"}'),
(3, 'Human Resources', 'Scranton', 200000.00, 3, '{"notes": "Focus on wellness"}'),
(4, 'Management', 'Scranton', 400000.00, 2, '{"notes": "Leadership"}'),
(5, 'Warehouse', 'Scranton', 150000.00, 10, '{"notes": "Logistics"}'),
(6, 'IT Support', 'Scranton', 250000.00, 4, '{"notes": "Tech maintenance"}'),
(7, 'Marketing', 'New York', 350000.00, 6, '{"notes": "Brand outreach"}'),
(8, 'Customer Service', 'Scranton', 180000.00, 8, '{"notes": "Customer support"}');

INSERT INTO offices (id, name, address, city, state, postal_code, phone, manager_id, established_date) VALUES
(1, 'Scranton Branch', '1725 Slough Avenue', 'Scranton', 'PA', '18503', '570-555-0100', 1, '2000-01-01'),
(2, 'New York Branch', '350 Fifth Avenue', 'New York', 'NY', '10118', '212-555-0200', NULL, '2000-01-01'),
(3, 'Buffalo Branch', '247 Delaware Avenue', 'Buffalo', 'NY', '14202', '716-555-0300', NULL, '2005-01-01');

INSERT INTO employees (id, first_name, last_name, email, position, status, salary, hire_date, office_id, department_id, reports_to, manager_id) VALUES
(1, 'Michael', 'Scott', 'michael.scott@dundermifflin.com', 'Regional Manager', 'Active', 75000.00, '2001-02-15', 1, 4, NULL, NULL),
(2, 'Dwight', 'Schrute', 'dwight.schrute@dundermifflin.com', 'Assistant to the Regional Manager', 'Active', 55000.00, '2001-03-01', 1, 1, 1, 1),
(3, 'Jim', 'Halpert', 'jim.halpert@dundermifflin.com', 'Sales Representative', 'Active', 48000.00, '2001-06-12', 1, 1, 1, 1),
(4, 'Pam', 'Beesly', 'pam.beesly@dundermifflin.com', 'Receptionist', 'Active', 42000.00, '2001-07-15', 1, 3, 1, 1),
(5, 'Angela', 'Martin', 'angela.martin@dundermifflin.com', 'Head of Accounting', 'Active', 60000.00, '2000-10-10', 1, 2, 1, 1),
(6, 'Oscar', 'Martinez', 'oscar.martinez@dundermifflin.com', 'Accountant', 'Active', 49000.00, '2001-04-01', 1, 2, 5, 5),
(7, 'Kevin', 'Malone', 'kevin.malone@dundermifflin.com', 'Accountant', 'Active', 47000.00, '2001-08-20', 1, 2, 5, 5),
(8, 'Toby', 'Flenderson', 'toby.flenderson@dundermifflin.com', 'HR Representative', 'Active', 53000.00, '2002-01-10', 1, 3, 1, 1),
(9, 'Darryl', 'Philbin', 'darryl.philbin@dundermifflin.com', 'Warehouse Foreman', 'Active', 52000.00, '2002-06-17', 1, 5, 1, 1),
(10, 'Stanley', 'Hudson', 'stanley.hudson@dundermifflin.com', 'Sales Representative', 'Active', 48500.00, '2001-09-15', 1, 1, 1, 1);

INSERT INTO clients (id, company_name, industry, contact_person, email, phone) VALUES
(1, 'Dwight Farms', 'Agriculture', 'Dwight Schrute', 'dwight@schrutefarms.com', '570-555-0001'),
(2, 'Vance Refrigeration', 'Manufacturing', 'Bob Vance', 'bob@vanceref.com', '570-555-0002'),
(3, 'Blue Cross Pennsylvania', 'Insurance', 'David Wallace', 'david@bluecrosspa.com', '570-555-0003');

INSERT INTO projects (id, name, description, status, client_id, lead_developer_id, project_manager_id, department_id, start_date, end_date, estimated_budget, priority) VALUES
(1, 'Website Redesign', 'Complete overhaul of company website', 'In Progress', 3, 3, 1, 7, '2023-01-01', '2023-06-30', 50000.00, 'High'),
(2, 'Warehouse Automation', 'Automate warehouse inventory system', 'Planning', NULL, 9, 1, 5, '2023-03-01', '2023-12-31', 100000.00, 'Medium'),
(3, 'CRM Implementation', 'Implement new CRM system', 'Completed', 1, 2, 1, 1, '2022-09-01', '2022-12-31', 35000.00, 'High');

INSERT INTO tasks (id, project_id, title, description, assigned_to, status, priority, estimated_hours, due_date) VALUES
(1, 1, 'Design Homepage', 'Create mockups for new homepage', 3, 'Completed', 'High', 20.0, '2023-02-15'),
(2, 1, 'Develop Backend API', 'Build REST API for website', 3, 'In Progress', 'High', 40.0, '2023-04-30'),
(3, 1, 'Content Creation', 'Write copy for all pages', 4, 'Planning', 'Medium', 15.0, '2023-05-15'),
(4, 2, 'Assess Current System', 'Evaluate warehouse inventory process', 9, 'Completed', 'High', 10.0, '2023-03-15'),
(5, 3, 'Install CRM Software', 'Deploy CRM to all sales machines', 2, 'Completed', 'Critical', 8.0, '2022-10-15');

INSERT INTO time_entries (id, task_id, project_id, date_worked, hours_worked, description, billable) VALUES
(1, 1, 1, '2023-02-01', 4.0, 'Homepage wireframe design', TRUE),
(2, 1, 1, '2023-02-02', 5.0, 'Homepage visual design', TRUE),
(3, 2, 1, '2023-04-01', 6.0, 'API endpoint development', TRUE),
(4, 5, 3, '2022-10-01', 3.0, 'CRM software installation', TRUE),
(5, 4, 2, '2023-03-10', 8.0, 'Warehouse process analysis', TRUE);

INSERT INTO suppliers (id, company_name, contact_person, email, phone, rating) VALUES
(1, 'Office Depot', 'John Smith', 'john@officedepot.com', '800-555-0001', 4.5),
(2, 'Tech Supplies Inc', 'Jane Doe', 'jane@techsupplies.com', '800-555-0002', 4.2);

INSERT INTO products (id, name, description, sku, category, unit_price, cost_price, supplier_id, stock_quantity) VALUES
(1, 'Office Paper', 'White 8.5x11 paper, ream of 500', 'PAP-001', 'Office Supplies', 5.99, 3.50, 1, 200),
(2, 'Printer Toner', 'Black toner cartridge', 'TON-001', 'Office Supplies', 85.00, 50.00, 2, 25),
(3, 'Desk Chair', 'Ergonomic office chair', 'CHR-001', 'Furniture', 199.99, 120.00, 1, 15);





-- Add some relationships for testing
UPDATE employees SET reports_to = 5 WHERE id IN (6, 7);
