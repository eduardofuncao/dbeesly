-- "The Office" themed sample schema for horizontal scroll testing

-- Departments table
CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL
);

-- Employees table (many columns for overflow/scroll test)
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    position VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(30),
    date_of_birth DATE,
    hire_date DATE NOT NULL,
    salary INT,
    office_number VARCHAR(10),
    department_id INT REFERENCES departments(id),
    reports_to INT REFERENCES employees(id),
    status VARCHAR(20),
    favorite_snack VARCHAR(50),
    hobby VARCHAR(50),
    car VARCHAR(50),
    favorite_catchphrase VARCHAR(150),
    linkedin_profile VARCHAR(200)
);

-- Projects table
CREATE TABLE projects (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    department_id INT REFERENCES departments(id),
    start_date DATE,
    end_date DATE
);

-- Insert departments
INSERT INTO departments (name, location) VALUES ('Sales', 'Scranton');
INSERT INTO departments (name, location) VALUES ('Accounting', 'Scranton');
INSERT INTO departments (name, location) VALUES ('Human Resources', 'Scranton');
INSERT INTO departments (name, location) VALUES ('Management', 'Scranton');
INSERT INTO departments (name, location) VALUES ('Warehouse', 'Scranton');

-- Insert employees (single line per row)
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile) VALUES ('Michael', 'Scott', 'Regional Manager', 'michael.scott@dundermifflin.com', '570-555-0100', '1964-03-15', '2001-02-15', 75000, '101', 4, NULL, 'Active', 'Pretzel', 'Improv', 'Sebring', 'That''s what she said!', 'https://linkedin.com/in/michaelscott');
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile) VALUES ('Dwight', 'Schrute', 'Assistant to the Regional Manager', 'dwight.schrute@dundermifflin.com', '570-555-0101', '1970-01-20', '2001-03-01', 55000, '102', 1, 1, 'Active', 'Beet chips', 'Martial Arts', 'Trans Am', 'Fact.', 'https://linkedin.com/in/dwightschrute');
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile) VALUES ('Jim', 'Halpert', 'Sales Representative', 'jim.halpert@dundermifflin.com', '570-555-0102', '1978-10-01', '2001-06-12', 48000, '103', 1, 1, 'Active', 'Jelly beans', 'Pranks', 'Subaru', 'Bears. Beets. Battlestar Galactica.', 'https://linkedin.com/in/jimhalpert');
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile) VALUES ('Pam', 'Beesly', 'Receptionist', 'pam.beesly@dundermifflin.com', '570-555-0103', '1979-03-25', '2001-07-15', 42000, '104', 4, 1, 'Active', 'Yogurt', 'Drawing', 'Toyota', 'How are you not murdered every hour?', 'https://linkedin.com/in/pambeesly');
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile) VALUES ('Angela', 'Martin', 'Head of Accounting', 'angela.martin@dundermifflin.com', '570-555-0104', '1971-06-25', '2000-10-10', 60000, '201', 2, 1, 'Active', 'Green apple', 'Cats', 'Hyundai', 'I will not be a participant in your prank.', 'https://linkedin.com/in/angelamartin');
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile) VALUES ('Oscar', 'Martinez', 'Accountant', 'oscar.martinez@dundermifflin.com', '570-555-0105', '1970-02-19', '2001-04-01', 49000, '202', 2, 5, 'Active', 'Trail mix', 'Crossword puzzles', 'Honda', 'Actually...', 'https://linkedin.com/in/oscarmartinez');
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile) VALUES ('Kevin', 'Malone', 'Accountant', 'kevin.malone@dundermifflin.com', '570-555-0106', '1970-06-01', '2001-08-20', 47000, '203', 2, 5, 'Active', 'Chocolate', 'Drums', 'SUV', 'Why waste time say lot word when few word do trick?', 'https://linkedin.com/in/kevinmalone');
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile) VALUES ('Toby', 'Flenderson', 'HR Representative', 'toby.flenderson@dundermifflin.com', '570-555-0107', '1972-01-15', '2002-01-10', 53000, '301', 3, 1, 'Active', 'Granola bar', 'Running', 'Sedan', 'I need to remind you that your salary is not to scale.', 'https://linkedin.com/in/tobyflenderson');
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile) VALUES ('Darryl', 'Philbin', 'Warehouse Foreman', 'darryl.philbin@dundermifflin.com', '570-555-0108', '1975-06-01', '2002-06-17', 52000, '401', 5, 1, 'Active', 'Jerky', 'Music', 'Pickup Truck', 'Hey, dummy!', 'https://linkedin.com/in/darrylphilbin');
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile) VALUES ('Stanley', 'Hudson', 'Sales Representative', 'stanley.hudson@dundermifflin.com', '570-555-0109', '1958-02-19', '2001-09-15', 48500, '105', 1, 1, 'Active', 'Pretzel', 'Crosswords', 'Chrysler', 'Did I stutter?', 'https://linkedin.com/in/stanleyhudson');
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile) VALUES ('Phyllis', 'Vance', 'Sales Representative', 'phyllis.vance@dundermifflin.com', '570-555-0110', '1955-07-10', '2001-11-01', 48200, '106', 1, 1, 'Active', 'Cinnamon roll', 'Knitting', 'Minivan', 'Close your mouth, sweetie.', 'https://linkedin.com/in/phyllisvance');
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile) VALUES ('Creed', 'Bratton', 'Quality Assurance', 'creed.bratton@dundermifflin.com', '570-555-0111', '1943-11-01', '2001-11-20', 48300, '107', 4, 1, 'Active', 'Mung beans', 'Guitar', 'Mystery', 'I run a small fake-ID company from the car.', 'https://linkedin.com/in/creedbratton');
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile) VALUES ('Meredith', 'Palmer', 'Supplier Relations', 'meredith.palmer@dundermifflin.com', '570-555-0112', '1960-12-10', '2002-01-22', 42100, '108', 4, 1, 'Active', 'Vodka', 'Bowling', 'Minivan', 'I am not ashamed of my job.', 'https://linkedin.com/in/meredithpalmer');
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile) VALUES ('Kelly', 'Kapoor', 'Customer Service Rep', 'kelly.kapoor@dundermifflin.com', '570-555-0113', '1980-02-05', '2005-04-04', 42000, '109', 4, 1, 'Active', 'Cupcakes', 'Shopping', 'Civic', 'Who says exactly what they''re thinking? What kind of game is that?', 'https://linkedin.com/in/kellykapoor');
INSERT INTO employees (first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile) VALUES ('Ryan', 'Howard', 'Temp', 'ryan.howard@dundermifflin.com', '570-555-0114', '1983-05-05', '2005-04-11', 41000, '110', 1, 1, 'Active', 'Energy drink', 'Entrepreneurship', 'Volkswagen', 'I am on a path.', 'https://linkedin.com/in/ryanhoward');

-- Insert projects (single line per row)
INSERT INTO projects (name, description, department_id, start_date, end_date) VALUES ('Dunder Mifflin Rebranding', 'Company-wide rebranding initiative led by management.', 4, '2006-01-01', '2006-06-30');
INSERT INTO projects (name, description, department_id, start_date, end_date) VALUES ('Quarterly Sales Drive', 'Boost sales performance for the quarter.', 1, '2007-03-01', '2007-06-30');
INSERT INTO projects (name, description, department_id, start_date, end_date) VALUES ('Office Party Planning', 'Plan the annual company party.', 4, '2007-10-01', '2007-12-15');
INSERT INTO projects (name, description, department_id, start_date, end_date) VALUES ('Annual Budget Review', 'Yearly budget planning and review.', 2, '2007-01-10', '2007-02-28');
INSERT INTO projects (name, description, department_id, start_date, end_date) VALUES ('Diversity Day', 'Diversity training for all staff.', 3, '2005-04-15', '2005-04-15');
