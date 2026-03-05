--  ACME CORP - SQL PRACTICE DATABASE
--  Compatible with: SQL Server / SSMS
--  Run this entire file in one shot after creating the DB

-- Create the database
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'AcmeCorp')
    CREATE DATABASE AcmeCorp;
GO

USE AcmeCorp;
GO

-- 1. DEPARTMENTS
CREATE TABLE departments (
    dept_id     INT IDENTITY(1,1) PRIMARY KEY,
    dept_name   NVARCHAR(100) NOT NULL,
    location    NVARCHAR(100),
    budget      DECIMAL(15,2),
    created_at  DATE DEFAULT CAST(GETDATE() AS DATE)
);

INSERT INTO departments (dept_name, location, budget) VALUES
('Engineering',        'Dhaka',        5000000.00),
('Sales',              'Chittagong',   3000000.00),
('Human Resources',    'Dhaka',        1500000.00),
('Finance',            'Dhaka',        2000000.00),
('Marketing',          'Sylhet',       1800000.00),
('Operations',         'Rajshahi',     2500000.00),
('IT Support',         'Dhaka',        1200000.00),
('Research & Dev',     'Dhaka',        4000000.00),
('Legal',              'Chittagong',    900000.00),
('Customer Service',   'Khulna',        700000.00);
GO

-- 2. EMPLOYEES
CREATE TABLE employees (
    emp_id          INT IDENTITY(1,1) PRIMARY KEY,
    first_name      NVARCHAR(50)  NOT NULL,
    last_name       NVARCHAR(50)  NOT NULL,
    email           NVARCHAR(120) UNIQUE NOT NULL,
    phone           NVARCHAR(20),
    hire_date       DATE          NOT NULL,
    job_title       NVARCHAR(100),
    salary          DECIMAL(12,2),
    dept_id         INT REFERENCES departments(dept_id),
    manager_id      INT REFERENCES employees(emp_id),
    is_active       BIT DEFAULT 1,
    gender          CHAR(1) CHECK (gender IN ('M','F','O')),
    date_of_birth   DATE
);

INSERT INTO employees (first_name, last_name, email, phone, hire_date, job_title, salary, dept_id, manager_id, is_active, gender, date_of_birth) VALUES
-- Engineering (dept 1)
('Rafiq',   'Ahmed',     'rafiq.ahmed@acme.com',       '01711000001', '2018-03-15', 'CTO',                   250000, 1, NULL, 1, 'M', '1980-05-10'),
('Nadia',   'Islam',     'nadia.islam@acme.com',       '01711000002', '2019-06-01', 'Senior Engineer',       120000, 1, 1,    1, 'F', '1990-08-22'),
('Tanvir',  'Hossain',   'tanvir.hossain@acme.com',    '01711000003', '2020-01-10', 'Backend Developer',      95000, 1, 1,    1, 'M', '1993-11-15'),
('Sadia',   'Karim',     'sadia.karim@acme.com',       '01711000004', '2021-07-20', 'Frontend Developer',     90000, 1, 2,    1, 'F', '1995-03-30'),
('Imran',   'Khan',      'imran.khan@acme.com',        '01711000005', '2022-02-14', 'Junior Developer',       65000, 1, 2,    1, 'M', '1998-07-07'),
('Farhan',  'Uddin',     'farhan.uddin@acme.com',      '01711000006', '2020-09-05', 'DevOps Engineer',       105000, 1, 1,    1, 'M', '1992-12-01'),
('Mitu',    'Begum',     'mitu.begum@acme.com',        '01711000007', '2023-01-03', 'QA Engineer',            70000, 1, 2,    1, 'F', '1997-04-18'),
-- Sales (dept 2)
('Karim',   'Molla',     'karim.molla@acme.com',       '01711000008', '2017-05-20', 'Sales Director',        200000, 2, NULL, 1, 'M', '1978-09-25'),
('Ritu',    'Das',       'ritu.das@acme.com',          '01711000009', '2019-03-11', 'Sales Manager',         130000, 2, 8,    1, 'F', '1988-01-14'),
('Sumon',   'Roy',       'sumon.roy@acme.com',         '01711000010', '2020-08-19', 'Sales Rep',              75000, 2, 9,    1, 'M', '1994-06-30'),
('Priya',   'Sen',       'priya.sen@acme.com',         '01711000011', '2021-11-01', 'Sales Rep',              72000, 2, 9,    1, 'F', '1996-02-20'),
('Arif',    'Chowdhury', 'arif.chowdhury@acme.com',    '01711000012', '2022-06-15', 'Sales Rep',              68000, 2, 9,    0, 'M', '1997-08-11'),
-- HR (dept 3)
('Laila',   'Noor',      'laila.noor@acme.com',        '01711000013', '2016-04-01', 'HR Director',           190000, 3, NULL, 1, 'F', '1976-07-07'),
('Habib',   'Rahman',    'habib.rahman@acme.com',      '01711000014', '2018-10-10', 'HR Manager',            110000, 3, 13,   1, 'M', '1985-03-22'),
('Nasrin',  'Parvin',    'nasrin.parvin@acme.com',     '01711000015', '2020-05-05', 'Recruiter',              65000, 3, 14,   1, 'F', '1993-10-10'),
-- Finance (dept 4)
('Bashir',  'Talukder',  'bashir.talukder@acme.com',   '01711000016', '2015-09-01', 'CFO',                   280000, 4, NULL, 1, 'M', '1972-11-20'),
('Roksana', 'Begum',     'roksana.begum@acme.com',     '01711000017', '2019-02-14', 'Senior Accountant',     100000, 4, 16,   1, 'F', '1987-06-05'),
('Dulal',   'Mia',       'dulal.mia@acme.com',         '01711000018', '2021-09-20', 'Junior Accountant',      60000, 4, 17,   1, 'M', '1996-09-15'),
-- Marketing (dept 5)
('Sumona',  'Akter',     'sumona.akter@acme.com',      '01711000019', '2018-07-11', 'Marketing Head',        170000, 5, NULL, 1, 'F', '1982-04-28'),
('Zahid',   'Hassan',    'zahid.hassan@acme.com',      '01711000020', '2020-12-01', 'Marketing Specialist',   85000, 5, 19,   1, 'M', '1991-01-15'),
('Tania',   'Sultana',   'tania.sultana@acme.com',     '01711000021', '2022-04-10', 'Content Writer',         55000, 5, 19,   1, 'F', '1998-11-11'),
-- Operations (dept 6)
('Jabbar',  'Ali',       'jabbar.ali@acme.com',        '01711000022', '2014-01-15', 'COO',                   300000, 6, NULL, 1, 'M', '1970-03-03'),
('Rehena',  'Khatun',    'rehena.khatun@acme.com',     '01711000023', '2017-08-08', 'Operations Manager',    140000, 6, 22,   1, 'F', '1983-07-19'),
('Motin',   'Sheikh',    'motin.sheikh@acme.com',      '01711000024', '2019-04-22', 'Logistics Coordinator',  80000, 6, 23,   1, 'M', '1992-05-05'),
-- IT Support (dept 7)
('Farida',  'Yasmin',    'farida.yasmin@acme.com',     '01711000025', '2020-03-17', 'IT Manager',            120000, 7, NULL, 1, 'F', '1989-02-14'),
('Sajib',   'Mondal',    'sajib.mondal@acme.com',      '01711000026', '2021-06-28', 'System Admin',           78000, 7, 25,   1, 'M', '1994-08-30'),
-- R&D (dept 8)
('Shamim',  'Haque',     'shamim.haque@acme.com',      '01711000027', '2016-11-01', 'R&D Director',          220000, 8, NULL, 1, 'M', '1979-12-25'),
('Farzana', 'Alam',      'farzana.alam@acme.com',      '01711000028', '2019-07-15', 'Research Scientist',    130000, 8, 27,   1, 'F', '1986-10-20'),
('Naim',    'Hossain',   'naim.hossain@acme.com',      '01711000029', '2021-03-09', 'Research Analyst',       80000, 8, 28,   1, 'M', '1995-05-12'),
-- Legal (dept 9)
('Shirin',  'Akter',     'shirin.akter@acme.com',      '01711000030', '2017-02-28', 'Legal Director',        200000, 9, NULL, 1, 'F', '1981-08-08'),
-- Customer Service (dept 10)
('Belal',   'Hossain',   'belal.hossain@acme.com',     '01711000031', '2019-10-05', 'CS Manager',            100000,10, NULL, 1, 'M', '1987-03-16'),
('Moni',    'Das',       'moni.das@acme.com',          '01711000032', '2020-11-11', 'CS Agent',               48000,10, 31,   1, 'F', '1997-07-25'),
('Rakib',   'Islam',     'rakib.islam@acme.com',       '01711000033', '2022-01-17', 'CS Agent',               46000,10, 31,   0, 'M', '1999-02-02'),
('Lovely',  'Begum',     'lovely.begum@acme.com',      '01711000034', '2023-05-22', 'CS Trainee',             35000,10, 31,   1, 'F', '2001-09-09');
GO

-- 3. SALARY HISTORY
CREATE TABLE salary_history (
    history_id  INT IDENTITY(1,1) PRIMARY KEY,
    emp_id      INT REFERENCES employees(emp_id),
    old_salary  DECIMAL(12,2),
    new_salary  DECIMAL(12,2),
    changed_at  DATE NOT NULL,
    reason      NVARCHAR(200)
);

INSERT INTO salary_history (emp_id, old_salary, new_salary, changed_at, reason) VALUES
(1,  200000, 250000, '2022-01-01', 'Annual raise'),
(2,   95000, 120000, '2022-06-01', 'Promotion to Senior'),
(3,   80000,  95000, '2023-01-01', 'Annual raise'),
(8,  160000, 200000, '2021-01-01', 'Promotion to Director'),
(9,  100000, 130000, '2022-03-01', 'Annual raise'),
(16, 240000, 280000, '2020-09-01', 'Annual raise'),
(22, 260000, 300000, '2021-04-01', 'Annual raise'),
(27, 180000, 220000, '2023-01-01', 'Annual raise');
GO

-- 4. CUSTOMERS
CREATE TABLE customers (
    customer_id   INT IDENTITY(1,1) PRIMARY KEY,
    company_name  NVARCHAR(150),
    contact_name  NVARCHAR(100),
    email         NVARCHAR(120) UNIQUE,
    phone         NVARCHAR(20),
    country       NVARCHAR(80),
    city          NVARCHAR(80),
    credit_limit  DECIMAL(12,2),
    joined_date   DATE,
    is_vip        BIT DEFAULT 0
);

INSERT INTO customers (company_name, contact_name, email, phone, country, city, credit_limit, joined_date, is_vip) VALUES
('TechNova BD',      'Amir Hossain',   'amir@technova.bd',      '01800001', 'Bangladesh', 'Dhaka',      500000, '2019-01-10', 1),
('Skyline Group',    'Mina Chowdhury', 'mina@skyline.bd',       '01800002', 'Bangladesh', 'Chittagong', 300000, '2020-03-15', 1),
('Delta Traders',    'Sohel Rana',     'sohel@delta.bd',        '01800003', 'Bangladesh', 'Sylhet',     150000, '2021-07-20', 0),
('RiverTech',        'Kohinoor Alam',  'kohinoor@rivertech.bd', '01800004', 'Bangladesh', 'Rajshahi',   200000, '2020-11-05', 0),
('Global Imports',   'Nina Patel',     'nina@globalimports.in', '01800005', 'India',      'Kolkata',    400000, '2018-06-01', 1),
('Horizon Ltd',      'James Wong',     'james@horizon.sg',      '01800006', 'Singapore',  'Singapore',  800000, '2017-09-18', 1),
('Alpha Connect',    'Sara Ali',       'sara@alphaconnect.ae',  '01800007', 'UAE',        'Dubai',      600000, '2019-04-12', 1),
('Coastal Ventures', 'Rahim Uddin',    'rahim@coastal.bd',      '01800008', 'Bangladesh', 'Khulna',     100000, '2022-02-28', 0),
('Green Valley',     'Fatema Khatun',  'fatema@greenvalley.bd', '01800009', 'Bangladesh', 'Dhaka',      250000, '2021-10-10', 0),
('Summit Corp',      'David Park',     'david@summit.kr',       '01800010', 'South Korea','Seoul',      700000, '2020-08-25', 1),
('Pixel Works',      'Lena Muller',    'lena@pixelworks.de',    '01800011', 'Germany',    'Berlin',     550000, '2019-12-01', 1),
('Sunrise Exports',  'Nasim Uddin',    'nasim@sunrise.bd',      '01800012', 'Bangladesh', 'Dhaka',       80000, '2023-01-05', 0);
GO

-- 5. CATEGORIES & PRODUCTS
CREATE TABLE categories (
    cat_id    INT IDENTITY(1,1) PRIMARY KEY,
    cat_name  NVARCHAR(100) NOT NULL,
    parent_id INT REFERENCES categories(cat_id)
);

INSERT INTO categories (cat_name, parent_id) VALUES
('Software',         NULL),
('Hardware',         NULL),
('Services',         NULL),
('Cloud Solutions',  1),
('Security',         1),
('Networking',       2),
('Servers',          2),
('Consulting',       3),
('Support Plans',    3);
GO

CREATE TABLE products (
    product_id    INT IDENTITY(1,1) PRIMARY KEY,
    product_name  NVARCHAR(200) NOT NULL,
    cat_id        INT REFERENCES categories(cat_id),
    unit_price    DECIMAL(12,2) NOT NULL,
    cost_price    DECIMAL(12,2),
    stock_qty     INT DEFAULT 0,
    reorder_level INT DEFAULT 10,
    is_active     BIT DEFAULT 1,
    created_at    DATE DEFAULT CAST(GETDATE() AS DATE)
);

INSERT INTO products (product_name, cat_id, unit_price, cost_price, stock_qty, reorder_level) VALUES
('Enterprise CRM License',      1,  85000,  40000,  50,  5),
('Antivirus Suite Pro',         5,  12000,   5000, 200, 20),
('Cloud Backup 1TB/yr',         4,  18000,   7000,  99, 10),
('VPN Gateway License',         5,  25000,  11000,  75,  8),
('Network Switch 48-Port',      6,  35000,  18000,  30,  5),
('Rack Server 2U',              7, 120000,  65000,  15,  3),
('Managed Switch 24-Port',      6,  22000,  11000,  45,  5),
('Cloud Hosting Basic/yr',      4,   8000,   3000, 500, 50),
('IT Consulting (per day)',      8,  15000,   8000,   0,  0),
('Premium Support Plan/yr',     9,  30000,  12000, 120, 10),
('Firewall Appliance',          5,  55000,  28000,  20,  3),
('Laptop i7 16GB',              2,  95000,  70000,  40,  5),
('Desktop Workstation',         2,  75000,  52000,  25,  5),
('ERP Software License',        1, 150000,  70000,  30,  3),
('Database Monitoring Tool',    1,  40000,  18000,  60,  8);
GO

-- 6. ORDERS
CREATE TABLE orders (
    order_id        INT IDENTITY(1,1) PRIMARY KEY,
    customer_id     INT REFERENCES customers(customer_id),
    emp_id          INT REFERENCES employees(emp_id),
    order_date      DATE NOT NULL,
    ship_date       DATE,
    status          NVARCHAR(30) CHECK (status IN ('Pending','Processing','Shipped','Delivered','Cancelled')),
    payment_method  NVARCHAR(30),
    notes           NVARCHAR(MAX)
);

INSERT INTO orders (customer_id, emp_id, order_date, ship_date, status, payment_method) VALUES
(1,  10, '2023-01-05', '2023-01-10', 'Delivered',  'Bank Transfer'),
(2,  11, '2023-01-12', '2023-01-18', 'Delivered',  'Credit Card'),
(3,  10, '2023-02-01', '2023-02-05', 'Delivered',  'Bank Transfer'),
(4,  11, '2023-02-14', '2023-02-20', 'Delivered',  'Cash'),
(5,  10, '2023-03-01', '2023-03-06', 'Delivered',  'Bank Transfer'),
(6,  9,  '2023-03-15', NULL,         'Shipped',    'Bank Transfer'),
(7,  9,  '2023-04-01', NULL,         'Processing', 'Credit Card'),
(8,  10, '2023-04-10', '2023-04-15', 'Delivered',  'Cash'),
(1,  11, '2023-05-01', '2023-05-08', 'Delivered',  'Bank Transfer'),
(2,  10, '2023-05-20', NULL,         'Pending',    'Credit Card'),
(9,  11, '2023-06-01', '2023-06-07', 'Delivered',  'Bank Transfer'),
(10, 9,  '2023-06-18', '2023-06-25', 'Delivered',  'Bank Transfer'),
(11, 10, '2023-07-02', NULL,         'Cancelled',  'Credit Card'),
(3,  11, '2023-07-15', '2023-07-20', 'Delivered',  'Cash'),
(6,  9,  '2023-08-01', '2023-08-10', 'Delivered',  'Bank Transfer'),
(12, 10, '2023-08-20', NULL,         'Processing', 'Bank Transfer'),
(1,  11, '2023-09-01', '2023-09-08', 'Delivered',  'Bank Transfer'),
(5,  9,  '2023-09-15', '2023-09-22', 'Delivered',  'Credit Card'),
(7,  10, '2023-10-01', NULL,         'Shipped',    'Bank Transfer'),
(4,  11, '2023-10-18', '2023-10-25', 'Delivered',  'Cash'),
(8,  9,  '2023-11-01', '2023-11-07', 'Delivered',  'Bank Transfer'),
(2,  10, '2023-11-20', '2023-11-28', 'Delivered',  'Bank Transfer'),
(10, 11, '2023-12-01', NULL,         'Processing', 'Credit Card'),
(1,  9,  '2023-12-15', NULL,         'Pending',    'Bank Transfer');
GO

-- 7. ORDER ITEMS
CREATE TABLE order_items (
    item_id     INT IDENTITY(1,1) PRIMARY KEY,
    order_id    INT REFERENCES orders(order_id),
    product_id  INT REFERENCES products(product_id),
    quantity    INT NOT NULL,
    unit_price  DECIMAL(12,2) NOT NULL,
    discount    DECIMAL(5,2) DEFAULT 0
);

INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount) VALUES
(1,  1,  2,  85000, 5),  (1,  3,  1,  18000, 0),
(2,  6,  1, 120000,10),  (2,  12, 2,  95000, 5),
(3,  2,  5,  12000, 0),  (3,  4,  2,  25000, 5),
(4,  8, 10,   8000,10),  (4,  10, 1,  30000, 0),
(5,  14, 1, 150000, 8),  (5,  9,  3,  15000, 0),
(6,  11, 2,  55000, 5),  (6,  5,  3,  35000, 0),
(7,  1,  1,  85000, 0),  (7,  15, 2,  40000, 5),
(8,  8, 20,   8000,15),  (8,  2, 10,  12000,10),
(9,  6,  2, 120000, 8),  (9,  13, 1,  75000, 0),
(10, 4,  3,  25000, 0),  (10, 7,  2,  22000, 5),
(11, 14, 1, 150000, 5),  (11, 10, 2,  30000, 0),
(12, 1,  3,  85000,10),  (12, 3,  5,  18000, 5),
(13, 12, 2,  95000, 0),
(14, 9,  5,  15000, 0),  (14, 2, 20,  12000,10),
(15, 11, 1,  55000, 0),  (15, 5,  2,  35000, 5),
(16, 8, 30,   8000,20),
(17, 1,  1,  85000, 5),  (17, 14, 1, 150000,10),
(18, 6,  1, 120000, 5),  (18, 4,  4,  25000, 0),
(19, 15, 3,  40000, 8),
(20, 10, 3,  30000, 5),  (20, 7,  5,  22000, 0),
(21, 2, 15,  12000,10),  (21, 3,  3,  18000, 0),
(22, 6,  2, 120000, 8),  (22, 12, 1,  95000, 0),
(23, 14, 2, 150000, 5),  (23, 1,  1,  85000, 0),
(24, 9, 10,  15000, 0),  (24, 8, 50,   8000,25);
GO

-- 8. PROJECTS
CREATE TABLE projects (
    project_id    INT IDENTITY(1,1) PRIMARY KEY,
    project_name  NVARCHAR(200) NOT NULL,
    dept_id       INT REFERENCES departments(dept_id),
    start_date    DATE,
    end_date      DATE,
    budget        DECIMAL(15,2),
    spent         DECIMAL(15,2) DEFAULT 0,
    status        NVARCHAR(30) CHECK (status IN ('Planning','Active','On Hold','Completed','Cancelled')),
    priority      NVARCHAR(10) CHECK (priority IN ('Low','Medium','High','Critical'))
);

INSERT INTO projects (project_name, dept_id, start_date, end_date, budget, spent, status, priority) VALUES
('ERP System Upgrade',        1, '2023-01-01', '2023-12-31', 2000000, 1450000, 'Active',    'Critical'),
('Customer Portal v2',        1, '2023-03-01', '2023-09-30',  800000,  820000, 'Completed', 'High'),
('Market Expansion BD',       2, '2023-02-01', '2024-01-31',  500000,  210000, 'Active',    'High'),
('HR Digital Transformation', 3, '2023-01-15', '2023-07-15',  300000,  305000, 'Completed', 'Medium'),
('Finance Automation',        4, '2023-04-01', '2024-03-31',  700000,  180000, 'Active',    'High'),
('Brand Refresh Campaign',    5, '2023-06-01', '2023-10-31',  250000,  248000, 'Completed', 'Medium'),
('Cloud Migration',           1, '2023-07-01', '2024-06-30', 1500000,  430000, 'Active',    'Critical'),
('Cybersecurity Audit',       7, '2023-05-01', '2023-08-31',  180000,  175000, 'Completed', 'High'),
('New Product Research',      8, '2023-01-01', '2024-12-31', 3000000,  950000, 'Active',    'High'),
('Legal Compliance Review',   9, '2023-03-01', '2023-06-30',  120000,  118000, 'Completed', 'Medium');
GO

-- 9. PROJECT ASSIGNMENTS
CREATE TABLE project_assignments (
    assignment_id INT IDENTITY(1,1) PRIMARY KEY,
    project_id    INT REFERENCES projects(project_id),
    emp_id        INT REFERENCES employees(emp_id),
    role          NVARCHAR(100),
    assigned_date DATE,
    hours_logged  INT DEFAULT 0
);

INSERT INTO project_assignments (project_id, emp_id, role, assigned_date, hours_logged) VALUES
(1, 1,  'Tech Lead',         '2023-01-01', 320),
(1, 3,  'Backend Dev',       '2023-01-01', 580),
(1, 4,  'Frontend Dev',      '2023-01-01', 540),
(1, 6,  'DevOps',            '2023-01-05', 290),
(2, 2,  'Lead Engineer',     '2023-03-01', 450),
(2, 4,  'Frontend Dev',      '2023-03-01', 510),
(2, 7,  'QA',                '2023-03-01', 380),
(3, 9,  'Sales Lead',        '2023-02-01', 200),
(3, 10, 'Sales Rep',         '2023-02-01', 310),
(4, 13, 'Project Owner',     '2023-01-15', 150),
(4, 14, 'HR Analyst',        '2023-01-15', 280),
(5, 16, 'Project Sponsor',   '2023-04-01', 120),
(5, 17, 'Lead Accountant',   '2023-04-01', 350),
(6, 19, 'Campaign Lead',     '2023-06-01', 190),
(6, 20, 'Specialist',        '2023-06-01', 240),
(7, 1,  'Architect',         '2023-07-01', 210),
(7, 6,  'DevOps Lead',       '2023-07-01', 380),
(7, 3,  'Backend Dev',       '2023-07-01', 290),
(8, 25, 'Security Lead',     '2023-05-01', 270),
(8, 26, 'Sys Admin',         '2023-05-01', 300),
(9, 27, 'Research Director', '2023-01-01', 480),
(9, 28, 'Lead Scientist',    '2023-01-01', 560),
(9, 29, 'Data Analyst',      '2023-01-01', 490),
(10,30, 'Legal Lead',        '2023-03-01', 180);
GO

-- 10. LEAVE REQUESTS
CREATE TABLE leave_requests (
    leave_id    INT IDENTITY(1,1) PRIMARY KEY,
    emp_id      INT REFERENCES employees(emp_id),
    leave_type  NVARCHAR(50) CHECK (leave_type IN ('Annual','Sick','Maternity','Paternity','Unpaid','Emergency')),
    start_date  DATE NOT NULL,
    end_date    DATE NOT NULL,
    status      NVARCHAR(20) CHECK (status IN ('Pending','Approved','Rejected')),
    approved_by INT REFERENCES employees(emp_id),
    reason      NVARCHAR(MAX)
);

INSERT INTO leave_requests (emp_id, leave_type, start_date, end_date, status, approved_by, reason) VALUES
(3,  'Annual',    '2023-07-01', '2023-07-07', 'Approved', 1,  'Family vacation'),
(4,  'Sick',      '2023-03-10', '2023-03-12', 'Approved', 2,  'Fever'),
(5,  'Annual',    '2023-12-24', '2023-12-31', 'Approved', 2,  'Year-end vacation'),
(10, 'Annual',    '2023-06-01', '2023-06-05', 'Approved', 9,  'Personal'),
(11, 'Maternity', '2023-04-01', '2023-09-30', 'Approved', 9,  'Maternity leave'),
(15, 'Emergency', '2023-08-15', '2023-08-16', 'Approved', 14, 'Family emergency'),
(18, 'Sick',      '2023-05-05', '2023-05-06', 'Rejected', 17, 'No supporting document'),
(21, 'Annual',    '2023-10-01', '2023-10-07', 'Approved', 19, 'Vacation'),
(24, 'Paternity', '2023-09-01', '2023-09-14', 'Approved', 23, 'Newborn'),
(26, 'Sick',      '2023-11-20', '2023-11-21', 'Pending',  25, 'Flu'),
(7,  'Annual',    '2023-08-01', '2023-08-05', 'Approved', 2,  'Vacation'),
(32, 'Sick',      '2023-02-14', '2023-02-15', 'Approved', 31, 'Headache'),
(29, 'Unpaid',    '2023-12-01', '2023-12-10', 'Pending',  28, 'Personal study');
GO

-- 11. INVOICES
CREATE TABLE invoices (
    invoice_id   INT IDENTITY(1,1) PRIMARY KEY,
    order_id     INT REFERENCES orders(order_id),
    invoice_date DATE NOT NULL,
    due_date     DATE,
    total_amount DECIMAL(14,2),
    paid_amount  DECIMAL(14,2) DEFAULT 0,
    status       NVARCHAR(20) CHECK (status IN ('Draft','Sent','Paid','Overdue','Cancelled'))
);

INSERT INTO invoices (order_id, invoice_date, due_date, total_amount, paid_amount, status) VALUES
(1,  '2023-01-10', '2023-01-25', 188000,  188000, 'Paid'),
(2,  '2023-01-18', '2023-02-02', 310000,  310000, 'Paid'),
(3,  '2023-02-05', '2023-02-20', 110000,  110000, 'Paid'),
(4,  '2023-02-20', '2023-03-07',  86000,   86000, 'Paid'),
(5,  '2023-03-06', '2023-03-21', 183000,  183000, 'Paid'),
(6,  '2023-03-20', '2023-04-04', 215000,  100000, 'Overdue'),
(7,  '2023-04-05', '2023-04-20', 165000,       0, 'Sent'),
(8,  '2023-04-15', '2023-04-30', 280000,  280000, 'Paid'),
(9,  '2023-05-08', '2023-05-23', 315000,  315000, 'Paid'),
(10, '2023-05-25', '2023-06-09',  97000,       0, 'Overdue'),
(11, '2023-06-07', '2023-06-22', 210000,  210000, 'Paid'),
(12, '2023-06-25', '2023-07-10', 313500,  313500, 'Paid'),
(13, '2023-07-05', '2023-07-20', 190000,       0, 'Cancelled'),
(14, '2023-07-20', '2023-08-04', 315000,  315000, 'Paid'),
(15, '2023-08-10', '2023-08-25', 121500,  121500, 'Paid'),
(16, '2023-08-25', '2023-09-09', 192000,   50000, 'Overdue'),
(17, '2023-09-08', '2023-09-23', 224750,  224750, 'Paid'),
(18, '2023-09-22', '2023-10-07', 214000,  214000, 'Paid'),
(19, '2023-10-05', '2023-10-20', 110400,       0, 'Sent'),
(20, '2023-10-25', '2023-11-09', 200000,  200000, 'Paid'),
(21, '2023-11-07', '2023-11-22', 234000,  234000, 'Paid'),
(22, '2023-11-28', '2023-12-13', 332400,  332400, 'Paid'),
(23, '2023-12-05', '2023-12-20', 385000,       0, 'Sent'),
(24, '2023-12-18', '2024-01-02', 550000,       0, 'Draft');
GO

-- 12. AUDIT LOG
CREATE TABLE audit_log (
    log_id      INT IDENTITY(1,1) PRIMARY KEY,
    table_name  NVARCHAR(100),
    operation   NVARCHAR(20) CHECK (operation IN ('INSERT','UPDATE','DELETE')),
    record_id   INT,
    changed_by  INT REFERENCES employees(emp_id),
    changed_at  DATETIME DEFAULT GETDATE(),
    old_values  NVARCHAR(MAX),
    new_values  NVARCHAR(MAX)
);

INSERT INTO audit_log (table_name, operation, record_id, changed_by, changed_at, old_values, new_values) VALUES
('employees', 'UPDATE', 12, 13, '2023-06-01 10:00:00', 'is_active=1', 'is_active=0'),
('employees', 'UPDATE', 33, 13, '2023-04-15 14:30:00', 'is_active=1', 'is_active=0'),
('orders',    'UPDATE',  6,  9, '2023-03-20 09:15:00', 'status=Processing', 'status=Shipped'),
('invoices',  'UPDATE',  6, 17, '2023-04-05 11:00:00', 'paid_amount=0', 'paid_amount=100000'),
('products',  'UPDATE',  6, 25, '2023-07-01 08:00:00', 'stock_qty=20', 'stock_qty=15');
GO

--  VIEWS
CREATE VIEW v_employee_full AS
SELECT
    e.emp_id,
    e.first_name + ' ' + e.last_name        AS full_name,
    e.email,
    e.job_title,
    e.salary,
    e.hire_date,
    e.is_active,
    e.gender,
    d.dept_name,
    d.location                               AS dept_location,
    m.first_name + ' ' + m.last_name        AS manager_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
LEFT JOIN employees m ON e.manager_id = m.emp_id;
GO

CREATE VIEW v_order_summary AS
SELECT
    o.order_id,
    c.company_name                           AS customer,
    c.country,
    e.first_name + ' ' + e.last_name        AS sales_rep,
    o.order_date,
    o.status,
    COUNT(oi.item_id)                        AS total_items,
    SUM(oi.quantity * oi.unit_price * (1 - oi.discount/100)) AS order_total
FROM orders o
JOIN customers  c  ON o.customer_id = c.customer_id
JOIN employees  e  ON o.emp_id      = e.emp_id
JOIN order_items oi ON o.order_id   = oi.order_id
GROUP BY
    o.order_id, c.company_name, c.country,
    e.first_name, e.last_name,
    o.order_date, o.status;
GO

--  VERIFY — run these to confirm everything loaded correctly
SELECT COUNT(*) AS dept_count      FROM departments;       -- 10
SELECT COUNT(*) AS emp_count       FROM employees;         -- 34
SELECT COUNT(*) AS customer_count  FROM customers;         -- 12
SELECT COUNT(*) AS product_count   FROM products;          -- 15
SELECT COUNT(*) AS order_count     FROM orders;            -- 24
SELECT COUNT(*) AS item_count      FROM order_items;       -- 45
SELECT COUNT(*) AS invoice_count   FROM invoices;          -- 24
SELECT COUNT(*) AS project_count   FROM projects;          -- 10