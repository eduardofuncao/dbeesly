-- "The Office" themed sample schema for horizontal scroll testing

-- Departments table (added budget as DECIMAL and head_count as INT for varied datatypes)
CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL,
    budget DECIMAL(12,2),  -- New: decimal for financial data
    head_count INT,        -- New: integer for counts
    metadata JSONB         -- New: JSONB for flexible key-value storage
);

-- Employees table (many columns for overflow/scroll test; added skills as TEXT[] and performance_rating as DECIMAL)
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    position VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(30),
    date_of_birth DATE,
    hire_date DATE NOT NULL,
    salary DECIMAL(10,2),  -- Changed from INT to DECIMAL for precision
    office_number VARCHAR(10),
    department_id INT REFERENCES departments(id),
    reports_to INT REFERENCES employees(id),
    status VARCHAR(20),
    favorite_snack VARCHAR(50),
    hobby VARCHAR(50),
    car VARCHAR(50),
    favorite_catchphrase VARCHAR(150),
    linkedin_profile VARCHAR(200),
    skills TEXT[],          -- New: array of strings for skills
    performance_rating DECIMAL(3,1)  -- New: decimal rating (e.g., 4.5)
);

-- Timesheets table (new: tracks time worked on tasks)
CREATE TABLE timesheets (
    id SERIAL PRIMARY KEY,
    employee_id INT REFERENCES employees(id),
    task_name VARCHAR(100) NOT NULL,
    date_worked DATE NOT NULL,
    hours_worked DECIMAL(4,2) NOT NULL,
    description TEXT,
    billable BOOLEAN DEFAULT TRUE,
    tags TEXT[]  -- Array for categorization
);

-- Insert departments (expanded with more entries and new columns)
INSERT INTO departments (name, location, budget, head_count, metadata) VALUES ('Sales', 'Scranton', 500000.00, 15, '{"notes": "High-performing team", "expansion": true}');
INSERT INTO departments (name, location, budget, head_count, metadata) VALUES ('Accounting', 'Scranton', 300000.00, 5, '{"notes": "Strict budget controls", "expansion": false}');
INSERT INTO departments (name, location, budget, head_count, metadata) VALUES ('Human Resources', 'Scranton', 200000.00, 3, '{"notes": "Focus on employee wellness", "expansion": false}');
INSERT INTO departments (name, location, budget, head_count, metadata) VALUES ('Management', 'Scranton', 400000.00, 2, '{"notes": "Leadership and strategy", "expansion": true}');
INSERT INTO departments (name, location, budget, head_count, metadata) VALUES ('Warehouse', 'Scranton', 150000.00, 10, '{"notes": "Logistics and operations", "expansion": false}');
INSERT INTO departments (name, location, budget, head_count, metadata) VALUES ('IT Support', 'Scranton', 250000.00, 4, '{"notes": "Tech maintenance", "expansion": true}');  -- New department
INSERT INTO departments (name, location, budget, head_count, metadata) VALUES ('Marketing', 'New York', 350000.00, 6, '{"notes": "Brand and outreach", "expansion": true}');  -- New department

-- Insert employees (expanded with more entries, varied datatypes, and new columns)
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile, skills, performance_rating) VALUES ('Michael', 'Scott', 'Regional Manager', 'michael.scott@dundermifflin.com', '570-555-0100', '1964-03-15', '2001-02-15', 75000.00, '101', 4, NULL, 'Active', 'Pretzel', 'Improv', 'Sebring', 'That''s what she said!', 'https://linkedin.com/in/michaelscott', ARRAY['Leadership', 'Comedy'], 3.5);
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile, skills, performance_rating) VALUES ('Dwight', 'Schrute', 'Assistant to the Regional Manager', 'dwight.schrute@dundermifflin.com', '570-555-0101', '1970-01-20', '2001-03-01', 55000.00, '102', 1, 1, 'Active', 'Beet chips', 'Martial Arts', 'Trans Am', 'Fact.', 'https://linkedin.com/in/dwightschrute', ARRAY['Sales', 'Farming'], 4.8);
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile, skills, performance_rating) VALUES ('Jim', 'Halpert', 'Sales Representative', 'jim.halpert@dundermifflin.com', '570-555-0102', '1978-10-01', '2001-06-12', 48000.00, '103', 1, 1, 'Active', 'Jelly beans', 'Pranks', 'Subaru', 'Bears. Beets. Battlestar Galactica.', 'https://linkedin.com/in/jimhalpert', ARRAY['Sales', 'Pranks'], 4.7);
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile, skills, performance_rating) VALUES ('Pam', 'Beesly', 'Receptionist', 'pam.beesly@dundermifflin.com', '570-555-0103', '1979-03-25', '2001-07-15', 42000.00, '104', 4, 1, 'Active', 'Yogurt', 'Drawing', 'Toyota', 'How are you not murdered every hour?', 'https://linkedin.com/in/pambeesly', ARRAY['Art', 'Reception'], 4.2);
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile, skills, performance_rating) VALUES ('Angela', 'Martin', 'Head of Accounting', 'angela.martin@dundermifflin.com', '570-555-0104', '1971-06-25', '2000-10-10', 60000.00, '201', 2, 1, 'Active', 'Green apple', 'Cats', 'Hyundai', 'I will not be a participant in your prank.', 'https://linkedin.com/in/angelamartin', ARRAY['Accounting', 'Cats'], 4.9);
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile, skills, performance_rating) VALUES ('Oscar', 'Martinez', 'Accountant', 'oscar.martinez@dundermifflin.com', '570-555-0105', '1970-02-19', '2001-04-01', 49000.00, '202', 2, 5, 'Active', 'Trail mix', 'Crossword puzzles', 'Honda', 'Actually...', 'https://linkedin.com/in/oscarmartinez', ARRAY['Accounting', 'Puzzles'], 4.6);
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile, skills, performance_rating) VALUES ('Kevin', 'Malone', 'Accountant', 'kevin.malone@dundermifflin.com', '570-555-0106', '1970-06-01', '2001-08-20', 47000.00, '203', 2, 5, 'Active', 'Chocolate', 'Drums', 'SUV', 'Why waste time say lot word when few word do trick?', 'https://linkedin.com/in/kevinmalone', ARRAY['Accounting', 'Music'], 3.8);
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile, skills, performance_rating) VALUES ('Toby', 'Flenderson', 'HR Representative', 'toby.flenderson@dundermifflin.com', '570-555-0107', '1972-01-15', '2002-01-10', 53000.00, '301', 3, 1, 'Active', 'Granola bar', 'Running', 'Sedan', 'I need to remind you that your salary is not to scale.', 'https://linkedin.com/in/tobyflenderson', ARRAY['HR', 'Running'], 4.1);
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile, skills, performance_rating) VALUES ('Darryl', 'Philbin', 'Warehouse Foreman', 'darryl.philbin@dundermifflin.com', '570-555-0108', '1975-06-01', '2002-06-17', 52000.00, '401', 5, 1, 'Active', 'Jerky', 'Music', 'Pickup Truck', 'Hey, dummy!', 'https://linkedin.com/in/darrylphilbin', ARRAY['Logistics', 'Music'], 4.4);
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile, skills, performance_rating) VALUES ('Stanley', 'Hudson', 'Sales Representative', 'stanley.hudson@dundermifflin.com', '570-555-0109', '1958-02-19', '2001-09-15', 48500.00, '105', 1, 1, 'Active', 'Pretzel', 'Crosswords', 'Chrysler', 'Did I stutter?', 'https://linkedin.com/in/stanleyhudson', ARRAY['Sales', 'Crosswords'], 4.0);
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile, skills, performance_rating) VALUES ('Phyllis', 'Vance', 'Sales Representative', 'phyllis.vance@dundermifflin.com', '570-555-0110', '1955-07-10', '2001-11-01', 48200.00, '106', 1, 1, 'Active', 'Cinnamon roll', 'Knitting', 'Minivan', 'Close your mouth, sweetie.', 'https://linkedin.com/in/phyllisvance', ARRAY['Sales', 'Knitting'], 4.3);
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile, skills, performance_rating) VALUES ('Creed', 'Bratton', 'Quality Assurance', 'creed.bratton@dundermifflin.com', '570-555-0111', '1943-11-01', '2001-11-20', 48300.00, '107', 4, 1, 'Active', 'Mung beans', 'Guitar', 'Mystery', 'I run a small fake-ID company from the car.', 'https://linkedin.com/in/creedbratton', ARRAY['Quality', 'Music'], 3.2);
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile, skills, performance_rating) VALUES ('Meredith', 'Palmer', 'Supplier Relations', 'meredith.palmer@dundermifflin.com', '570-555-0112', '1960-12-10', '2002-01-22', 42100.00, '108', 4, 1, 'Active', 'Vodka', 'Bowling', 'Minivan', 'I am not ashamed of my job.', 'https://linkedin.com/in/meredithpalmer', ARRAY['Relations', 'Bowling'], 3.9);
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile, skills, performance_rating) VALUES ('Kelly', 'Kapoor', 'Customer Service Rep', 'kelly.kapoor@dundermifflin.com', '570-555-0113', '1980-02-05', '2005-04-04', 42000.00, '109', 4, 1, 'Active', 'Cupcakes', 'Shopping', 'Civic', 'Who says exactly what they''re thinking? What kind of game is that?', 'https://linkedin.com/in/kellykapoor', ARRAY['Service', 'Shopping'], 4.5);
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile, skills, performance_rating) VALUES ('Ryan', 'Howard', 'Temp', 'ryan.howard@dundermifflin.com', '570-555-0114', '1983-05-05', '2005-04-11', 41000.00, '110', 1, 1, 'Active', 'Energy drink', 'Entrepreneurship', 'Volkswagen', 'I am on a path.', 'https://linkedin.com/in/ryanhoward', ARRAY['Temp', 'Entrepreneurship'], 3.7);
-- New employees for more entries
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile, skills, performance_rating) VALUES ('Erin', 'Hannon', 'Receptionist', 'erin.hannon@dundermifflin.com', '570-555-0115', '1985-05-20', '2009-09-01', 40000.00, '111', 4, 1, 'Active', 'Candy', 'Volunteering', 'Hatchback', 'I believe you.', 'https://linkedin.com/in/erinhannon', ARRAY['Reception', 'Volunteering'], 4.6);
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile, skills, performance_rating) VALUES ('Andy', 'Bernard', 'Sales Representative', 'andy.bernard@dundermifflin.com', '570-555-0116', '1976-03-22', '2005-09-15', 47500.00, '112', 1, 1, 'Active', 'Popcorn', 'A Cappella', 'Sedan', 'Nard Dog!', 'https://linkedin.com/in/andybernard', ARRAY['Sales', 'Music'], 4.2);
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile, skills, performance_rating) VALUES ('Gabe', 'Lewis', 'Corporate HR', 'gabe.lewis@dundermifflin.com', '570-555-0117', '1982-11-10', '2012-01-01', 55000.00, '302', 3, 8, 'Active', 'Soda', 'Video Games', 'SUV', 'I am not a security threat.', 'https://linkedin.com/in/gabelewis', ARRAY['HR', 'Games'], 3.5);

-- Insert timesheets (new: sample entries for time tracking)
INSERT INTO timesheets (employee_id, task_name, date_worked, hours_worked, description, billable, tags) VALUES (1, 'Team Meeting', '2023-10-01', 2.0, 'Discussed sales targets', TRUE, ARRAY['meeting', 'sales']);
INSERT INTO timesheets (employee_id, task_name, date_worked, hours_worked, description, billable, tags) VALUES (2, 'Client Call', '2023-10-02', 1.5, 'Follow-up with Dwight Farms', TRUE, ARRAY['sales', 'client']);
INSERT INTO timesheets (employee_id, task_name, date_worked, hours_worked, description, billable, tags) VALUES (3, 'Prank Planning', '2023-10-03', 0.5, 'Ideas for office fun', FALSE, ARRAY['fun', 'team']);
INSERT INTO timesheets (employee_id, task_name, date_worked, hours_worked, description, billable, tags) VALUES (5, 'Budget Review', '2023-10-04', 3.0, 'Analyzed quarterly expenses', TRUE, ARRAY['accounting', 'budget']);
