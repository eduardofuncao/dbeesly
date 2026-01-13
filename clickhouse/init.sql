-- "The Office" themed sample schema for ClickHouse
-- ClickHouse dialect (OLAP-optimized, converted from SQL Server T-SQL)
-- ClickHouse is an analytical columnar database

USE dundermifflin;

-- Departments table (MergeTree engine for analytics)
CREATE TABLE IF NOT EXISTS dundermifflin.departments (
      id UInt32,
      name String,
      location String,
      budget Decimal128(2),
      head_count UInt32,
      metadata String
  ) ENGINE = MergeTree()
  ORDER BY id;

-- Employees table (denormalized for analytics)
CREATE TABLE IF NOT EXISTS dundermifflin.employees (
      id UInt32,
      first_name String,
      last_name String,
      position String,
      email String,
      phone String,
      date_of_birth Date,
      hire_date Date,
      salary Decimal128(2),
      office_number String,
      department_id UInt32,
      reports_to UInt32,
      status String,
      favorite_snack String,
      hobby String,
      car String,
      favorite_catchphrase String,
      linkedin_profile String,
      skills Array(String),
      performance_rating Decimal128(1)
  ) ENGINE = MergeTree()
  PARTITION BY toYear(hire_date)
  ORDER BY (id, department_id);

-- Timesheets table (optimized for time-series analytics)
CREATE TABLE IF NOT EXISTS dundermifflin.timesheets (
      id UInt32,
      employee_id UInt32,
      task_name String,
      date_worked Date,
      hours_worked Decimal128(2),
      description String,
      billable UInt8,
      tags Array(String)
  ) ENGINE = MergeTree()
  PARTITION BY toYYYYMM(date_worked)
  ORDER BY (id, employee_id, date_worked);


-- Insert departments
INSERT INTO dundermifflin.departments VALUES 
    (1, 'Sales', 'Scranton', toDecimal128(500000.00, 2), 15, '{"notes": "High-performing team", "expansion": true}'),
    (2, 'Accounting', 'Scranton', toDecimal128(300000.00, 2), 5, '{"notes": "Strict budget controls", "expansion": false}'),
    (3, 'Human Resources', 'Scranton', toDecimal128(200000.00, 2), 3, '{"notes": "Focus on employee wellness", "expansion": false}'),
    (4, 'Management', 'Scranton', toDecimal128(400000.00, 2), 2, '{"notes": "Leadership and strategy", "expansion": true}'),
    (5, 'Warehouse', 'Scranton', toDecimal128(150000.00, 2), 10, '{"notes": "Logistics and operations", "expansion": false}'),
    (6, 'IT Support', 'Scranton', toDecimal128(250000.00, 2), 4, '{"notes": "Tech maintenance", "expansion": true}'),
    (7, 'Marketing', 'New York', toDecimal128(350000.00, 2), 6, '{"notes": "Brand and outreach", "expansion": true}');

-- Insert employees (with explicit IDs - no auto-increment)
INSERT INTO dundermifflin.employees VALUES 
    (1, 'Michael', 'Scott', 'Regional Manager', 'michael.scott@dundermifflin.com', '570-555-0100', toDate('1964-03-15'), toDate('2001-02-15'), toDecimal128(75000.00, 2), '101', 4, 0, 'Active', 'Pretzel', 'Improv', 'Sebring', 'That''s what she said!', 'https://linkedin.com/in/michaelscott', ['Leadership', 'Comedy'], toDecimal128(3.5, 1)),
    (2, 'Dwight', 'Schrute', 'Assistant to the Regional Manager', 'dwight.schrute@dundermifflin.com', '570-555-0101', toDate('1970-01-20'), toDate('2001-03-01'), toDecimal128(55000.00, 2), '102', 1, 1, 'Active', 'Beet chips', 'Martial Arts', 'Trans Am', 'Fact.', 'https://linkedin.com/in/dwightschrute', ['Sales', 'Farming'], toDecimal128(4.8, 1)),
    (3, 'Jim', 'Halpert', 'Sales Representative', 'jim.halpert@dundermifflin.com', '570-555-0102', toDate('1978-10-01'), toDate('2001-06-12'), toDecimal128(48000.00, 2), '103', 1, 1, 'Active', 'Jelly beans', 'Pranks', 'Subaru', 'Bears. Beets. Battlestar Galactica.', 'https://linkedin.com/in/jimhalpert', ['Sales', 'Pranks'], toDecimal128(4.7, 1)),
    (4, 'Pam', 'Beesly', 'Receptionist', 'pam.beesly@dundermifflin.com', '570-555-0103', toDate('1979-03-25'), toDate('2001-07-15'), toDecimal128(42000.00, 2), '104', 4, 1, 'Active', 'Yogurt', 'Drawing', 'Toyota', 'How are you not murdered every hour?', 'https://linkedin.com/in/pambeesly', ['Art', 'Reception'], toDecimal128(4.2, 1)),
    (5, 'Angela', 'Martin', 'Head of Accounting', 'angela.martin@dundermifflin.com', '570-555-0104', toDate('1971-06-25'), toDate('2000-10-10'), toDecimal128(60000.00, 2), '201', 2, 1, 'Active', 'Green apple', 'Cats', 'Hyundai', 'I will not be a participant in your prank.', 'https://linkedin.com/in/angelamartin', ['Accounting', 'Cats'], toDecimal128(4.9, 1)),
    (6, 'Oscar', 'Martinez', 'Accountant', 'oscar.martinez@dundermifflin.com', '570-555-0105', toDate('1970-02-19'), toDate('2001-04-01'), toDecimal128(49000.00, 2), '202', 2, 5, 'Active', 'Trail mix', 'Crossword puzzles', 'Honda', 'Actually...', 'https://linkedin.com/in/oscarmartinez', ['Accounting', 'Puzzles'], toDecimal128(4.6, 1)),
    (7, 'Kevin', 'Malone', 'Accountant', 'kevin.malone@dundermifflin.com', '570-555-0106', toDate('1970-06-01'), toDate('2001-08-20'), toDecimal128(47000.00, 2), '203', 2, 5, 'Active', 'Chocolate', 'Drums', 'SUV', 'Why waste time say lot word when few word do trick?', 'https://linkedin.com/in/kevinmalone', ['Accounting', 'Music'], toDecimal128(3.8, 1)),
    (8, 'Toby', 'Flenderson', 'HR Representative', 'toby.flenderson@dundermifflin.com', '570-555-0107', toDate('1972-01-15'), toDate('2002-01-10'), toDecimal128(53000.00, 2), '301', 3, 1, 'Active', 'Granola bar', 'Running', 'Sedan', 'I need to remind you that your salary is not to scale.', 'https://linkedin.com/in/tobyflenderson', ['HR', 'Running'], toDecimal128(4.1, 1)),
    (9, 'Darryl', 'Philbin', 'Warehouse Foreman', 'darryl.philbin@dundermifflin.com', '570-555-0108', toDate('1975-06-01'), toDate('2002-06-17'), toDecimal128(52000.00, 2), '401', 5, 1, 'Active', 'Jerky', 'Music', 'Pickup Truck', 'Hey, dummy!', 'https://linkedin.com/in/darrylphilbin', ['Logistics', 'Music'], toDecimal128(4.4, 1)),
    (10, 'Stanley', 'Hudson', 'Sales Representative', 'stanley.hudson@dundermifflin.com', '570-555-0109', toDate('1958-02-19'), toDate('2001-09-15'), toDecimal128(48500.00, 2), '105', 1, 1, 'Active', 'Pretzel', 'Crosswords', 'Chrysler', 'Did I stutter?', 'https://linkedin.com/in/stanleyhudson', ['Sales', 'Crosswords'], toDecimal128(4.0, 1)),
    (11, 'Phyllis', 'Vance', 'Sales Representative', 'phyllis.vance@dundermifflin.com', '570-555-0110', toDate('1955-07-10'), toDate('2001-11-01'), toDecimal128(48200.00, 2), '106', 1, 1, 'Active', 'Cinnamon roll', 'Knitting', 'Minivan', 'Close your mouth, sweetie.', 'https://linkedin.com/in/phyllisvance', ['Sales', 'Knitting'], toDecimal128(4.3, 1)),
    (12, 'Creed', 'Bratton', 'Quality Assurance', 'creed.bratton@dundermifflin.com', '570-555-0111', toDate('1943-11-01'), toDate('2001-11-20'), toDecimal128(48300.00, 2), '107', 4, 1, 'Active', 'Mung beans', 'Guitar', 'Mystery', 'I run a small fake-ID company from the car.', 'https://linkedin.com/in/creedbratton', ['Quality', 'Music'], toDecimal128(3.2, 1)),
    (13, 'Meredith', 'Palmer', 'Supplier Relations', 'meredith.palmer@dundermifflin.com', '570-555-0112', toDate('1960-12-10'), toDate('2002-01-22'), toDecimal128(42100.00, 2), '108', 4, 1, 'Active', 'Vodka', 'Bowling', 'Minivan', 'I am not ashamed of my job.', 'https://linkedin.com/in/meredithpalmer', ['Relations', 'Bowling'], toDecimal128(3.9, 1)),
    (14, 'Kelly', 'Kapoor', 'Customer Service Rep', 'kelly.kapoor@dundermifflin.com', '570-555-0113', toDate('1980-02-05'), toDate('2005-04-04'), toDecimal128(42000.00, 2), '109', 4, 1, 'Active', 'Cupcakes', 'Shopping', 'Civic', 'Who says exactly what they''re thinking? What kind of game is that?', 'https://linkedin.com/in/kellykapoor', ['Service', 'Shopping'], toDecimal128(4.5, 1)),
    (15, 'Ryan', 'Howard', 'Temp', 'ryan.howard@dundermifflin.com', '570-555-0114', toDate('1983-05-05'), toDate('2005-04-11'), toDecimal128(41000.00, 2), '110', 1, 1, 'Active', 'Energy drink', 'Entrepreneurship', 'Volkswagen', 'I am on a path.', 'https://linkedin.com/in/ryanhoward', ['Temp', 'Entrepreneurship'], toDecimal128(3.7, 1)),
    (16, 'Erin', 'Hannon', 'Receptionist', 'erin.hannon@dundermifflin.com', '570-555-0115', toDate('1985-05-20'), toDate('2009-09-01'), toDecimal128(40000.00, 2), '111', 4, 1, 'Active', 'Candy', 'Volunteering', 'Hatchback', 'I believe you.', 'https://linkedin.com/in/erinhannon', ['Reception', 'Volunteering'], toDecimal128(4.6, 1)),
    (17, 'Andy', 'Bernard', 'Sales Representative', 'andy.bernard@dundermifflin.com', '570-555-0116', toDate('1976-03-22'), toDate('2005-09-15'), toDecimal128(47500.00, 2), '112', 1, 1, 'Active', 'Popcorn', 'A Cappella', 'Sedan', 'Nard Dog!', 'https://linkedin.com/in/andybernard', ['Sales', 'Music'], toDecimal128(4.2, 1)),
    (18, 'Gabe', 'Lewis', 'Corporate HR', 'gabe.lewis@dundermifflin.com', '570-555-0117', toDate('1982-11-10'), toDate('2012-01-01'), toDecimal128(55000.00, 2), '302', 3, 8, 'Active', 'Soda', 'Video Games', 'SUV', 'I am not a security threat.', 'https://linkedin.com/in/gabelewis', ['HR', 'Games'], toDecimal128(3.5, 1));

-- Insert timesheets
INSERT INTO dundermifflin.timesheets VALUES 
    (1, 1, 'Team Meeting', toDate('2023-10-01'), toDecimal128(2.0, 2), 'Discussed sales targets', 1, ['meeting', 'sales']),
    (2, 2, 'Client Call', toDate('2023-10-02'), toDecimal128(1.5, 2), 'Follow-up with Dwight Farms', 1, ['sales', 'client']),
    (3, 3, 'Prank Planning', toDate('2023-10-03'), toDecimal128(0.5, 2), 'Ideas for office fun', 0, ['fun', 'team']),
    (4, 5, 'Budget Review', toDate('2023-10-04'), toDecimal128(3.0, 2), 'Analyzed quarterly expenses', 1, ['accounting', 'budget']);
