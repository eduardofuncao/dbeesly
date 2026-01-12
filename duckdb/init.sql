-- "The Office" themed sample schema for DuckDB
-- DuckDB dialect (converted from SQL Server T-SQL)
-- DuckDB is an analytical OLAP database with PostgreSQL-like syntax

-- Departments table
CREATE TABLE departments (
    id INTEGER PRIMARY KEY,
    name VARCHAR NOT NULL,
    location VARCHAR NOT NULL,
    budget DECIMAL(12,2),
    head_count INTEGER,
    metadata VARCHAR  -- TEXT type in DuckDB
);

-- Employees table (optimized for analytics)
CREATE TABLE employees (
    id INTEGER PRIMARY KEY,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    position VARCHAR NOT NULL,
    email VARCHAR NOT NULL,
    phone VARCHAR,
    date_of_birth DATE,
    hire_date DATE NOT NULL,
    salary DECIMAL(10,2),
    office_number VARCHAR,
    department_id INTEGER,
    reports_to INTEGER,
    status VARCHAR,
    favorite_snack VARCHAR,
    hobby VARCHAR,
    car VARCHAR,
    favorite_catchphrase VARCHAR,
    linkedin_profile VARCHAR,
    skills VARCHAR[],  -- Native array type instead of JSON string
    performance_rating DECIMAL(3,1)
);

-- Timesheets table
CREATE TABLE timesheets (
    id INTEGER PRIMARY KEY,
    employee_id INTEGER,
    task_name VARCHAR NOT NULL,
    date_worked DATE NOT NULL,
    hours_worked DECIMAL(4,2) NOT NULL,
    description VARCHAR,
    billable BOOLEAN DEFAULT TRUE,
    tags VARCHAR[]  -- Native array type
);

-- Insert departments
INSERT INTO departments VALUES 
    (1, 'Sales', 'Scranton', 500000.00, 15, '{"notes": "High-performing team", "expansion": true}'),
    (2, 'Accounting', 'Scranton', 300000.00, 5, '{"notes": "Strict budget controls", "expansion": false}'),
    (3, 'Human Resources', 'Scranton', 200000.00, 3, '{"notes": "Focus on employee wellness", "expansion": false}'),
    (4, 'Management', 'Scranton', 400000.00, 2, '{"notes": "Leadership and strategy", "expansion": true}'),
    (5, 'Warehouse', 'Scranton', 150000.00, 10, '{"notes": "Logistics and operations", "expansion": false}'),
    (6, 'IT Support', 'Scranton', 250000.00, 4, '{"notes": "Tech maintenance", "expansion": true}'),
    (7, 'Marketing', 'New York', 350000.00, 6, '{"notes": "Brand and outreach", "expansion": true}');

-- Insert employees with explicit IDs (DuckDB doesn't have AUTO_INCREMENT)
INSERT INTO employees VALUES 
    (1, 'Michael', 'Scott', 'Regional Manager', 'michael.scott@dundermifflin.com', '570-555-0100', '1964-03-15', '2001-02-15', 75000.00, '101', 4, NULL, 'Active', 'Pretzel', 'Improv', 'Sebring', 'That''s what she said!', 'https://linkedin.com/in/michaelscott', ['Leadership', 'Comedy'], 3.5),
    (2, 'Dwight', 'Schrute', 'Assistant to the Regional Manager', 'dwight.schrute@dundermifflin.com', '570-555-0101', '1970-01-20', '2001-03-01', 55000.00, '102', 1, 1, 'Active', 'Beet chips', 'Martial Arts', 'Trans Am', 'Fact.', 'https://linkedin.com/in/dwightschrute', ['Sales', 'Farming'], 4.8),
    (3, 'Jim', 'Halpert', 'Sales Representative', 'jim.halpert@dundermifflin.com', '570-555-0102', '1978-10-01', '2001-06-12', 48000.00, '103', 1, 1, 'Active', 'Jelly beans', 'Pranks', 'Subaru', 'Bears. Beets. Battlestar Galactica.', 'https://linkedin.com/in/jimhalpert', ['Sales', 'Pranks'], 4.7),
    (4, 'Pam', 'Beesly', 'Receptionist', 'pam.beesly@dundermifflin.com', '570-555-0103', '1979-03-25', '2001-07-15', 42000.00, '104', 4, 1, 'Active', 'Yogurt', 'Drawing', 'Toyota', 'How are you not murdered every hour?', 'https://linkedin.com/in/pambeesly', ['Art', 'Reception'], 4.2),
    (5, 'Angela', 'Martin', 'Head of Accounting', 'angela.martin@dundermifflin.com', '570-555-0104', '1971-06-25', '2000-10-10', 60000.00, '201', 2, 1, 'Active', 'Green apple', 'Cats', 'Hyundai', 'I will not be a participant in your prank.', 'https://linkedin.com/in/angelamartin', ['Accounting', 'Cats'], 4.9),
    (6, 'Oscar', 'Martinez', 'Accountant', 'oscar.martinez@dundermifflin.com', '570-555-0105', '1970-02-19', '2001-04-01', 49000.00, '202', 2, 5, 'Active', 'Trail mix', 'Crossword puzzles', 'Honda', 'Actually...', 'https://linkedin.com/in/oscarmartinez', ['Accounting', 'Puzzles'], 4.6),
    (7, 'Kevin', 'Malone', 'Accountant', 'kevin.malone@dundermifflin.com', '570-555-0106', '1970-06-01', '2001-08-20', 47000.00, '203', 2, 5, 'Active', 'Chocolate', 'Drums', 'SUV', 'Why waste time say lot word when few word do trick?', 'https://linkedin.com/in/kevinmalone', ['Accounting', 'Music'], 3.8),
    (8, 'Toby', 'Flenderson', 'HR Representative', 'toby.flenderson@dundermifflin.com', '570-555-0107', '1972-01-15', '2002-01-10', 53000.00, '301', 3, 1, 'Active', 'Granola bar', 'Running', 'Sedan', 'I need to remind you that your salary is not to scale.', 'https://linkedin.com/in/tobyflenderson', ['HR', 'Running'], 4.1),
    (9, 'Darryl', 'Philbin', 'Warehouse Foreman', 'darryl.philbin@dundermifflin.com', '570-555-0108', '1975-06-01', '2002-06-17', 52000.00, '401', 5, 1, 'Active', 'Jerky', 'Music', 'Pickup Truck', 'Hey, dummy!', 'https://linkedin.com/in/darrylphilbin', ['Logistics', 'Music'], 4.4),
    (10, 'Stanley', 'Hudson', 'Sales Representative', 'stanley.hudson@dundermifflin.com', '570-555-0109', '1958-02-19', '2001-09-15', 48500.00, '105', 1, 1, 'Active', 'Pretzel', 'Crosswords', 'Chrysler', 'Did I stutter?', 'https://linkedin.com/in/stanleyhudson', ['Sales', 'Crosswords'], 4.0),
    (11, 'Phyllis', 'Vance', 'Sales Representative', 'phyllis.vance@dundermifflin.com', '570-555-0110', '1955-07-10', '2001-11-01', 48200.00, '106', 1, 1, 'Active', 'Cinnamon roll', 'Knitting', 'Minivan', 'Close your mouth, sweetie.', 'https://linkedin.com/in/phyllisvance', ['Sales', 'Knitting'], 4.3),
    (12, 'Creed', 'Bratton', 'Quality Assurance', 'creed.bratton@dundermifflin.com', '570-555-0111', '1943-11-01', '2001-11-20', 48300.00, '107', 4, 1, 'Active', 'Mung beans', 'Guitar', 'Mystery', 'I run a small fake-ID company from the car.', 'https://linkedin.com/in/creedbratton', ['Quality', 'Music'], 3.2),
    (13, 'Meredith', 'Palmer', 'Supplier Relations', 'meredith.palmer@dundermifflin.com', '570-555-0112', '1960-12-10', '2002-01-22', 42100.00, '108', 4, 1, 'Active', 'Vodka', 'Bowling', 'Minivan', 'I am not ashamed of my job.', 'https://linkedin.com/in/meredithpalmer', ['Relations', 'Bowling'], 3.9),
    (14, 'Kelly', 'Kapoor', 'Customer Service Rep', 'kelly.kapoor@dundermifflin.com', '570-555-0113', '1980-02-05', '2005-04-04', 42000.00, '109', 4, 1, 'Active', 'Cupcakes', 'Shopping', 'Civic', 'Who says exactly what they''re thinking? What kind of game is that?', 'https://linkedin.com/in/kellykapoor', ['Service', 'Shopping'], 4.5),
    (15, 'Ryan', 'Howard', 'Temp', 'ryan.howard@dundermifflin.com', '570-555-0114', '1983-05-05', '2005-04-11', 41000.00, '110', 1, 1, 'Active', 'Energy drink', 'Entrepreneurship', 'Volkswagen', 'I am on a path.', 'https://linkedin.com/in/ryanhoward', ['Temp', 'Entrepreneurship'], 3.7),
    (16, 'Erin', 'Hannon', 'Receptionist', 'erin.hannon@dundermifflin.com', '570-555-0115', '1985-05-20', '2009-09-01', 40000.00, '111', 4, 1, 'Active', 'Candy', 'Volunteering', 'Hatchback', 'I believe you.', 'https://linkedin.com/in/erinhannon', ['Reception', 'Volunteering'], 4.6),
    (17, 'Andy', 'Bernard', 'Sales Representative', 'andy.bernard@dundermifflin.com', '570-555-0116', '1976-03-22', '2005-09-15', 47500.00, '112', 1, 1, 'Active', 'Popcorn', 'A Cappella', 'Sedan', 'Nard Dog!', 'https://linkedin.com/in/andybernard', ['Sales', 'Music'], 4.2),
    (18, 'Gabe', 'Lewis', 'Corporate HR', 'gabe.lewis@dundermifflin.com', '570-555-0117', '1982-11-10', '2012-01-01', 55000.00, '302', 3, 8, 'Active', 'Soda', 'Video Games', 'SUV', 'I am not a security threat.', 'https://linkedin.com/in/gabelewis', ['HR', 'Games'], 3.5);

-- Insert timesheets
INSERT INTO timesheets VALUES 
    (1, 1, 'Team Meeting', '2023-10-01', 2.0, 'Discussed sales targets', TRUE, ['meeting', 'sales']),
    (2, 2, 'Client Call', '2023-10-02', 1.5, 'Follow-up with Dwight Farms', TRUE, ['sales', 'client']),
    (3, 3, 'Prank Planning', '2023-10-03', 0.5, 'Ideas for office fun', FALSE, ['fun', 'team']),
    (4, 5, 'Budget Review', '2023-10-04', 3.0, 'Analyzed quarterly expenses', TRUE, ['accounting', 'budget']);
