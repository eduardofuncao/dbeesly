-- "The Office" themed sample schema for horizontal scroll testing

-- Generators for auto-increment
CREATE GENERATOR gen_departments_id;
CREATE GENERATOR gen_employees_id;
CREATE GENERATOR gen_timesheets_id;

-- Departments table
CREATE TABLE departments (
    id INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL,
    budget DOUBLE PRECISION,
    head_count INTEGER,
    metadata BLOB SUB_TYPE TEXT
);

-- Employees table (many columns for overflow/scroll test)
CREATE TABLE employees (
    id INTEGER PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    job_position VARCHAR(100) NOT NULL,
    phone VARCHAR(30),
    email VARCHAR(100),
    linkedin_profile VARCHAR(200),
    status VARCHAR(20) DEFAULT 'Active',
    salary DOUBLE PRECISION,
    date_of_birth DATE,
    hire_date DATE NOT NULL,
    office_number VARCHAR(10),
    department_id INTEGER,
    reports_to INTEGER,
    favorite_snack VARCHAR(50),
    hobby VARCHAR(50),
    car VARCHAR(50),
    favorite_catchphrase VARCHAR(150),
    skills BLOB SUB_TYPE TEXT,
    performance_rating DOUBLE PRECISION,
    metadata BLOB SUB_TYPE TEXT
);

-- Timesheets table
CREATE TABLE timesheets (
    id INTEGER PRIMARY KEY,
    employee_id INTEGER,
    task_name VARCHAR(100) NOT NULL,
    date_worked DATE NOT NULL,
    hours_worked DOUBLE PRECISION NOT NULL,
    description BLOB SUB_TYPE TEXT,
    billable SMALLINT DEFAULT 1,
    tags BLOB SUB_TYPE TEXT
);

-- Triggers for auto-increment
SET TERM ^^ ;
CREATE TRIGGER tr_departments_bi FOR departments
BEFORE INSERT AS
BEGIN
  IF (NEW.id IS NULL) THEN
    NEW.id = GEN_ID(gen_departments_id, 1);
END^^

CREATE TRIGGER tr_employees_bi FOR employees
BEFORE INSERT AS
BEGIN
  IF (NEW.id IS NULL) THEN
    NEW.id = GEN_ID(gen_employees_id, 1);
END^^

CREATE TRIGGER tr_timesheets_bi FOR timesheets
BEFORE INSERT AS
BEGIN
  IF (NEW.id IS NULL) THEN
    NEW.id = GEN_ID(gen_timesheets_id, 1);
END^^
SET TERM ; ^^

-- Insert departments
INSERT INTO departments (name, location, budget, head_count, metadata) VALUES ('Sales', 'Scranton', 500000.00, 15, 'High-performing team');
INSERT INTO departments (name, location, budget, head_count, metadata) VALUES ('Accounting', 'Scranton', 300000.00, 5, 'Strict budget controls');
INSERT INTO departments (name, location, budget, head_count, metadata) VALUES ('Human Resources', 'Scranton', 200000.00, 3, 'Focus on employee wellness');
INSERT INTO departments (name, location, budget, head_count, metadata) VALUES ('Management', 'Scranton', 400000.00, 2, 'Leadership and strategy');
INSERT INTO departments (name, location, budget, head_count, metadata) VALUES ('Warehouse', 'Scranton', 150000.00, 10, 'Logistics and operations');
INSERT INTO departments (name, location, budget, head_count, metadata) VALUES ('IT Support', 'Scranton', 250000.00, 4, 'Tech maintenance');
INSERT INTO departments (name, location, budget, head_count, metadata) VALUES ('Marketing', 'New York', 350000.00, 6, 'Brand and outreach');

-- Insert employees
INSERT INTO employees (first_name, last_name, job_position, phone, email, linkedin_profile, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, skills, performance_rating, metadata) VALUES ('Michael', 'Scott', 'Regional Manager', '570-555-0100', 'michael.scott@dundermifflin.com', 'https://linkedin.com/in/michaelscott', '1964-03-15', '2001-02-15', 75000.00, '101', 4, NULL, 'Active', 'Pretzel', 'Improv', 'Sebring', 'That''s what she said!', 'Leadership, Comedy', 3.5, 'Best boss. Loves pretzels.');

INSERT INTO employees (first_name, last_name, job_position, phone, email, linkedin_profile, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, skills, performance_rating, metadata) VALUES ('Dwight', 'Schrute', 'Assistant to the Regional Manager', '570-555-0101', 'dwight.schrute@dundermifflin.com', 'https://linkedin.com/in/dwightschrute', '1970-01-20', '2001-03-01', 55000.00, '102', 1, 1, 'Active', 'Beet chips', 'Martial Arts', 'Trans Am', 'Fact.', 'Sales, Farming', 4.8, 'Top salesman. Lives on beet farm.');

INSERT INTO employees (first_name, last_name, job_position, phone, email, linkedin_profile, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, skills, performance_rating, metadata) VALUES ('Jim', 'Halpert', 'Sales Representative', '570-555-0102', 'jim.halpert@dundermifflin.com', 'https://linkedin.com/in/jimhalpert', '1978-10-01', '2001-06-12', 48000.00, '103', 1, 1, 'Active', 'Jelly beans', 'Pranks', 'Subaru', 'Bears. Beets. Battlestar Galactica.', 'Sales, Pranks', 4.7, 'Master of pranks. Often looks into camera.');

INSERT INTO employees (first_name, last_name, job_position, phone, email, linkedin_profile, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, skills, performance_rating, metadata) VALUES ('Pam', 'Beesly', 'Receptionist', '570-555-0103', 'pam.beesly@dundermifflin.com', 'https://linkedin.com/in/pambeesly', '1979-03-25', '2001-07-15', 42000.00, '104', 4, 1, 'Active', 'Yogurt', 'Drawing', 'Toyota', 'How are you not murdered every hour?', 'Art, Reception', 4.2, 'Attended art school. Married Jim.');

INSERT INTO employees (first_name, last_name, job_position, phone, email, linkedin_profile, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, skills, performance_rating, metadata) VALUES ('Angela', 'Martin', 'Head of Accounting', '570-555-0104', 'angela.martin@dundermifflin.com', 'https://linkedin.com/in/angelamartin', '1971-06-25', '2000-10-10', 60000.00, '201', 2, 1, 'Active', 'Green apple', 'Cats', 'Hyundai', 'I will not be a participant in your prank.', 'Accounting, Cats', 4.9, 'Very religious. Loves cats.');

INSERT INTO employees (first_name, last_name, job_position, phone, email, linkedin_profile, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, skills, performance_rating, metadata) VALUES ('Oscar', 'Martinez', 'Accountant', '570-555-0105', 'oscar.martinez@dundermifflin.com', 'https://linkedin.com/in/oscarmartinez', '1970-02-19', '2001-04-01', 49000.00, '202', 2, 5, 'Active', 'Trail mix', 'Crossword puzzles', 'Honda', 'Actually...', 'Accounting, Puzzles', 4.6, 'Very detail-oriented. Voice of reason.');

INSERT INTO employees (first_name, last_name, job_position, phone, email, linkedin_profile, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, skills, performance_rating, metadata) VALUES ('Kevin', 'Malone', 'Accountant', '570-555-0106', 'kevin.malone@dundermifflin.com', 'https://linkedin.com/in/kevinmalone', '1970-06-01', '2001-08-20', 47000.00, '203', 2, 5, 'Active', 'Chocolate', 'Drums', 'SUV', 'Why waste time say lot word when few word do trick?', 'Accounting, Music', 3.8, 'Simple but effective. Loves chili.');

INSERT INTO employees (first_name, last_name, job_position, phone, email, linkedin_profile, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, skills, performance_rating, metadata) VALUES ('Toby', 'Flenderson', 'HR Representative', '570-555-0107', 'toby.flenderson@dundermifflin.com', 'https://linkedin.com/in/tobyflenderson', '1972-01-15', '2002-01-10', 53000.00, '301', 3, 1, 'Active', 'Granola bar', 'Running', 'Sedan', 'I need to remind you that your salary is not to scale.', 'HR, Running', 4.1, 'Divorced. Michael hates him.');

INSERT INTO employees (first_name, last_name, job_position, phone, email, linkedin_profile, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, skills, performance_rating, metadata) VALUES ('Darryl', 'Philbin', 'Warehouse Foreman', '570-555-0108', 'darryl.philbin@dundermifflin.com', 'https://linkedin.com/in/darrylphilbin', '1975-06-01', '2002-06-17', 52000.00, '401', 5, 1, 'Active', 'Jerky', 'Music', 'Pickup Truck', 'Hey, dummy!', 'Logistics, Music', 4.4, 'Has a daughter. Promoted to management.');

INSERT INTO employees (first_name, last_name, job_position, phone, email, linkedin_profile, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, skills, performance_rating, metadata) VALUES ('Stanley', 'Hudson', 'Sales Representative', '570-555-0109', 'stanley.hudson@dundermifflin.com', 'https://linkedin.com/in/stanleyhudson', '1958-02-19', '2001-09-15', 48500.00, '105', 1, 1, 'Active', 'Pretzel', 'Crosswords', 'Chrysler', 'Did I stutter?', 'Sales, Crosswords', 4.0, 'Loves pretzels and crossword puzzles.');

INSERT INTO employees (first_name, last_name, job_position, phone, email, linkedin_profile, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, skills, performance_rating, metadata) VALUES ('Phyllis', 'Vance', 'Sales Representative', '570-555-0110', 'phyllis.vance@dundermifflin.com', 'https://linkedin.com/in/phyllisvance', '1955-07-10', '2001-11-01', 48200.00, '106', 1, 1, 'Active', 'Cinnamon roll', 'Knitting', 'Minivan', 'Close your mouth, sweetie.', 'Sales, Knitting', 4.3, 'Married to Bob Vance. Kind and motherly.');

INSERT INTO employees (first_name, last_name, job_position, phone, email, linkedin_profile, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, skills, performance_rating, metadata) VALUES ('Creed', 'Bratton', 'Quality Assurance', '570-555-0111', 'creed.bratton@dundermifflin.com', 'https://linkedin.com/in/creedbratton', '1943-11-01', '2001-11-20', 48300.00, '107', 4, 1, 'Active', 'Mung beans', 'Guitar', 'Mystery', 'I run a small fake-ID company from the car.', 'Quality, Music', 3.2, 'Former musician. Very mysterious.');

INSERT INTO employees (first_name, last_name, job_position, phone, email, linkedin_profile, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, skills, performance_rating, metadata) VALUES ('Meredith', 'Palmer', 'Supplier Relations', '570-555-0112', 'meredith.palmer@dundermifflin.com', 'https://linkedin.com/in/meredithpalmer', '1960-12-10', '2002-01-22', 42100.00, '108', 4, 1, 'Active', 'Vodka', 'Bowling', 'Minivan', 'I am not ashamed of my job.', 'Relations, Bowling', 3.9, 'Single mother. Enjoys casual Fridays.');

INSERT INTO employees (first_name, last_name, job_position, phone, email, linkedin_profile, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, skills, performance_rating, metadata) VALUES ('Kelly', 'Kapoor', 'Customer Service Rep', '570-555-0113', 'kelly.kapoor@dundermifflin.com', 'https://linkedin.com/in/kellykapoor', '1980-02-05', '2005-04-04', 42000.00, '109', 4, 1, 'Active', 'Cupcakes', 'Shopping', 'Civic', 'Who says exactly what they''re thinking?', 'Service, Shopping', 4.5, 'Obsessed with Ryan. Loves pop culture.');

INSERT INTO employees (first_name, last_name, job_position, phone, email, linkedin_profile, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, skills, performance_rating, metadata) VALUES ('Ryan', 'Howard', 'Temp', '570-555-0114', 'ryan.howard@dundermifflin.com', 'https://linkedin.com/in/ryanhoward', '1983-05-05', '2005-04-11', 41000.00, '110', 1, 1, 'Active', 'Energy drink', 'Entrepreneurship', 'Volkswagen', 'I am on a path.', 'Temp, Entrepreneurship', 3.7, 'Young and ambitious. Not interested in Kelly.');

INSERT INTO employees (first_name, last_name, job_position, phone, email, linkedin_profile, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, skills, performance_rating, metadata) VALUES ('Erin', 'Hannon', 'Receptionist', '570-555-0115', 'erin.hannon@dundermifflin.com', 'https://linkedin.com/in/erinhannon', '1985-05-20', '2009-09-01', 40000.00, '111', 4, 1, 'Active', 'Candy', 'Volunteering', 'Hatchback', 'I believe you.', 'Reception, Volunteering', 4.6, 'Foster child. Very optimistic and friendly.');

INSERT INTO employees (first_name, last_name, job_position, phone, email, linkedin_profile, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, skills, performance_rating, metadata) VALUES ('Andy', 'Bernard', 'Sales Representative', '570-555-0116', 'andy.bernard@dundermifflin.com', 'https://linkedin.com/in/andybernard', '1976-03-22', '2005-09-15', 47500.00, '112', 1, 1, 'Active', 'Popcorn', 'A Cappella', 'Sedan', 'Nard Dog!', 'Sales, Music', 4.2, 'Very proud of Cornell. Loves a cappella.');

INSERT INTO employees (first_name, last_name, job_position, phone, email, linkedin_profile, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, skills, performance_rating, metadata) VALUES ('Gabe', 'Lewis', 'Corporate HR', '570-555-0117', 'gabe.lewis@dundermifflin.com', 'https://linkedin.com/in/gabelewis', '1982-11-10', '2012-01-01', 55000.00, '302', 3, 8, 'Active', 'Soda', 'Video Games', 'SUV', 'I am not a security threat.', 'HR, Games', 3.5, 'Corporate liaison. Socially awkward.');

-- Insert timesheets
INSERT INTO timesheets (employee_id, task_name, date_worked, hours_worked, description, billable, tags) VALUES (1, 'Team Meeting', '2023-10-01', 2.0, 'Discussed sales targets', 1, 'meeting, sales');
INSERT INTO timesheets (employee_id, task_name, date_worked, hours_worked, description, billable, tags) VALUES (2, 'Client Call', '2023-10-02', 1.5, 'Follow-up with Dwight Farms', 1, 'sales, client');
INSERT INTO timesheets (employee_id, task_name, date_worked, hours_worked, description, billable, tags) VALUES (3, 'Prank Planning', '2023-10-03', 0.5, 'Ideas for office fun', 0, 'fun, team');
INSERT INTO timesheets (employee_id, task_name, date_worked, hours_worked, description, billable, tags) VALUES (5, 'Budget Review', '2023-10-04', 3.0, 'Analyzed quarterly expenses', 1, 'accounting, budget');
