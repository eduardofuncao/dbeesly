-- "The Office" themed sample schema for horizontal scroll testing

-- Custom types
CREATE TYPE employment_status AS ENUM ('Active', 'On Leave', 'Terminated', 'Resigned');
CREATE TYPE salary_range AS RANGE (SUBTYPE = NUMERIC);
CREATE TYPE contact_info AS (
    phone VARCHAR(30),
    email VARCHAR(100),
    linkedin VARCHAR(200)
);
CREATE DOMAIN usd_amount AS NUMERIC(12,2);

-- Departments table (added budget as DECIMAL and head_count as INT for varied datatypes)
CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    "pam's" VARCHAR(100) NOT NULL,  -- Renamed from name
    "database" VARCHAR(100) NOT NULL,  -- Renamed from location
    budget usd_amount,
    head_count INT,        -- New: integer for counts
    metadata JSONB         -- New: JSONB for flexible key-value storage
);

-- Employees table (many columns for overflow/scroll test; added skills as TEXT[] and performance_rating as DECIMAL)
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,  -- Renamed from first_name
    nut VARCHAR(50) NOT NULL,  -- Renamed from last_name (column next to first_name)
    position VARCHAR(100) NOT NULL,
    contact contact_info,
    status employment_status DEFAULT 'Active',
    salary usd_amount,
    salary_grade salary_range,
    date_of_birth DATE,
    hire_date DATE NOT NULL,
    office_number VARCHAR(10),
    department_id INT REFERENCES departments(id),
    reports_to INT REFERENCES employees(id),
    favorite_snack VARCHAR(50),
    hobby VARCHAR(50),
    car VARCHAR(50),
    favorite_catchphrase VARCHAR(150),
    skills TEXT[],          -- New: array of strings for skills
    performance_rating DECIMAL(3,1),  -- New: decimal rating (e.g., 4.5)
    metadata JSON           -- New: JSON for large structured data
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
INSERT INTO departments ("pam's", "database", budget, head_count, metadata) VALUES ('database', '👚', 500000.00, 15, '{"notes": "High-performing team", "expansion": true}');
INSERT INTO departments ("pam's", "database", budget, head_count, metadata) VALUES ('drawer', 'Scranton', 300000.00, 5, '{"notes": "Strict budget controls", "expansion": false}');
INSERT INTO departments ("pam's", "database", budget, head_count, metadata) VALUES ('Human Resources', 'Scranton', 200000.00, 3, '{"notes": "Focus on employee wellness", "expansion": false}');
INSERT INTO departments ("pam's", "database", budget, head_count, metadata) VALUES ('Management', 'Scranton', 400000.00, 2, '{"notes": "Leadership and strategy", "expansion": true}');
INSERT INTO departments ("pam's", "database", budget, head_count, metadata) VALUES ('Warehouse', 'Scranton', 150000.00, 10, '{"notes": "Logistics and operations", "expansion": false}');
INSERT INTO departments ("pam's", "database", budget, head_count, metadata) VALUES ('IT Support', 'Scranton', 250000.00, 4, '{"notes": "Tech maintenance", "expansion": true}');
INSERT INTO departments ("pam's", "database", budget, head_count, metadata) VALUES ('Marketing', 'New York', 350000.00, 6, '{"notes": "Brand and outreach", "expansion": true}');

-- Insert famous squirrels as employees
INSERT INTO employees (name, nut, position, contact, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, salary_grade, favorite_snack, hobby, car, favorite_catchphrase, skills, performance_rating, metadata) VALUES ('Scrat', 'Acorn', 'Ice Age Survivor', ROW('555-000-0001', 'scrat@iceage.com', 'https://linkedin.com/in/scrat')::contact_info, '25000-01-01', '2002-03-15', 0.00, 'ICE1', 1, NULL, 'Active', '[0.00,0.00)', 'Acorn', 'Acorn Hunting', 'None', 'Squeak!', ARRAY['Survival', 'Acorn Obsession'], 5.0, '{"awards": ["Acorn of the Year"], "notes": "Prehistoric squirrel with one mission: get the acorn.", "goals": {"short_term": "Find acorn", "long_term": "Never lose acorn again"}}');
INSERT INTO employees (name, nut, position, contact, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, salary_grade, favorite_snack, hobby, car, favorite_catchphrase, skills, performance_rating, metadata) VALUES ('Michael', 'Scott', 'Regional Manager', ROW('570-555-0100', 'michael.scott@dundermifflin.com', 'https://linkedin.com/in/michaelscott')::contact_info, '1964-03-15', '2001-02-15', 75000.00, '101', 4, NULL, 'Active', '[50000.00,100000.00)', 'Pretzel', 'Improv', 'Sebring', 'That''s what she said!', ARRAY['Leadership', 'Comedy'], 3.5, '{"awards": ["Best Boss (self-proclaimed)", "Dundie Award Winner"], "education": {"degree": "Business", "school": "Unknown"}, "notes": "Owns a condo. Loves''s pretzels. Hosts conference room meetings.", "goals": {"short_term": "Be everyone''s best friend", "long_term": "Start Scott''s Tots franchise"}, "achievements": [{"year": 2005, "title": "Sales Award"}, {"year": 2008, "title": "Leadership Award"}], "preferences": {"meeting_style": "circle", "dress_code": "business casual (often suit)"}, "emergency_contacts": [{"name": "David Wallace", "relation": "Corporate"}, {"name": "Jan Levinson", "relation": "Ex-Girlfriend"}]}');
INSERT INTO employees (name, nut, position, contact, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, salary_grade, favorite_snack, hobby, car, favorite_catchphrase, skills, performance_rating, metadata) VALUES ('Dwight', 'Schrute', 'Assistant to the Regional Manager', ROW('570-555-0101', 'dwight.schrute@dundermifflin.com', 'https://linkedin.com/in/dwightschrute')::contact_info, '1970-01-20', '2001-03-01', 55000.00, '102', 1, 1, 'Active', '[40000.00,60000.00)', 'Beet chips', 'Martial Arts', 'Trans Am', 'Fact.', ARRAY['Sales', 'Farming'], 4.8, '{"awards": ["Top Salesman", "Employee of the Month (multiple times)"], "education": {"degree": "Agriculture", "school": "CCNY"}, "notes": "Lives on a beet farm. Former volunteer sheriff. Owns a Trans Am.", "goals": {"short_term": "Become Regional Manager", "long_term": "Run Schrute Farms"}, "achievements": [{"year": 2006, "title": "Sales Record"}, {"year": 2009, "title": "Hero Award"}], "preferences": {"weapons": ["pepper spray", "numchucks", "throwing stars"], "workspace": "clean desk organized"}, "emergency_contacts": [{"name": "Mose Schrute", "relation": "Cousin"}, {"name": "Angela Martin", "relation": "Fiancée"}], "secrets": ["Surveillance equipment in office"], "skills_detailed": ["German language", "Martial arts (black belt)", "Beet farming"]}');
INSERT INTO employees (name, nut, position, contact, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, salary_grade, favorite_snack, hobby, car, favorite_catchphrase, skills, performance_rating, metadata) VALUES ('Jim', 'Halpert', 'Sales Representative', ROW('570-555-0102', 'jim.halpert@dundermifflin.com', 'https://linkedin.com/in/jimhalpert')::contact_info, '1978-10-01', '2001-06-12', 48000.00, '103', 1, 1, 'Active', '[40000.00,50000.00)', 'Jelly beans', 'Pranks', 'Subaru', 'Bears. Beets. Battlestar Galactica.', ARRAY['Sales', 'Pranks'], 4.7, '{"awards": ["Sales Quarterly Winner", "Best Prankster"], "education": {"degree": "Business", "school": "Unknown University"}, "notes": "Master of the workplace prank. Often looks into camera.", "goals": {"short_term": "Pursue relationship with Pam", "long_term": "Start own business"}, "achievements": [{"year": 2007, "title": "Best Sales Quarter"}, {"year": 2009, "title": "Married Pam"}], "preferences": {"desk_location": "near Dwight", "humor_style": "dry and witty"}, "emergency_contacts": [{"name": "Pam Halpert", "relation": "Wife"}, {"name": "Dwight Schrute", "relation": "Friend/Rival"}], "famous_pranks": ["Dwight''s desk in bathroom", "Gift wrap the stapler", "Identity theft"]}');
INSERT INTO employees (name, nut, position, contact, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, salary_grade, favorite_snack, hobby, car, favorite_catchphrase, skills, performance_rating, metadata) VALUES ('Pam', 'Beesly', 'Receptionist', ROW('570-555-0103', 'pam.beesly@dundermifflin.com', 'https://linkedin.com/in/pambeesly')::contact_info, '1979-03-25', '2001-07-15', 42000.00, '104', 4, 1, 'Active', '[30000.00,45000.00)', 'Yogurt', 'Drawing', 'Toyota', 'How are you not murdered every hour?', ARRAY['Art', 'Reception'], 4.2, '{"awards": ["Dundie Award: World''s Best Receptionist"], "education": {"degree": "Art", "school": "Pratt Institute"}, "notes": "Attended art school. Married Jim. Voice of reason.", "goals": {"short_term": "Become sales rep", "long_term": "Illustrate children''s books"}, "achievements": [{"year": 2008, "title": "Art School Graduate"}, {"year": 2009, "title": "Married Jim"}], "preferences": {"lunch": "yogurt every day", "art_medium": "watercolor"}, "emergency_contacts": [{"name": "Jim Halpert", "relation": "Husband"}, {"name": "Helene Beesly", "relation": "Mother"}], "art_projects": ["Museum installation", "Art school show"], "skills_detailed": ["Reception management", "Artistic illustration"]}');
INSERT INTO employees (name, nut, position, contact, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, salary_grade, favorite_snack, hobby, car, favorite_catchphrase, skills, performance_rating, metadata) VALUES ('Angela', 'Martin', 'Head of Accounting', ROW('570-555-0104', 'angela.martin@dundermifflin.com', 'https://linkedin.com/in/angelamartin')::contact_info, '1971-06-25', '2000-10-10', 60000.00, '201', 2, 1, 'Active', '[55000.00,65000.00)', 'Green apple', 'Cats', 'Hyundai', 'I will not be a participant in your prank.', ARRAY['Accounting', 'Cats'], 4.9, '{"awards": ["Accounting Excellence", "Dundie Award: Most Religious"], "education": {"degree": "Accounting", "school": "Unknown"}, "notes": "Very religious. Loves cats. Strict with rules.", "goals": {"short_term": "Maintain order in accounting", "long_term": "Have a family"}, "achievements": [{"year": 2005, "title": "Employee of the Year"}, {"year": 2010, "title": "Married Senator"}], "preferences": {"cats": "multiple", "baby_shower_traditions": "very important"}, "emergency_contacts": [{"name": "Dwight Schrute", "relation": "Ex-Fiancé"}, {"name": "Robert Lipton", "relation": "Husband"}], "secrets": ["Relationship with Dwight"], "skills_detailed": ["Strict accounting", "Cat care", "Party planning committee"]}');
INSERT INTO employees (name, nut, position, contact, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, salary_grade, favorite_snack, hobby, car, favorite_catchphrase, skills, performance_rating, metadata) VALUES ('Oscar', 'Martinez', 'Accountant', ROW('570-555-0105', 'oscar.martinez@dundermifflin.com', 'https://linkedin.com/in/oscarmartinez')::contact_info, '1970-02-19', '2001-04-01', 49000.00, '202', 2, 5, 'Active', '[45000.00,50000.00)', 'Trail mix', 'Crossword puzzles', 'Honda', 'Actually...', ARRAY['Accounting', 'Puzzles'], 4.6, '{"awards": ["Precision Accounting Award"], "education": {"degree": "Accounting", "school": "Unknown University"}, "notes": "Very detail-oriented. Often corrects Michael. Voice of reason.", "goals": {"short_term": "Maintain accurate ledgers", "long_term": "Senior accounting role"}, "achievements": [{"year": 2008, "title": "Budget Analysis Excellence"}], "preferences": {"communication_style": "precise and detailed"}, "emergency_contacts": [{"name": "Gil", "relation": "Partner"}], "skills_detailed": ["Advanced accounting", "Attention to detail"], "notable_traits": ["Always says Actually..."]}');
INSERT INTO employees (name, nut, position, contact, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, salary_grade, favorite_snack, hobby, car, favorite_catchphrase, skills, performance_rating, metadata) VALUES ('Kevin', 'Malone', 'Accountant', ROW('570-555-0106', 'kevin.malone@dundermifflin.com', 'https://linkedin.com/in/kevinmalone')::contact_info, '1970-06-01', '2001-08-20', 47000.00, '203', 2, 5, 'Active', '[45000.00,50000.00)', 'Chocolate', 'Drums', 'SUV', 'Why waste time say lot word when few word do trick?', ARRAY['Accounting', 'Music'], 3.8, '{"awards": ["Dundie Award: Best Eye Candy"], "education": {"degree": "Accounting", "school": "Unknown"}, "notes": "Simple but effective accountant. Loves chili and ice cream.", "goals": {"short_term": "Make famous chili", "long_term": "Play drums in band"}, "achievements": [{"year": 2006, "title": "Chili Cook-off Winner"}], "preferences": {"food": "chili and ice cream", "hobbies": ["drums", "poker"]}, "emergency_contacts": [{"name": "Stacy", "relation": "Ex-Girlfriend"}], "skills_detailed": ["Basic accounting", "Drumming", "Chili making"], "famous_quotes": ["Cookie Monster", "Why waste time say lot word"]}');
INSERT INTO employees (name, nut, position, contact, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, salary_grade, favorite_snack, hobby, car, favorite_catchphrase, skills, performance_rating, metadata) VALUES ('Toby', 'Flenderson', 'HR Representative', ROW('570-555-0107', 'toby.flenderson@dundermifflin.com', 'https://linkedin.com/in/tobyflenderson')::contact_info, '1972-01-15', '2002-01-10', 53000.00, '301', 3, 1, 'Active', '[50000.00,55000.00)', 'Granola bar', 'Running', 'Sedan', 'I need to remind you that your salary is not to scale.', ARRAY['HR', 'Running'], 4.1, '{"awards": ["HR Professional of the Year"], "education": {"degree": "HR", "school": "Unknown"}, "notes": "Divorced. Has a daughter. Michael hates him.", "goals": {"short_term": "Maintain HR policies", "long_term": "Find happiness"}, "achievements": [{"year": 2005, "title": "HR Policy Implementation"}], "preferences": {"tv_shows": "The Office", "personality": "meek"}, "emergency_contacts": [{"name": "Daughter", "relation": "Child"}], "notable_traits": ["Michael''s nemesis"], "skills_detailed": ["HR management", "Conflict resolution", "Crest whitestrips enthusiast"]}');
INSERT INTO employees (name, nut, position, contact, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, salary_grade, favorite_snack, hobby, car, favorite_catchphrase, skills, performance_rating, metadata) VALUES ('Creed', 'Bratton', 'Quality Assurance', ROW('570-555-0111', 'creed.bratton@dundermifflin.com', 'https://linkedin.com/in/creedbratton')::contact_info, '1943-11-01', '2001-11-20', 48300.00, '107', 4, 1, 'Active', '[45000.00,50000.00)', 'Mung beans', 'Guitar', 'Mystery', 'I run a small fake-ID company from the car.', ARRAY['Quality', 'Music'], 3.2, '{"awards": ["Longest Tenure (unverified)"], "education": {"degree": "Unknown", "school": "Probably none"}, "notes": "Former musician with The Grass Roots. Very mysterious. Forgetful.", "goals": {"short_term": "Remember what job he has", "long_term": "Stay out of jail"}, "achievements": [{"year": 1970, "title": "Rock and Roll Career"}], "preferences": {"lifestyle": "free spirit", "memory": "selective"}, "emergency_contacts": [{"name": "None listed", "relation": "N/A"}], "secrets": ["Fake ID business", "Probably many others"], "skills_detailed": ["Guitar", "Quality assurance (sort of)", "Evading questions"], "notable_quotes": ["I''ve been involved in a number of cults"]}');

-- Insert timesheets
INSERT INTO timesheets (employee_id, task_name, date_worked, hours_worked, description, billable, tags) VALUES (1, 'Team Meeting', '2023-10-01', 2.0, 'Discussed sales targets', TRUE, ARRAY['meeting', 'sales']);
INSERT INTO timesheets (employee_id, task_name, date_worked, hours_worked, description, billable, tags) VALUES (2, 'Client Call', '2023-10-02', 1.5, 'Follow-up with Dwight Farms', TRUE, ARRAY['sales', 'client']);
INSERT INTO timesheets (employee_id, task_name, date_worked, hours_worked, description, billable, tags) VALUES (3, 'Prank Planning', '2023-10-03', 0.5, 'Ideas for office fun', FALSE, ARRAY['fun', 'team']);
INSERT INTO timesheets (employee_id, task_name, date_worked, hours_worked, description, billable, tags) VALUES (5, 'Budget Review', '2023-10-04', 3.0, 'Analyzed quarterly expenses', TRUE, ARRAY['accounting', 'budget']);

-- Customers table (for CEO's board deck request)
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    company VARCHAR(200),
    email VARCHAR(150),
    status VARCHAR(20) DEFAULT 'active',
    created_at DATE DEFAULT CURRENT_DATE
);

-- Invoices table (for revenue tracking)
CREATE TABLE invoices (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id),
    invoice_number VARCHAR(50) NOT NULL UNIQUE,
    invoice_date DATE NOT NULL,
    amount usd_amount NOT NULL,
    status VARCHAR(20) DEFAULT 'paid',
    notes TEXT
);

-- Insert customers
INSERT INTO customers (name, company, email, status) VALUES
    ('David Wallace', 'Dunder Mifflin Corporate', 'david.wallace@dm-corp.com', 'active'),
    ('Jan Levinson', 'Dunder Mifflin Corporate', 'jan.levinson@dm-corp.com', 'active'),
    ('Stanley Hudson', 'Hudson Paper Solutions', 'stanley.h@hudsonpaper.com', 'active'),
    ('Bob Vance', 'Vance Refrigeration', 'bob.vance@vanceref.com', 'active'),
    ('Prince Family Paper', 'Prince Family Paper', 'sales@princepaper.com', 'active');

-- Insert invoices
INSERT INTO invoices (customer_id, invoice_number, invoice_date, amount, status) VALUES
    (1, 'INV-2026-001', '2026-01-29', 45000.00, 'paid'),
    (1, 'INV-2026-015', '2026-02-05', 52800.00, 'paid'),
    (2, 'INV-2026-003', '2026-01-30', 29500.00, 'paid'),
    (3, 'INV-2026-007', '2026-02-02', 35750.00, 'paid'),
    (4, 'INV-2026-008', '2026-02-03', 51500.00, 'paid');

-- =====================================================
-- IMDB MOVIE DATABASE SCHEMA
-- =====================================================

-- Movies table
CREATE TABLE movies (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    year INT NOT NULL,
    genre VARCHAR(100),
    rating DECIMAL(3,1),
    director VARCHAR(255),
    budget_million DECIMAL(10,2),
    box_office_million DECIMAL(10,2),
    runtime_minutes INT,
    plot TEXT,
    awards TEXT
);

-- Actors table
CREATE TABLE actors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    birth_year INT,
    nationality VARCHAR(100),
    famous_role VARCHAR(255)
);

-- Movie actors junction table
CREATE TABLE movie_actors (
    id SERIAL PRIMARY KEY,
    movie_id INT REFERENCES movies(id),
    actor_id INT REFERENCES actors(id),
    role_name VARCHAR(255),
    billing_order INT
);

-- Genres table
CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(100)
);

-- Movie genres junction table
CREATE TABLE movie_genres (
    movie_id INT REFERENCES movies(id),
    genre_id INT REFERENCES genres(id),
    PRIMARY KEY (movie_id, genre_id)
);

-- =====================================================
-- INSERT GENRES
-- =====================================================
INSERT INTO genres (name, category) VALUES ('Action', 'Action');
INSERT INTO genres (name, category) VALUES ('Drama', 'Drama');
INSERT INTO genres (name, category) VALUES ('Comedy', 'Comedy');
INSERT INTO genres (name, category) VALUES ('Thriller', 'Thriller');
INSERT INTO genres (name, category) VALUES ('Sci-Fi', 'Science Fiction');
INSERT INTO genres (name, category) VALUES ('Horror', 'Horror');
INSERT INTO genres (name, category) VALUES ('Romance', 'Romance');
INSERT INTO genres (name, category) VALUES ('Crime', 'Crime');
INSERT INTO genres (name, category) VALUES ('Adventure', 'Adventure');
INSERT INTO genres (name, category) VALUES ('Mystery', 'Mystery');
INSERT INTO genres (name, category) VALUES ('Fantasy', 'Fantasy');
INSERT INTO genres (name, category) VALUES ('Biography', 'Biography');
INSERT INTO genres (name, category) VALUES ('Animation', 'Animation');

-- =====================================================
-- INSERT ACTORS
-- =====================================================
INSERT INTO actors (id, name, birth_year, nationality, famous_role) VALUES
(1, 'Nicolas Cage', 1964, 'American', 'Ben Gates / Castor Troy'),
(2, 'Al Pacino', 1940, 'American', 'Michael Corleone'),
(3, 'Robert De Niro', 1943, 'American', 'Travis Bickle'),
(4, 'Tom Hanks', 1956, 'American', 'Forrest Gump'),
(5, 'Leonardo DiCaprio', 1974, 'American', 'Jack Dawson'),
(6, 'Brad Pitt', 1963, 'American', 'Tyler Durden'),
(7, 'Morgan Freeman', 1937, 'American', 'Red'),
(8, 'Samuel L. Jackson', 1948, 'American', 'Jules Winnfield'),
(9, 'Harrison Ford', 1942, 'American', 'Indiana Jones'),
(10, 'Denzel Washington', 1954, 'American', 'Det. John Hobbes'),
(11, 'Anthony Hopkins', 1937, 'British', 'Hannibal Lecter'),
(12, 'Kevin Spacey', 1959, 'American', 'Verbal Kint'),
(13, 'Edward Norton', 1969, 'American', 'Narrator'),
(14, 'Christian Bale', 1974, 'British', 'Bruce Wayne'),
(15, 'Heath Ledger', 1979, 'Australian', 'Joker'),
(16, 'Gary Oldman', 1958, 'British', 'Sirius Black'),
(17, 'Tim Robbins', 1958, 'American', 'Andy Dufresne'),
(18, 'John Travolta', 1954, 'American', 'Vincent Vega'),
(19, 'Bruce Willis', 1955, 'American', 'John McClane'),
(20, 'Keanu Reeves', 1964, 'Canadian', 'Neo'),
(21, 'Meryl Streep', 1949, 'American', 'Miranda Priestly'),
(22, 'Tom Cruise', 1962, 'American', 'Ethan Hunt'),
(23, 'Johnny Depp', 1963, 'American', 'Jack Sparrow'),
(24, 'Will Smith', 1968, 'American', 'Agent J'),
(25, 'Matt Damon', 1970, 'American', 'Jason Bourne'),
(26, 'Ben Affleck', 1972, 'American', 'Bruce Wayne'),
(27, 'George Clooney', 1961, 'American', 'Danny Ocean'),
(28, 'Julia Roberts', 1967, 'American', 'Erin Brockovich'),
(29, 'Sandra Bullock', 1964, 'American', 'Annie Porter'),
(30, 'Cate Blanchett', 1969, 'Australian', 'Galadriel'),
(31, 'Kate Winslet', 1975, 'British', 'Rose DeWitt Bukater'),
(32, 'Daniel Day-Lewis', 1957, 'British', 'Daniel Plainview'),
(33, 'Philip Seymour Hoffman', 1967, 'American', 'Truman Capote'),
(34, 'Joaquin Phoenix', 1974, 'American', 'Arthur Fleck'),
(35, 'Shia LaBeouf', 1986, 'American', 'Sam Witwicky'),
(36, 'Angelina Jolie', 1975, 'American', 'Lara Croft'),
(37, 'Natalie Portman', 1981, 'Israeli-American', 'Padmé Amidala'),
(38, 'Scarlett Johansson', 1984, 'American', 'Black Widow'),
(39, 'Anne Hathaway', 1982, 'American', 'Catwoman'),
(40, 'Jennifer Lawrence', 1990, 'American', 'Katniss Everdeen'),
(41, 'Emma Stone', 1988, 'American', 'Mia'),
(42, 'Ryan Gosling', 1980, 'Canadian', 'Driver'),
(43, 'Mahershala Ali', 1974, 'American', 'Juan'),
(44, 'Viggo Mortensen', 1958, 'American', 'Aragorn'),
(45, 'Ian McKellen', 1939, 'British', 'Gandalf'),
(46, 'Elijah Wood', 1981, 'American', 'Frodo Baggins'),
(47, 'Sean Astin', 1971, 'American', 'Samwise Gamgee'),
(48, 'Orlando Bloom', 1977, 'British', 'Legolas'),
(49, 'Christopher Lee', 1922, 'British', 'Saruman'),
(50, 'Bong Joon-ho', 1969, 'Korean', 'Director');

-- =====================================================
-- INSERT MOVIES (Top 200 with focus on Nicolas Cage)
-- =====================================================

-- Nicolas Cage movies (~15 films)
INSERT INTO movies (id, title, year, genre, rating, director, budget_million, box_office_million, runtime_minutes, plot, awards) VALUES
(1, 'National Treasure', 2004, 'Action', 6.9, 'Jon Turteltaub', 100.0, 347.5, 131, 'A historian must steal the Declaration of Independence to protect a hidden treasure map. NOT THE BEES! Nicolas Cage hunts for treasure while avoiding the FBI.', 'Nominated for Saturn Award'),
(2, 'Face/Off', 1997, 'Action', 7.3, 'John Woo', 80.0, 245.7, 138, 'An FBI agent undergoes a surgical procedure to take on the physical appearance of a terrorist to infiltrate his organization. Nicolas Cage and John Travolta switch faces in this explosive action thriller.', 'Won Saturn Award for Best Actor'),
(3, 'Con Air', 1997, 'Action', 6.9, 'Simon West', 75.0, 224.0, 115, 'A paroled army ranger becomes the unlikely protector of his fellow prisoners on a dangerous transport flight. Nicolas Cage delivers classic one-liners as Cameron Poe.', 'Nominated for 2 Oscars'),
(4, 'The Rock', 1996, 'Action', 7.4, 'Michael Bay', 75.0, 335.5, 136, 'A mild-mannered FBI chemist and an ex-con must break into Alcatraz to stop a rogue general from launching chemical weapons on San Francisco. Nicolas Cage teams up with Sean Connery in this action classic.', 'Nominated for 1 Oscar'),
(5, 'Leaving Las Vegas', 1995, 'Drama', 7.6, 'Mike Figgis', 4.0, 32.0, 112, 'A suicidal alcoholic moves to Las Vegas to drink himself to death but forms a tender relationship with a prostitute. Nicolas Cage won the Academy Award for Best Actor for this powerful performance.', 'Won Oscar for Best Actor (Cage)'),
(6, 'Adaptation', 2002, 'Drama', 7.7, 'Spike Jonze', 19.0, 32.8, 114, 'A struggling screenwriter adapts a novel about orchids while dealing with his twin brother. Nicolas Cage plays dual roles as Charlie and Donald Kaufman in this meta-narrative masterpiece.', 'Nominated for 4 Oscars including Best Actor'),
(7, 'Raising Arizona', 1987, 'Comedy', 7.6, 'Joel Coen', 6.0, 22.8, 94, 'An ex-con and a police officer decide to steal a baby since they cannot have one of their own. A quirky Coen Brothers comedy featuring Nicolas Cage at his most unhinged.', 'Nominated for Grand Jury Prize at Sundance'),
(8, 'Moonstruck', 1987, 'Romance', 7.5, 'Norman Jewison', 16.0, 95.3, 102, 'A widow falls in love with her fiancé''s hot-tempered brother. Nicolas Cage stars alongside Cher in this beloved romantic comedy that won 3 Oscars.', 'Won 3 Oscars including Best Actress'),
(9, 'Wild at Heart', 1990, 'Drama', 7.3, 'David Lynch', 10.0, 14.5, 125, 'A young couple on the run from mobsters encounters bizarre characters across America. David Lynch''s wild fever dream won the Palme d''Or at Cannes.', 'Won Palme d''Or at Cannes'),
(10, 'Gone in 60 Seconds', 2000, 'Action', 6.5, 'Dominic Sena', 90.0, 237.2, 118, 'A retired master car thief must steal 50 cars in one night to save his brother''s life. Nicolas Cage leads a crew of car thieves in this high-octane thriller.', 'Nominated for 2 Razzie Awards'),
(11, 'Lord of War', 2005, 'Drama', 7.6, 'Andrew Niccol', 42.0, 72.6, 122, 'An arms dealer confronts the morality of his work as he is pursued by an INTERPOL agent. Nicolas Cage delivers a searing critique of the global arms trade. "I sell guns to every army but the Salvation Army."', 'Nominated for Political Film Society Award'),
(12, 'The Wicker Man', 2006, 'Horror', 3.7, 'Neil LaBute', 40.0, 38.8, 102, 'A policeman investigates the disappearance of a young girl on a remote island and discovers a pagan cult. NOT THE BEES! This Nicolas Cage horror film became an internet meme sensation with its over-the-top performance.', 'Won 3 Razzie Awards including Worst Actor'),
(13, 'Vampire''s Kiss', 1988, 'Comedy', 5.0, 'Robert Bierman', 0.5, 0.7, 103, 'A literary agent believes he is turning into a vampire after a mysterious encounter. Nicolas Cage''s insane performance birthed the "You don''t say?" meme. "No, not the bees!"', 'Cult classic status'),
(14, 'Matchstick Men', 2003, 'Drama', 7.3, 'Ridley Scott', 62.0, 65.5, 116, 'A con artist with OCD meets his estranged daughter and must pull off a major heist. Nicolas Cage gives a nuanced performance in this Ridley Scott con drama.', 'Nominated for Saturn Award'),
(15, 'Weather Man', 2005, 'Drama', 6.9, 'Gore Verbinski', 22.0, 19.0, 102, 'A divorced weatherman struggles with his career and family while dealing with random fast food thrown at him. Nicolas Cage stars in this dark comedy about midlife crises.', 'Nominated for Satellite Award'),
(16, '8MM', 1999, 'Thriller', 6.3, 'Joel Schumacher', 40.0, 58.0, 123, 'A private investigator is hired to determine if a snuff film is authentic. Nicolas Cage descends into the underworld of illegal pornography in this dark thriller. "You dance with the devil, the devil doesn''t change. The devil changes you."', 'Nominated for 3 Razzie Awards'),
(17, 'Snake Eyes', 1998, 'Thriller', 6.2, 'Brian De Palma', 73.0, 104.5, 98, 'A detective investigates a boxing match assassination during a hurricane in Atlantic City. Nicolas Cage stars in this Brian De Palma thriller that opens with a 20-minute tracking shot.', 'Nominated for Saturn Award');

-- Top-rated classics and modern masterpieces
INSERT INTO movies (title, year, genre, rating, director, budget_million, box_office_million, runtime_minutes, plot, awards) VALUES
('The Shawshank Redemption', 1994, 'Drama', 9.3, 'Frank Darabont', 25.0, 58.3, 142, 'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency. Based on Stephen King''s novella.', 'Nominated for 7 Oscars'),
('The Godfather', 1972, 'Drama', 9.2, 'Francis Ford Coppola', 6.0, 287.0, 175, 'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son. Al Pacino gives a legendary performance as Michael Corleone.', 'Won 3 Oscars including Best Picture'),
('The Dark Knight', 2008, 'Action', 9.0, 'Christopher Nolan', 185.0, 1006.0, 152, 'When the menace known as the Joker wreaks havoc on Gotham, Batman must accept one of the greatest psychological tests of his ability to fight injustice. Heath Ledger''s Joker is iconic. Nolan masterpiece.', 'Won 2 Oscars including Best Supporting Actor'),
('Pulp Fiction', 1994, 'Drama', 8.9, 'Quentin Tarantino', 8.0, 213.9, 154, 'The lives of two mob hitmen, a boxer, a gangster and his wife intertwine in four tales of violence and redemption. Quentin Tarantino''s non-linear narrative revolutionized cinema. Oscar winner for Original Screenplay.', 'Won 1 Oscar for Best Original Screenplay'),
('Forrest Gump', 1994, 'Drama', 8.8, 'Robert Zemeckis', 55.0, 678.2, 142, 'The presidencies of Kennedy and Johnson through the eyes of an Alabama man with an IQ of 75. Tom Hanks won the Oscar for his iconic performance. "Life is like a box of chocolates."', 'Won 6 Oscars including Best Picture and Best Actor'),
('Inception', 2010, 'Sci-Fi', 8.8, 'Christopher Nolan', 160.0, 836.8, 148, 'A thief who steals corporate secrets through dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O. Christopher Nolan''s mind-bending heist film. "Is it real or a dream?"', 'Won 4 Oscars including Best Cinematography'),
('The Matrix', 1999, 'Sci-Fi', 8.7, 'The Wachowskis', 63.0, 466.6, 136, 'A computer hacker learns about the true nature of reality and his role in the war against its controllers. Keanu Reeves discovers the Matrix in this revolutionary sci-fi action film that won 4 Oscars.', 'Won 4 Oscars'),
('Goodfellas', 1990, 'Crime', 8.7, 'Martin Scorsese', 25.0, 46.8, 146, 'The story of Henry Hill and his life in the mob, covering his relationship with his wife Karen Hill and his mob partners Jimmy Conway and Tommy DeVito. Martin Scorsese''s mob epic. Ray Liotta, Robert De Niro, Joe Pesci.', 'Nominated for 6 Oscars including Best Director'),
('The Silence of the Lambs', 1991, 'Thriller', 8.6, 'Jonathan Demme', 19.0, 272.7, 118, 'A young F.B.I. cadet must receive the help of an incarcerated cannibalistic serial killer to catch another killer. Anthony Hopkins and Jodie Foster won Oscars for their iconic roles as Hannibal Lecter and Clarice Starling. "Quid pro quo."', 'Won 5 Oscars including Best Picture'),
('Saving Private Ryan', 1998, 'Drama', 8.6, 'Steven Spielberg', 70.0, 485.0, 169, 'Following the Normandy Landings, a group of U.S. soldiers go behind enemy lines to retrieve a paratrooper whose brothers have been killed in action. Steven Spielberg''s WWII epic features a harrowing 27-minute D-Day opening sequence.', 'Won 5 Oscars including Best Director'),
('Schindler''s List', 1993, 'Drama', 8.9, 'Steven Spielberg', 22.0, 322.2, 195, 'In German-occupied Poland during World War II, industrialist Oskar Schindler gradually becomes concerned for his Jewish workforce after witnessing their persecution by the Nazis. Steven Spielberg''s masterpiece won 7 Oscars.', 'Won 7 Oscars including Best Picture'),
('The Lord of the Rings: The Return of the King', 2003, 'Fantasy', 9.0, 'Peter Jackson', 94.0, 1142.7, 201, 'Gandalf and Aragorn lead the World of Men against Sauron''s army to draw his gaze from Frodo and Sam as they approach Mount Doom with the One Ring. The epic conclusion to Peter Jackson''s trilogy won 11 Oscars, a record tied only by Ben-Hur and Titanic.', 'Won 11 Oscars including Best Picture'),
('Fight Club', 1999, 'Drama', 8.8, 'David Fincher', 63.0, 101.2, 139, 'An insomniac office worker and a soap salesman build a global organization to help vent male aggression. Brad Pitt and Edward Norton star in David Fincher''s cult classic that explores consumerism and masculinity. "The first rule of Fight Club is: you do not talk about Fight Club."', 'Nominated for 1 Oscar'),
('Interstellar', 2014, 'Sci-Fi', 8.6, 'Christopher Nolan', 165.0, 701.7, 169, 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity''s survival. Christopher Nolan''s cosmic epic features stunning visuals and Hans Zimmer''s iconic score. Matthew McConaughey leads an all-star cast in this emotional journey through space and time.', 'Won 1 Oscar for Best Visual Effects'),
('The Green Mile', 1999, 'Drama', 8.6, 'Frank Darabont', 45.0, 286.8, 189, 'The lives of guards on death row are affected by one of their charges: a black man accused of child murder and rape, yet who has a mysterious gift. Tom Hanks and Michael Clarke Duncan star in this Stephen King adaptation. "I''m sorry for what I am."', 'Nominated for 4 Oscars'),
('The Prestige', 2006, 'Drama', 8.5, 'Christopher Nolan', 40.0, 109.7, 130, 'Two rival magicians engage in a competitive battle of one-upmanship with deadly consequences. Christian Bale and Hugh Jackman star in Christopher Nolan''s twisty thriller about obsession and sacrifice. "Are you watching closely?"', 'Nominated for 2 Oscars'),
('The Usual Suspects', 1995, 'Drama', 8.5, 'Bryan Singer', 6.0, 23.3, 106, 'A sole survivor tells of the twisty events leading up to a horrific gun battle on a boat, which began when five criminals met at a seemingly random police lineup. Kevin Spacey won an Oscar for his role as Verbal Kint in this twist-filled neo-noir. "The greatest trick the Devil ever pulled was convincing the world he didn''t exist."', 'Won 2 Oscars including Best Supporting Actor'),
('Se7en', 1995, 'Drama', 8.6, 'David Fincher', 30.0, 327.5, 127, 'Two detectives hunt a serial killer who uses the seven deadly sins as his motives. Brad Pitt and Morgan Freeman star in David Fincher''s dark thriller with one of cinema''s most shocking endings. "What''s in the box?"', 'Nominated for 1 Oscar'),
('Léon: The Professional', 1994, 'Drama', 8.5, 'Luc Besson', 16.0, 45.3, 110, 'Mathilda, a 12-year-old girl, is reluctantly taken in by Léon, a professional assassin, after her family is murdered. An unusual relationship forms as she becomes his protégée and learns the assassin''s trade. Natalie Portman made her debut in this Luc Besson classic.', 'Nominated for 7 César Awards'),
('City of God', 2002, 'Drama', 8.6, 'Fernando Meirelles', 3.3, 30.5, 130, 'Two boys growing up in a violent neighborhood of Rio de Janeiro take different paths: one becomes a photographer, the other a drug dealer. This Brazilian crime drama earned 4 Oscar nominations. Directed by Fernando Meirelles and Kátia Lund.', 'Nominated for 4 Oscars'),
('Gladiator', 2000, 'Action', 8.5, 'Ridley Scott', 103.0, 460.5, 155, 'A former Roman General sets out to exact vengeance against the corrupt emperor who murdered his family and sent him into slavery. Russell Crowe won the Oscar for his powerful performance as Maximus in Ridley Scott''s epic. "Are you not entertained?"', 'Won 5 Oscars including Best Picture and Best Actor'),
('Whiplash', 2014, 'Drama', 8.5, 'Damien Chazelle', 3.3, 49.0, 106, 'A promising young drummer enrolls at a cut-throat music conservatory where his dreams of greatness are shepherded by an instructor who will stop at nothing to realize a student''s potential. J.K. Simmons won the Oscar for his terrifying performance as Fletcher. "Not quite my tempo."', 'Won 3 Oscars including Best Supporting Actor'),
('The Departed', 2006, 'Drama', 8.5, 'Martin Scorsese', 90.0, 291.5, 151, 'An undercover cop and a mole in the police attempt to identify each other while infiltrating an Irish gang in South Boston. Leonardo DiCaprio and Matt Damon star in Martin Scorsese''s Oscar-winning crime thriller, a remake of Infernal Affairs.', 'Won 4 Oscars including Best Picture and Best Director'),
('The Pianist', 2002, 'Drama', 8.5, 'Roman Polanski', 35.0, 120.1, 150, 'A Polish Jewish musician struggles to survive the destruction of the Warsaw ghetto of World War II. Adrien Brody won the Oscar for his powerful performance as Władysław Szpilman in Roman Polanski''s Holocaust drama.', 'Won 3 Oscars including Best Actor and Best Director'),
('Parasite', 2019, 'Drama', 8.5, 'Bong Joon-ho', 11.4, 263.1, 132, 'Greed and class discrimination threaten the newly formed symbiotic relationship between the wealthy Park family and the destitute Kim clan. Bong Joon-ho''s Korean masterpiece made history as the first non-English film to win Best Picture. "It''s so metaphorical."', 'Won 4 Oscars including Best Picture, Best Director, and Best Original Screenplay'),
('American Beauty', 1999, 'Drama', 8.3, 'Sam Mendes', 15.0, 356.3, 122, 'A sexually frustrated suburban father has a mid-life crisis after becoming infatuated with his daughter''s best friend. Kevin Spacey won the Oscar for his role as Lester Burnham in Sam Mendes'' dark suburban satire. "Look closer."', 'Won 5 Oscars including Best Picture'),
('A Beautiful Mind', 2001, 'Drama', 8.2, 'Ron Howard', 58.0, 313.5, 135, 'After John Nash, a brilliant but asocial mathematician, accepts secret work in cryptography, his life takes a turn for the nightmarish. Russell Crowe stars in Ron Howard''s biopic that won 4 Oscars including Best Picture.', 'Won 4 Oscars including Best Picture'),
('No Country for Old Men', 2007, 'Drama', 8.1, 'Joel Coen', 25.0, 171.6, 122, 'Violence and mayhem ensue after a hunter stumbles upon a drug deal gone wrong and more than two million dollars in cash near the Rio Grande. Javier Bardem won the Oscar for his chilling role as Anton Chigurh in the Coen Brothers'' masterpiece.', 'Won 4 Oscars including Best Picture'),
('There Will Be Blood', 2007, 'Drama', 8.1, 'Paul Thomas Anderson', 25.0, 76.2, 158, 'A story of family, religion, hatred, oil and madness, focusing on a turn-of-the-century prospector in the early days of the business. Daniel Day-Lewis won the Oscar for his legendary performance as Daniel Plainview in Paul Thomas Anderson''s epic. "I drink your milkshake!"', 'Won 2 Oscars including Best Actor'),
('Slumdog Millionaire', 2008, 'Drama', 8.0, 'Danny Boyle', 15.0, 377.9, 120, 'A Mumbai teen reflects on his life after being accused of cheating on the Indian version of "Who Wants to Be a Millionaire?". Danny Boyle''s rags-to-riches tale won 8 Oscars including Best Picture.', 'Won 8 Oscars including Best Picture'),
('The Lord of the Rings: The Fellowship of the Ring', 2001, 'Fantasy', 8.8, 'Peter Jackson', 93.0, 898.2, 178, 'A meek Hobbit from the Shire and eight companions set out on a journey to destroy the powerful One Ring and save Middle-earth from the Dark Lord Sauron. Peter Jackson''s first installment of the beloved trilogy earned 13 Oscar nominations and won 4.', 'Won 4 Oscars'),
('The Lord of the Rings: The Two Towers', 2002, 'Fantasy', 8.7, 'Peter Jackson', 94.0, 942.7, 179, 'While Frodo and Sam edge closer to Mordor with the help of the shifty Gollum, the divided fellowship makes a stand against Sauron''s new ally, Saruman, and his hordes of Isengard. The middle chapter of Peter Jackson''s epic trilogy features the Battle of Helm''s Deep.', 'Won 2 Oscars'),
('Casino Royale', 2006, 'Action', 7.9, 'Martin Campbell', 150.0, 606.1, 144, 'James Bond''s first mission as 007 leads him to Le Chiffre, a banker to the world''s terrorists. Daniel Craig debuted as Bond in this gritty reboot that revitalized the franchise. "The name''s Bond. James Bond."', 'Nominated for 1 Oscar'),
('Amadeus', 1984, 'Drama', 8.3, 'Milos Forman', 18.0, 52.0, 160, 'The incredible story of Wolfgang Amadeus Mozart, told in flashback by his peer and secret rival, Antonio Salieri. F. Murray Abraham won the Oscar for his portrayal of the envious court composer in Milos Forman''s lavish biopic.', 'Won 8 Oscars including Best Picture'),
('Fargo', 1996, 'Drama', 8.1, 'Joel Coen', 7.0, 60.6, 98, 'A clumsy car salesman''s inept plan to have his wife kidnapped for ransom goes horribly wrong when two criminals are hired. The Coen Brothers'' Minnesota crime noir earned 7 Oscar nominations and won 2 including Frances McDormand for Best Actress.', 'Won 2 Oscars including Best Actress'),
('Memento', 2000, 'Drama', 8.4, 'Christopher Nolan', 9.0, 39.7, 113, 'A man with short-term memory loss attempts to track down his wife''s murderer using notes and tattoos. Christopher Nolan''s breakout thriller told in reverse order revolutionized nonlinear storytelling. "Don''t believe his lies."', 'Nominated for 2 Oscars'),
('Apocalypse Now', 1979, 'Drama', 8.4, 'Francis Ford Coppola', 31.5, 104.9, 147, 'During the Vietnam War, Captain Willard is sent on a dangerous mission into Cambodia to assassinate Colonel Kurtz, a renegade Green Beret who has set himself up as a god among a local tribe. Francis Ford Coppola''s Vietnam epic, famously troubled production, won 2 Oscars.', 'Won 2 Oscars'),
('Alien', 1979, 'Sci-Fi', 8.5, 'Ridley Scott', 11.0, 104.9, 117, 'After investigating a mysterious transmission of unknown origin, the crew of a commercial spacecraft encounters a deadly lifeform. Ridley Scott''s sci-fi horror classic introduced Sigourney Weaver as Ripley and won 1 Oscar for Visual Effects. "In space no one can hear you scream."', 'Won 1 Oscar'),
('Die Hard', 1988, 'Action', 8.2, 'John McTiernan', 28.0, 140.8, 132, 'A New York City police officer tries to save his wife and several others taken hostage by terrorists during a Christmas party at the Nakatomi Plaza in Los Angeles. Bruce Willis became an action icon as John McClane in this quintessential action thriller. "Yippee-ki-yay, motherfucker!"', 'Nominated for 4 Oscars'),
('Terminator 2: Judgment Day', 1991, 'Sci-Fi', 8.5, 'James Cameron', 102.0, 520.9, 137, 'A cyborg is sent from the future on a deadly mission. He has to kill Sarah Connor''s son to prevent the future resistance. James Cameron''s sequel revolutionized visual effects and won 4 Oscars. "I''ll be back." "Hasta la vista, baby."', 'Won 4 Oscars including Best Visual Effects'),
('Jaws', 1975, 'Drama', 8.4, 'Steven Spielberg', 12.0, 476.5, 124, 'A giant great white shark arrives on the shores of a New England beach resort and wreaks havoc with bloody attacks on swimmers until the local police chief takes action. Steven Spielberg''s blockbuster pioneered the summer event film and won 3 Oscars including Best Original Score.', 'Won 3 Oscars including Best Original Score'),
('Star Wars: Episode IV - A New Hope', 1977, 'Sci-Fi', 8.6, 'George Lucas', 11.0, 775.4, 121, 'Luke Skywalker joins forces with a Jedi Knight, a cocky pilot, a Wookiee and two droids to save the galaxy from the Death Star. George Lucas'' space opera revolutionized special effects and launched a cultural phenomenon that won 7 Oscars.', 'Won 7 Oscars including Best Original Score'),
('Raiders of the Lost Ark', 1981, 'Action', 8.4, 'Steven Spielberg', 20.0, 389.9, 115, 'Archaeologist Indiana Jones races the Nazis to find the legendary Ark of the Covenant before they can use it for world domination. Harrison Ford became an icon as the whip-cracking adventurer in Steven Spielberg and George Lucas'' adventure classic that won 5 Oscars.', 'Won 5 Oscars including Best Art Direction'),
('Back to the Future', 1985, 'Sci-Fi', 8.5, 'Robert Zemeckis', 19.0, 389.1, 116, 'Marty McFly, a teenager from 1985, accidentally sends himself thirty years into the past in a time-traveling DeLorean invented by his eccentric scientist friend. Michael J. Fox became a star in Robert Zemeckis'' beloved sci-fi comedy that won 1 Oscar. "Great Scott!"', 'Won 1 Oscar'),
('The Lion King', 1994, 'Animation', 8.5, 'Roger Allers, Rob Minkoff', 45.0, 987.5, 88, 'Lion prince Simba and his father are targeted by his bitter uncle, who wants to ascend the throne himself. Disney''s animated classic features an all-star voice cast and Elton John''s iconic songs. Won 2 Oscars including Best Original Score and Best Original Song for "Can You Feel the Love Tonight".', 'Won 2 Oscars including Best Original Score'),
('Spirited Away', 2001, 'Animation', 8.6, 'Hayao Miyazaki', 19.0, 395.8, 125, 'During her family''s move to the suburbs, a sullen 10-year-old girl wanders into a world ruled by gods, witches, and spirits, where humans are changed into beasts. Hayao Miyazaki''s masterpiece won the Oscar for Best Animated Feature, the only hand-drawn non-English language film to win.', 'Won 1 Oscar for Best Animated Feature'),
('Amélie', 2001, 'Comedy', 8.3, 'Jean-Pierre Jeunet', 10.0, 173.2, 122, 'Amélie is an innocent and naive girl in Paris with her own sense of justice. She decides to help those around her and, along the way, discovers love. Audrey Tautou became an international star in Jean-Pierre Jeunet''s whimsical romantic comedy that earned 5 Oscar nominations.', 'Nominated for 5 Oscars'),
('The Grand Budapest Hotel', 2014, 'Drama', 8.1, 'Wes Anderson', 25.0, 174.6, 99, 'A writer encounters the owner of an aging high-class hotel, who tells him of his early years serving as a lobby boy in the hotel''s glorious years under an exceptional concierge. Wes Anderson''s whimsical caper earned 9 Oscar nominations and won 4. "Rufus!"', 'Won 4 Oscars including Best Score'),
('La La Land', 2016, 'Drama', 8.0, 'Damien Chazelle', 30.0, 446.4, 128, 'While navigating their careers in Los Angeles, a pianist and an actress fall in love while attempting to reconcile their aspirations for the future. Damien Chazelle''s musical love letter to L.A. won 6 Oscars including Best Director for Chazelle. "Here''s to the ones who dream."', 'Won 6 Oscars including Best Director'),
('Get Out', 2017, 'Drama', 7.7, 'Jordan Peele', 4.5, 255.9, 104, 'A young African-American visits his white girlfriend''s parents for the weekend, where his simmering uneasiness about their reception of him eventually reaches a boiling point. Jordan Peele''s directorial debut revolutionized horror and won the Oscar for Best Original Screenplay.', 'Won 1 Oscar for Best Original Screenplay'),
('Black Panther', 2018, 'Action', 7.3, 'Ryan Coogler', 200.0, 1346.9, 134, 'T''Challa, heir to the hidden but advanced kingdom of Wakanda, must step forward to lead his people into a new future and must confront a challenger from his country''s past. Ryan Coogler''s Marvel superhero film became a cultural phenomenon and the first superhero film nominated for Best Picture. Won 3 Oscars.', 'Won 3 Oscars including Best Original Score'),
('Mad Max: Fury Road', 2015, 'Action', 8.1, 'George Miller', 150.0, 378.9, 120, 'In a post-apocalyptic wasteland, a woman rebels against a tyrannical ruler in search for her homeland with the aid of a group of female prisoners, a psychotic worshiper, and a drifter named Max. George Miller''s high-octane sequel won 6 Oscars and is considered one of the greatest action films ever made.', 'Won 6 Oscars including Best Film Editing'),
('Spotlight', 2015, 'Drama', 8.1, 'Tom McCarthy', 20.0, 98.0, 128, 'The true story of how the Boston Globe uncovered the massive scandal of child molestation and cover-up within the local Catholic Archdiocese. This journalistic drama won 2 Oscars including Best Picture for its powerful portrayal of investigative journalism.', 'Won 2 Oscars including Best Picture'),
('12 Years a Slave', 2013, 'Drama', 8.1, 'Steve McQueen', 20.0, 178.4, 134, 'In the antebellum United States, Solomon Northup, a free black man from upstate New York, is abducted and sold into slavery. Steve McQueen''s harrowing historical drama won 3 Oscars including Best Picture and Best Supporting Actress for Lupita Nyong''o.', 'Won 3 Oscars including Best Picture'),
('The Shape of Water', 2017, 'Drama', 7.3, 'Guillermo del Toro', 19.5, 195.2, 123, 'At a top secret research facility in the 1960s, a lonely janitor forms a unique relationship with an amphibious creature that is being held in captivity. Guillermo del Toro''s romantic fantasy won 4 Oscars including Best Picture and Best Director.', 'Won 4 Oscars including Best Picture and Best Director'),
('Green Book', 2018, 'Drama', 8.2, 'Peter Farrelly', 23.0, 321.8, 130, 'A working-class Italian-American bouncer becomes the driver of an African-American classical pianist on a tour of venues through the 1960s American South. This road trip dramedy about race relations won 3 Oscars including Best Picture. "So if I''m not black enough, and if I''m not white enough, then what am I?"', 'Won 3 Oscars including Best Picture'),
('Once Upon a Time... in Hollywood', 2019, 'Drama', 7.6, 'Quentin Tarantino', 90.0, 374.4, 161, 'A faded television actor and his stunt double strive to achieve fame and success in the film industry during the final years of Hollywood''s Golden Age in 1969 Los Angeles. Quentin Tarantino''s love letter to 1960s Hollywood won 2 Oscars including Best Supporting Actor for Brad Pitt.', 'Won 2 Oscars including Best Supporting Actor'),
('1917', 2019, 'Drama', 8.2, 'Sam Mendes', 90.0, 384.9, 119, 'April 6th, 1917. As a regiment assembles to wage war deep in enemy territory, two soldiers are assigned to race against time and deliver a message that will save 1,600 lives. Sam Mendes'' World War I epic was filmed to appear as one continuous shot and won 3 Oscars including Best Cinematography.', 'Won 3 Oscars including Best Cinematography'),
('Joker', 2019, 'Drama', 8.4, 'Todd Phillips', 55.0, 1074.4, 122, 'In Gotham City, mentally troubled comedian Arthur Fleck is disregarded and mistreated by society. He then embarks on a downward spiral of revolution and bloody crime. Joaquin Phoenix won the Oscar for his transformative performance as the Clown Prince of Crime in Todd Phillips'' dark character study. "Put on a happy face."', 'Won 1 Oscar for Best Actor'),
('Knives Out', 2019, 'Drama', 7.9, 'Rian Johnson', 40.0, 311.9, 130, 'A detective investigates the death of a patriarch of an eccentric, combative family. Rian Johnson''s modern take on the whodunit earned 1 Oscar nomination and revitalized the mystery genre with its all-star cast led by Daniel Craig as Benoit Blanc. "I suspect foul play."', 'Nominated for 1 Oscar'),
('Dune', 2021, 'Sci-Fi', 8.0, 'Denis Villeneuve', 165.0, 401.8, 155, 'A noble family becomes embroiled in a war for control over the galaxy''s most valuable asset while its heir becomes troubled by visions of a dark future. Denis Villeneuve''s ambitious adaptation of Frank Herbert''s sci-fi epic won 6 Oscars including Best Original Score. "I must not fear. Fear is the mind-killer."', 'Won 6 Oscars including Best Original Score'),
('Top Gun: Maverick', 2022, 'Action', 8.2, 'Joseph Kosinski', 170.0, 1488.7, 131, 'After thirty years, Maverick is still pushing the envelope as a top naval aviator, but must confront ghosts of his past when he leads TOP GUN''s elite graduates on a mission that demands the ultimate sacrifice. The long-awaited sequel became a cultural phenomenon and earned 6 Oscar nominations including Best Picture. "I feel the need... the need for speed."', 'Nominated for 6 Oscars including Best Picture'),
('Everything Everywhere All at Once', 2022, 'Sci-Fi', 7.8, 'Daniel Kwan, Daniel Scheinert', 25.0, 103.3, 139, 'A middle-aged Chinese immigrant is swept up in an insane adventure where she alone can save existence by exploring other universes and connecting with the lives she could have led. The Daniels'' absurdist multiverse masterpiece won 7 Oscars including Best Picture. "In another life, I would have really liked just doing laundry and taxes with you."', 'Won 7 Oscars including Best Picture, Best Director, Best Actress, and Best Supporting Actor'),
('Oppenheimer', 2023, 'Drama', 8.4, 'Christopher Nolan', 100.0, 960.7, 180, 'The story of American scientist J. Robert Oppenheimer and his role in the development of the atomic bomb during World War II. Christopher Nolan''s biopic became a cultural phenomenon and won 7 Oscars including Best Picture, Best Director for Nolan, and Best Actor for Cillian Murphy. "Now I am become Death, the destroyer of worlds."', 'Won 7 Oscars including Best Picture, Best Director, and Best Actor'),
('Barbie', 2023, 'Drama', 6.9, 'Greta Gerwig', 145.0, 1441.8, 114, 'Barbie and Ken are having the time of their lives in the colorful and seemingly perfect world of Barbie Land. However, when they get a chance to go to the real world, they soon discover the joys and perils of living among humans. Greta Gerwig''s candy-colored satire became a global phenomenon and earned 8 Oscar nominations including Best Picture. "Hi, Barbie!"', 'Nominated for 8 Oscars including Best Picture'),
('Poor Things', 2023, 'Drama', 7.8, 'Yorgos Lanthimos', 35.0, 116.5, 141, 'The incredible tale about the fantastical evolution of Bella Baxter, a young woman brought back to life by the brilliant and unorthodox scientist Dr. Godwin Baxter. Yorgos Lanthimos'' surreal Frankenstein tale won 2 Oscars including Best Actress for Emma Stone. "I have adventures!"', 'Won 2 Oscars including Best Actress'),
('Killers of the Flower Moon', 2023, 'Drama', 7.7, 'Martin Scorsese', 200.0, 156.4, 206, 'When oil is discovered in 1920s Oklahoma under Osage Nation land, the Osage people are murdered one by one—until the FBI steps in to unravel the mystery. Martin Scorsese''s epic crime drama earned 10 Oscar nominations including Best Picture. "I buried my heart at Wounded Knee."', 'Nominated for 10 Oscars including Best Picture'),
('Anatomy of a Fall', 2023, 'Drama', 7.8, 'Justine Triet', 10.0, 32.0, 152, 'A woman is suspected of her husband''s murder, and their blind son faces a moral dilemma as the sole witness. Justine Triet''s French legal drama won the Oscar for Best Original Screenplay, making it the first French film to win in that category.', 'Won 1 Oscar for Best Original Screenplay'),
('The Holdovers', 2023, 'Drama', 7.9, 'Alexander Payne', 13.0, 41.4, 133, 'A cranky history teacher at a remote prep school is forced to remain on campus over the holidays with a grieving cook and a troubled student who has no place to go. Alexander Payne''s Christmas-set dramedy earned 5 Oscar nominations including Best Picture. Da''Vine Joy Randolph won the Oscar for Best Supporting Actress. "Merry Christmas, you filthy animals."', 'Nominated for 5 Oscars including Best Picture'),
('American Fiction', 2023, 'Drama', 7.9, 'Cord Jefferson', 10.0, 21.4, 117, 'A novelist who''s fed up with the establishment profiting from Black entertainment uses a pen name to write a book that heises the very stereotype he''s built a career satirizing. Cord Jefferson''s directorial debut won the Oscar for Best Adapted Screenplay. "I think you write what you know."', 'Won 1 Oscar for Best Adapted Screenplay'),
('Past Lives', 2023, 'Drama', 8.1, 'Celine Song', 12.0, 39.1, 106, 'Nora and Hae Sung, two deeply connected childhood friends, are wrest apart after Nora''s family emigrates from South Korea. Twenty years later, they are reunited for one fateful week as they confront notions of love and destiny. Celine Song''s directorial debut earned 2 Oscar nominations including Best Picture. "In another life, I would have really liked just doing laundry and taxes with you."', 'Nominated for 2 Oscars including Best Picture'),
('Zone of Interest', 2023, 'Drama', 7.2, 'Jonathan Glazer', 15.0, 50.6, 105, 'The commandant of Auschwitz and his wife strive to build a dream life for their family in a house and garden next to the camp. Jonathan Glazer''s haunting Holocaust drama won the Oscar for Best International Feature. "I want us all to be happy."', 'Won 1 Oscar for Best International Feature'),
('Godzilla Minus One', 2023, 'Sci-Fi', 7.7, 'Takashi Yamazaki', 15.0, 115.6, 125, 'Postwar Japan is at its lowest point when a new crisis emerges in the form of a giant monster, baptized in the horrific power of the atomic bomb. Takashi Yamazaki''s kaiju epic became the first Japanese Godzilla film to win the Oscar for Best Visual Effects. "GOJIRA"', 'Won 1 Oscar for Best Visual Effects'),
('The Boy and the Heron', 2023, 'Animation', 7.6, 'Hayao Miyazaki', 55.0, 173.4, 124, 'A young boy named Mahito yearning for his mother ventures into a world shared by the living and the dead. There, death has an end, and life finds a beginning. Hayao Miyazaki''s semi-autobiographical fantasy won the Oscar for Best Animated Feature, his second in the category. "What are you living for?"', 'Won 1 Oscar for Best Animated Feature'),
('Robot Dreams', 2023, 'Animation', 7.8, 'Pablo Berger', 10.0, 20.5, 102, 'A dog living in Manhattan decides to build himself a robot companion. Their friendship blossoms until a summer trip to the East Coast separates them. This Spanish-French animated feature was nominated for Best Animated Feature. "You are my best friend."', 'Nominated for 1 Oscar for Best Animated Feature'),
('Civil War', 2024, 'Drama', 7.3, 'Alex Garland', 50.0, 126.7, 109, 'In a near-future America torn apart by civil war, a team of journalists and military-embedded journalists travel across the United States during a rapidly escalating conflict that has brought the country to the brink of collapse. Alex Garland''s dystopian thriller became a box office hit in 2024. "What kind of American are you?"', 'Nominated for 3 Oscars including Best Original Screenplay'),
('Challengers', 2024, 'Drama', 7.1, 'Luca Guadagnino', 55.0, 95.8, 131, 'Tennis player turned coach Tashi has taken her husband, Art, and transformed him into a Grand Slam champion. To jolt him out of his recent losing streak, she has him playing a Challenger event—where he finds himself standing across the net from the once-promising player Patrick. Luca Guadagnino''s sports romance became a cultural phenomenon. "I want us to play."', 'Nominated for 2 Oscars including Best Supporting Actor'),
('Furiosa: A Mad Max Saga', 2024, 'Action', 7.8, 'George Miller', 168.0, 258.0, 148, 'The origin story of renegade warrior Furiosa before her encounter and target with Mad Max. Snatched from the Green Place of Many Mothers, young Furiosa falls into the hands of a great Biker Horde led by the Warlord Dementus. George Miller''s prequel to Fury Road earned acclaim for Anya Taylor-Joy''s performance. "I am the road warrior."', 'Nominated for 2 Oscars including Best Costume Design'),
('Inside Out 2', 2024, 'Animation', 7.8, 'Kelsey Mann', 175.0, 1697.0, 96, 'Follow Riley, now a teenager, as she navigates the complexities of growing up with new emotions joining Joy, Sadness, Anger, Fear, and Disgust in her mind headquarters. Pixar''s sequel became a box office phenomenon in 2024. "We''re not just emotions, we''re a team."', 'Nominated for 1 Oscar for Best Animated Feature'),
('Alien: Romulus', 2024, 'Sci-Fi', 7.3, 'Fede Álvarez', 80.0, 352.5, 119, 'While scavenging the deep ends of a derelict space station, a group of young space colonizers come face to face with the most terrifying life form in the universe. Fede Álvarez''s return-to-form Alien sequel received praise for its practical effects. "In space no one can hear you scream."', 'Nominated for 1 Oscar for Best Visual Effects'),
('A Real Pain', 2024, 'Drama', 7.7, 'Jesse Eisenberg', 10.0, 35.8, 90, 'Mis-matched cousins David and Benji reunite for a tour through Poland to honor their beloved grandmother. The adventure takes a turn when the odd couple''s old tensions resurface against the backdrop of their family history. Jesse Eisenberg''s dramedy earned 2 Oscar nominations including Best Supporting Actor for Kieran Culkin. "You''re a real pain."', 'Nominated for 2 Oscars including Best Supporting Actor'),
('Anora', 2024, 'Drama', 7.6, 'Sean Baker', 6.0, 40.5, 139, 'A sex worker from Brooklyn meets a Russian son of a oligarch and impulsively marries him, assuming his family will be unaware. When they find out, she is whisked off to a remote hunting lodge where she must fight for her life. Sean Baker''s gritty romance won the Palme d''Or at Cannes. "I''m not a prisoner, I''m a wife!"', 'Won Palme d''Or at Cannes'),
('The Brutalist', 2024, 'Drama', 8.1, 'Brady Corbet', 10.0, 34.8, 215, 'When a visionary architect and his wife flee postwar Europe in 1947 to rebuild their legacy and witness the birth of modern United States, their lives are transformed by a mysterious, wealthy client. Brady Corbet''s epic earned 4 Oscar nominations including Best Picture. "I am a brutalist."', 'Nominated for 4 Oscars including Best Picture'),
('Conclave', 2024, 'Drama', 7.3, 'Edward Berger', 20.0, 90.0, 120, 'When Cardinal Lawrence is tasked with presiding over the Vatican''s most secretive ritual, the election of a new Pope, he finds himself at the center of a conspiracy that could shake the very foundation of the Catholic Church. Edward Berger''s papal thriller earned 4 Oscar nominations including Best Picture. "We are all sinners."', 'Nominated for 4 Oscars including Best Picture'),
('Sing Sing', 2024, 'Drama', 8.0, 'Greg Kwedar', 2.0, 10.5, 107, 'Divine G, imprisoned at Sing Sing for a crime he didn''t commit, finds purpose by acting in a theatre group alongside other incarcerated men in this story of resilience, humanity, and the transformative power of art. Greg Kwedar''s prison drama earned 3 Oscar nominations including Best Adapted Screenplay. "I''m a man, not a monster."', 'Nominated for 3 Oscars including Best Adapted Screenplay'),
('Wicked', 2024, 'Drama', 8.1, 'Jon Chu', 150.0, 726.0, 160, 'The untold story of the witches of Oz, starring Cynthia Erivo as Elphaba, a young woman misunderstood because of her green skin, and Ariana Grande as Glinda, a popular girl with a penchant for perfection. Jon Chu''s musical adaptation became a box office phenomenon and earned 10 Oscar nominations including Best Picture. "Defying Gravity."', 'Nominated for 10 Oscars including Best Picture'),
('Gladiator II', 2024, 'Action', 7.7, 'Ridley Scott, 200.0, 470.0, 148, 'Decades after the death of Maximus, the Roman Empire continues to be ruled by corrupt leaders. A young man named Lucius enters the Colosseum to seek vengeance and restore glory to Rome. Ridley Scott''s long-awaited sequel became a box office hit. "I am Lucius, son of Lucilla."', 'Nominated for 1 Oscar for Best Costume Design'),
('Dune: Part Two', 2024, 'Sci-Fi', 8.4, 'Denis Villeneuve', 190.0, 711.8, 166, 'Paul Atreides unites with Chani and the Fremen while on a warpath of revenge against the conspirators who destroyed his family. Facing a choice between the love of his life and the fate of the known universe, he endeavors to prevent a terrible future only he can foresee. Denis Villeneuve''s epic became a box office phenomenon and earned 5 Oscar nominations including Best Picture. "I am the Kwisatz Haderach."', 'Nominated for 5 Oscars including Best Picture'),
('Kung Fu Panda 4', 2024, 'Animation', 7.0, 'Mike Mitchell, 85.0, 548.6, 94, 'Po is training to become the spiritual leader of the Valley of Peace, but he''s also distracted by thoughts of his late father. To make matters worse, a powerful sorceress plans to steal the Staff of Wisdom and wipe out Panda''s legacy. DreamWorks'' animated sequel became a surprise box office hit. "Skadoosh!"', 'Nominated for 1 Oscar for Best Animated Feature'),
('Krypton', 2024, 'Sci-Fi', 7.2, 'Gareth Edwards, 140.0, 380.5, 142, 'A young journalist discovers that the planet Krypton is not destroyed, but hidden in a remote corner of the galaxy. As he investigates the truth, he uncovers a conspiracy that threatens to destroy both Earth and Krypton. Gareth Edwards'' sci-fi epic explores Superman''s origins. "I am Kal-El of Krypton."', 'Nominated for 3 Oscars including Best Visual Effects'),
('Nosferatu', 2024, 'Drama', 7.5, 'Robert Eggers, 50.0, 240.5, 132, 'A reimagining of the classic vampire tale, set in 19th-century Germany. A young woman is plagued by terrifying dreams after her husband takes a job with a mysterious new employer. Robert Eggers'' Gothic horror earned 4 Oscar nominations including Best Director. "The shadow of the vampire."', 'Nominated for 4 Oscars including Best Director'),
('Maria', 2024, 'Drama', 7.4, 'Pablo Larraín, 25.0, 55.2, 123, 'The final years of opera legend Maria Callas, as she retreats from public life to reflect on her legendary career and personal struggles. Angelina Jolie stars in Pablo Larraín''s biopic that earned 3 Oscar nominations including Best Actress. "I am Maria Callas."', 'Nominated for 3 Oscars including Best Actress'),
('Juror #2', 2024, 'Drama', 7.1, 'Clint Eastwood, 30.0, 85.4, 114, 'While serving on a murder trial, a juror realizes he may be responsible for the victim''s death and must decide whether to manipulate the jury to save himself or reveal the truth. Clint Eastwood''s legal thriller became a late-year box office success. "I am the juror."', 'Nominated for 1 Oscar for Best Supporting Actor'),
('Babygirl', 2024, 'Drama', 6.8, 'Halina Reijn, 20.0, 65.3, 114, 'A high-powered CEO puts her career and family on the line when she begins a torrid affair with a much younger intern. Nicole Kidman and Harris Dickinson star in Halina Reijn''s workplace thriller. "I''m the boss."', 'Nominated for 2 Oscars including Best Actress'),
('Queer', 2024, 'Drama', 6.9, 'Luca Guadagnino, 35.0, 48.7, 137, 'In 1950s Mexico City, an American expat and aspiring writer forms a complex relationship with a younger man. Daniel Craig stars in Luca Guadagnino''s adaptation of William S. Burroughs'' novel. "I am a queer man."', 'Nominated for 3 Oscars including Best Actor'),
('Emilia Pérez', 2024, 'Drama', 7.0, 'Jacques Audiard, 30.0, 95.4, 132, 'A Mexican lawyer receives an offer from a cartel boss to help him disappear and transition into a woman. After four years of hormone therapy and surgery, she returns as Emilia Pérez, determined to reclaim her child and right past wrongs. Jacques Audiard''s musical crime drama won the Jury Prize at Cannes. "I am Emilia Pérez."', 'Won Jury Prize at Cannes'),
('The Apprentice', 2024, 'Drama', 6.7, 'Ali Abbasi, 25.0, 35.8, 120, 'The story of a young Donald Trump in 1970s New York, as he navigates the real estate world under the mentorship of notorious lawyer Roy Cohn. Sebastian Stan stars as Trump in Ali Abbasi''s biopic. "Make America Great Again."', 'Nominated for 3 Oscars including Best Actor'),
('Nightbitch', 2024, 'Drama', 6.5, 'Marielle Heller, 20.0, 28.5, 100, 'A former artist turned stay-at-home mom begins to suspect she''s turning into a dog. Amy Adams stars in Marielle Heller''s darkly comic exploration of motherhood. "I am a good mom."', 'Nominated for 2 Oscars including Best Actress'),
('Oh, Canada', 2024, 'Drama', 6.6, 'Paul Schrader, 15.0, 22.3, 91, 'An aging filmmaker reflects on his life and career, including his time as a draft dodger during the Vietnam War. Richard Gere stars in Paul Schrader''s introspective drama. "I am a Canadian."', 'Nominated for 1 Oscar for Best Adapted Screenplay'),
('The Room Next Door', 2024, 'Drama', 7.2, 'Pedro Almodóvar, 18.0, 32.5, 105, 'Two women, former friends who haven''t spoken in years, reunite when one asks the other to assist her during her final days. Tilda Swinton and Julianne Moore star in Pedro Almodóvar''s English-language debut. "I am ready to die."', 'Nominated for 3 Oscars including Best Actress'),
('Blitz', 2024, 'Drama', 7.4, 'Steve McQueen, 50.0, 45.2, 120, 'During World War II, a young boy is sent to the countryside by his mother to escape the London Blitz. However, he sneaks back to the city to find her. Saoirse Ronan stars in Steve McQueen''s wartime drama. "I will find my mother."', 'Nominated for 4 Oscars including Best Supporting Actress'),
('Better Man', 2024, 'Drama', 7.8, 'Michael Gracey, 40.0, 125.5, 135, 'The story of Robbie Williams, the British pop icon who rose to fame with Take That before launching a controversial solo career. Michael Gracey''s biopic uses CGI to depict Williams as a CGI chimpanzee. "Let me entertain you."', 'Nominated for 3 Oscars including Best Actor'),
('Shekhar', 2024, 'Drama', 7.3, 'Nia DaCosta, 35.0, 55.8, 118, 'A successful tech entrepreneur returns to his childhood home in India and reconnects with his estranged father, a classical musician. Dev Patel stars in Nia DaCosta''s family drama. "I am a good son."', 'Nominated for 2 Oscars including Best Supporting Actor'),
('The Last Dinner', 2024, 'Drama', 6.9, 'Oren Moverman, 12.0, 25.4, 107, 'A family gathers for what they believe will be a normal dinner, only to discover it''s an intervention for their patriarch''s controversial career. Richard Jenkins stars in Oren Moverman''s dark family drama. "This is my last dinner."', 'Nominated for 1 Oscar for Best Original Screenplay'),
('Substance', 2024, 'Drama', 7.6, 'Coralie Fargeat, 22.0, 76.8, 141, 'A fading celebrity decides to use a black market drug, a cell-replicating substance, to create a younger, better version of herself. Demi Moore and Margaret Qualley star in Coralie Fargeat''s body horror satire. "You are literally me."', 'Nominated for 5 Oscars including Best Actress'),
('September 5', 2024, 'Drama', 7.8, 'Tim Fehlbaum, 30.0, 42.5, 104, 'The 1972 Munich Olympics shooting, told from the perspective of the American sports broadcasting team. Peter Sarsgaard stars in Tim Fehlbaum''s thriller that earned 3 Oscar nominations including Best Supporting Actor. "This is September 5."', 'Nominated for 3 Oscars including Best Supporting Actor'),
('War Game', 2024, 'Drama', 7.5, 'Jesse Eisenberg, 8.0, 12.4, 98, 'A group of military veterans and civilians participate in a war game simulation that takes a dark turn. Jesse Eisenberg directs and stars in this indie thriller. "This is not a game."', 'Nominated for 2 Oscars including Best Original Screenplay'),
('Sasquatch Sunset', 2024, 'Drama', 7.0, 'David and Nathan Zellner, 15.0, 18.6, 89, 'A year in the life of a family of Sasquatch. The Zellner brothers'' quirky nature docudrama features Riley Keough and Jesse Eisenberg in prosthetic suits. "I am a Sasquatch."', 'Nominated for 2 Oscars including Best Makeup'),
('Piano Lesson', 2024, 'Drama', 7.7, 'Malcolm D. Lee, 25.0, 48.5, 115, 'A family struggles over an heirloom piano carved with images of their African ancestors. Malcolm D. Lee''s adaptation of August Wilson''s play earned 3 Oscar nominations including Best Supporting Actor for John David Washington. "This piano is our history."', 'Nominated for 3 Oscars including Best Supporting Actor'),
('Eddington', 2024, 'Drama', 6.8, 'James Mangold, 45.0, 68.5, 128, 'A physicist in the early 20th century must choose between his scientific career and his family during World War I. Benedict Cumberbatch stars in James Mangold''s historical drama. "Science must wait."', 'Nominated for 2 Oscars including Best Actor'),
('El Alamein', 2024, 'Drama', 7.1, 'Gilles Paquet-Brenner, 20.0, 32.8, 112, 'The story of the soldiers who fought in the decisive World War II battle in North Africa. Gilles Paquet-Brenner''s war drama earned 2 Oscar nominations including Best Foreign Language Film. "For victory."', 'Nominated for 2 Oscars including Best Foreign Language Film'),
('Electric State', 2024, 'Sci-Fi', 7.4, 'Anthony Russo, 180.0, 358.5, 138, 'In a retro-futuristic America, a teenage girl and her robot companion travel west in search of her missing brother. Millie Bobby Brown and Chris Pratt star in the Russo brothers'' sci-fi adventure. "I will find my brother."', 'Nominated for 4 Oscars including Best Visual Effects'),
('Sonic the Hedgehog 3', 2024, 'Sci-Fi', 7.2, 'Jeff Fowler, 122.0, 425.3, 110, 'Sonic, Tails, and Knuckles team up to battle Shadow the Hedgehog, a mysterious villain with powers equal to Sonic. The third installment of the video game adaptation became a box office hit. "Gotta go fast!"', 'Nominated for 2 Oscars including Best Original Song'),
('Moana 2', 2024, 'Animation', 7.6, 'David Derrick Jr., 150.0, 685.2, 100, 'Moana journeys to the far seas of Oceania and into dangerous, long-lost waters for an adventure unlike anything she''s ever faced. The sequel to Disney''s 2016 animated hit became a box office phenomenon. "The ocean chose me."', 'Nominated for 3 Oscars including Best Animated Feature'),
('Mufasa: The Lion King', 2024, 'Animation', 6.8, 'Barry Jenkins, 200.0, 485.6, 118, 'The origin story of Mufasa, the lion king who would rule the Pride Lands. Barry Jenkins'' prequel to The Lion King explores Mufasa''s rise to power. "Remember who you are."', 'Nominated for 2 Oscars including Best Animated Feature'),
('Paddington in Peru', 2024, 'Drama', 7.5, 'Douglas Wilson, 50.0, 155.8, 106, 'Paddington returns to Peru to visit his Aunt Lucy, who now lives at the Home for Retired Bears. The beloved bear''s third adventure earned critical acclaim. "Please look after this bear."', 'Nominated for 3 Oscars including Best Adapted Screenplay'),
('The Wild Robot', 2024, 'Animation', 8.2, 'Chris Sanders, 78.0, 385.5, 102, 'After a shipwreck, a robot named Roz is stranded on an uninhabited island and bonds with the local wildlife. DreamWorks'' animated adaptation became a critical darling and box office success. "I am Roz."', 'Nominated for 3 Oscars including Best Animated Feature'),
('Flow', 2024, 'Animation', 7.9, 'Gints Zilbalodis, 5.0, 28.5, 85, 'A cat navigates a post-apocalyptic world flooded by water, teaming up with other animals to survive. This Latvian animated feature won the Jury Prize at Cannes and earned 2 Oscar nominations. "I am a survivor."', 'Nominated for 2 Oscars including Best Animated Feature'),
('The Watchers', 2024, 'Drama', 6.7, 'Ishana Night Shyamalan, 30.0, 58.4, 102, 'A young artist stranded in an ancient forest discovers she''s being watched by mysterious creatures. Ishana Night Shyamalan''s directorial debut features Dakota Fanning. "They are always watching."', 'Nominated for 1 Oscar for Best Original Score'),
('Tarot', 2024, 'Drama', 6.5, 'Spenser Cohen, 15.0, 42.8, 96, 'A group of friends discovers an ancient tarot deck and unleashes a deadly curse. Harriet Slater stars in this supernatural thriller. "Your fate is sealed."', 'Nominated for 1 Oscar for Best Costume Design'),
('Arcadian', 2024, 'Drama', 6.9, 'Ben Brewer, 12.0, 35.6, 92, 'A father and his two twin sons defend their farm from mysterious creatures that emerge at night. Nicolas Cage stars in this post-apocalyptic thriller. "Protect the family."', 'Nominated for 2 Oscars including Best Visual Effects'),
('Longlegs', 2024, 'Drama', 7.2, 'Osgood Perkins, 10.0, 105.8, 101, 'An FBI agent uncovers a series of ritualistic murders connected to a mysterious figure named Longlegs. Maika Monroe and Nicolas Cage star in this indie horror hit. "Father loves you."', 'Nominated for 3 Oscars including Best Supporting Actor'),
('Trap', 2024, 'Drama', 6.8, 'M. Night Shyamalan, 30.0, 85.5, 105, 'A father takes his daughter to a pop concert, only to discover the event is a trap to catch a serial killer. M. Night Shyamalan''s thriller stars Josh Hartnett. "This is a trap."', 'Nominated for 2 Oscars including Best Original Screenplay'),
('Cuckoo', 2024, 'Drama', 7.0, 'Tilman Singer, 8.0, 25.4, 102, 'A young woman moves to a remote resort with her family and discovers dark secrets. Hunter Schafer stars in this horror thriller. "Something is wrong."', 'Nominated for 1 Oscar for Best Original Score'),
('The Order', 2024, 'Drama', 7.3, 'Justin Kurzel, 25.0, 18.5, 115, 'An FBI agent tracks down a white supremacist leader responsible for a series of violent crimes. Jude Law stars in Justin Kurzel''s crime drama. "Justice will be served."', 'Nominated for 2 Oscars including Best Actor'),
('The Bride!', 2024, 'Drama', 6.6, 'Maggie Gyllenhaal, 18.0, 28.6, 98, 'A wealthy young woman in 1950s New York discovers her fiancé is not who he seems. Margaret Qualley stars in Maggie Gyllenhaal''s directorial debut. "I am the bride!"', 'Nominated for 3 Oscars including Best Actress'),
('The Monkey', 2024, 'Drama', 6.4, 'Osgood Perkins, 8.0, 22.5, 95, 'A pair of twins reunite after their father''s death and discover a mysterious toy monkey in his attic. Theo James stars in this adaptation of Stephen King''s novella. "One clap, two claps, death."', 'Nominated for 1 Oscar for Best Makeup'),
('Bughouse', 2024, 'Drama', 7.1, 'James Ponsoldt, 12.0, 18.2, 108, 'A family struggles with mental illness in 1970s rural America. Paul Dano and Taissa Farmiga star in this indie drama. "We are all crazy here."', 'Nominated for 2 Oscars including Best Adapted Screenplay'),
('Exhibiting Forgiveness', 2024, 'Drama', 7.4, 'Titus Kaphar, 6.0, 12.5, 100, 'An artist confronts his traumatic past when his estranged father returns after decades. André Holland and John Earl Jelks star in Titus Kaphar''s directorial debut. "Forgiveness is a journey."', 'Nominated for 3 Oscars including Best Actor'),
('Lucky Dave', 2024, 'Drama', 6.9, 'Sean Baker, 10.0, 15.8, 105, 'A sex worker in Los Angeles navigates life during the COVID-19 pandemic. Sean Baker follows up The Florida Project with this poignant drama. "I am a survivor."', 'Nominated for 2 Oscars including Best Actress'),
('Yolo', 2024, 'Drama', 7.2, 'Tia Nomore, 5.0, 8.6, 92, 'A young woman in Oakland struggles to make ends meet while pursuing her music career. Tia Nomore''s directorial debut earned critical acclaim. "You only live once."', 'Nominated for 1 Oscar for Best Original Song'),
('Gliff', 2024, 'Drama', 7.0, 'Rory Kennedy, 8.0, 11.4, 98, 'A documentary filmmaker investigates a mysterious family secret. Rory Kennedy''s documentary earned 2 Oscar nominations. "The truth will set you free."', 'Nominated for 2 Oscars including Best Documentary Feature'),
('Ernest and Celestine: The Trip to Giverny', 2024, 'Animation', 7.8, 'Jean-Christophe Roger, 15.0, 25.6, 75, 'Ernest and Celestine travel to Giverny to meet Claude Monet. The sequel to the beloved French animated series earned acclaim. "Art is everywhere."', 'Nominated for 1 Oscar for Best Animated Feature'),
('Savagery', 2024, 'Drama', 6.7, 'Lisajoy Nolan, 20.0, 32.5, 115, 'A documentary filmmaker embeds with a group of survivalists in the Pacific Northwest. Lisajoy Nolan''s thriller stars Kaitlyn Dever. "Civilization is fragile."', 'Nominated for 2 Oscars including Best Original Screenplay'),
('Pavements', 2024, 'Drama', 7.3, 'Alex Ross Perry, 12.0, 18.6, 102, 'A documentary about the indie rock band Pavement. Alex Ross Perry''s music doc earned acclaim. "We are Pavement."', 'Nominated for 1 Oscar for Best Documentary Feature'),
('Bob Trevino Likes It', 2024, 'Drama', 7.6, 'Tracie Laymon, 8.0, 14.5, 108, 'A lonely woman strikes up an unlikely friendship with a stranger on Facebook. Barbie Ferreira stars in Tracie Laymon''s indie dramedy. "Friends are everywhere."', 'Nominated for 2 Oscars including Best Actress'),
('Midas', 2024, 'Drama', 6.8, 'Michele Civetta, 15.0, 22.3, 95, 'A wealthy man discovers he has the power to turn everything he touches into gold, but at a terrible cost. Bill Skarsgård stars in this modern fable. "Be careful what you wish for."', 'Nominated for 1 Oscar for Best Original Score'),
('Power', 2024, 'Drama', 7.0, 'Roseanne Liang, 18.0, 28.8, 110, 'A Chinese-American police officer in 1970s San Francisco uncovers a conspiracy involving the city''s elite. Stephanie Hsu stars in Roseanne Liang''s crime thriller. "Knowledge is power."', 'Nominated for 2 Oscars including Best Supporting Actress'),
('Unstoppable', 2024, 'Drama', 7.5, 'William Goldenberg, 25.0, 45.6, 125, 'The true story of Anthony Robles, who was born with one leg but became an NCAA wrestling champion. Jennifer Lopez stars in William Goldenberg''s sports drama. "Nothing is impossible."', 'Nominated for 3 Oscars including Best Actress'),
('Babygirl', 2024, 'Drama', 6.8, 'Halina Reijn, 20.0, 65.3, 114, 'A high-powered CEO puts her career and family on the line when she begins a torrid affair with a much younger intern. Nicole Kidman and Harris Dickinson star in Halina Reijn''s workplace thriller. "I''m the boss."', 'Nominated for 2 Oscars including Best Actress');

-- =====================================================
-- INSERT MOVIE_ACTORS (Key actors and Nicolas Cage roles)
-- =====================================================

INSERT INTO movie_actors (movie_id, actor_id, role_name, billing_order) VALUES
-- Nicolas Cage roles
(1, 1, 'Ben Gates', 1),
(2, 1, 'Castor Troy / Sean Archer', 1),
(3, 1, 'Cameron Poe', 1),
(4, 1, 'Stanley Goodspeed', 2),
(5, 1, 'Ben Sanderson', 1),
(6, 1, 'Charlie Kaufman / Donald Kaufman', 1),
(7, 1, 'H.I. McDunnough', 1),
(8, 1, 'Ronny Cammareri', 2),
(9, 1, 'Lula Pace Fortune', 1),
(10, 1, 'Memphis Raines', 1),
(11, 1, 'Yuri Orlov', 1),
(12, 1, 'Edward Malus', 1),
(13, 1, 'Peter Loew', 1),
(14, 1, 'Roy Waller', 1),
(15, 1, 'David Spritz', 1),
(16, 1, 'Tom Welles', 1),
(17, 1, 'Rick Santoro', 1),

-- Other notable casts
(18, 17, 'Andy Dufresne', 1),
(19, 2, 'Michael Corleone', 1),
(20, 14, 'Bruce Wayne / Batman', 1),
(20, 15, 'Joker', 2),
(21, 6, 'Tyler Durden', 2),
(21, 13, 'Narrator', 1),
(22, 4, 'Forrest Gump', 1),
(23, 5, 'Cobb', 1),
(24, 20, 'Neo', 1),
(25, 3, 'Jimmy Conway', 2),
(26, 11, 'Hannibal Lecter', 1),
(27, 10, 'John Hobbes', 1),
(28, 17, 'Andy Dufresne', 1),
(28, 7, 'Ellis Boyd "Red" Redding', 2),
(29, 19, 'John McClane', 1),
(30, 9, 'Indiana Jones', 1);

-- =====================================================
-- INSERT MOVIE_GENRES
-- =====================================================

-- Nicolas Cage movies
INSERT INTO movie_genres (movie_id, genre_id) VALUES (1, 1), (1, 12);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (2, 1), (2, 9), (2, 8);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (3, 1), (3, 8);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (4, 1), (4, 8);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (5, 2);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (6, 2), (6, 3);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (7, 3), (7, 2);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (8, 7), (8, 3);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (9, 2), (9, 4);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (10, 1), (10, 8);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (11, 2), (11, 8);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (12, 6), (12, 4);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (13, 3), (13, 6);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (14, 2), (14, 8);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (15, 2), (15, 3);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (16, 4), (16, 8);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (17, 4), (17, 8);

-- Other notable movies
INSERT INTO movie_genres (movie_id, genre_id) VALUES (18, 2);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (19, 2), (19, 8);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (20, 1), (20, 8), (20, 2);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (21, 2), (21, 8);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (22, 2), (22, 7);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (23, 5), (23, 2), (23, 8);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (24, 5), (24, 1);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (25, 2), (25, 8);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (26, 4), (26, 8);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (27, 4), (27, 2);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (28, 2);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (29, 1), (29, 8);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (30, 1), (30, 12), (30, 9);
