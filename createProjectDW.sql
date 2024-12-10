-- Створення бази даних
CREATE DATABASE ProjectsDW;
GO

USE ProjectsDW;
GO

-- Таблиця вимірів замовників
CREATE TABLE Dim_Customer (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50),
    adress VARCHAR(100),
    contact_person VARCHAR(50),
    phone VARCHAR(20),
    customer_key INT NOT NULL
);

-- Таблиця вимірів договорів
CREATE TABLE Dim_Agreement (
    agreement_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50),
    contract_category VARCHAR(50),
    date DATE,
    payment INT,
    agreement_key INT NOT NULL
);

-- Таблиця вимірів проектів
CREATE TABLE Dim_Project (
    project_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50),
    project_manager VARCHAR(50),
    planned_duration INT,
    difficulty_category VARCHAR(50),
    start_date DATE,
    project_key INT NOT NULL
);

-- Таблиця вимірів виконавців
CREATE TABLE Dim_Performer (
    performer_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50),
    post VARCHAR(50),
    qualification VARCHAR(50),
    time_rate DECIMAL(10,2),
    allowance_factor DECIMAL(10,2),
    performer_key INT NOT NULL
);

-- Таблиця вимірів рахунків
CREATE TABLE Dim_Account (
    account_id INT IDENTITY(1,1) PRIMARY KEY,
    sum INT,
    status_of_payment VARCHAR(16),
    account_key INT NOT NULL
);

-- Таблиця вимірів часу
CREATE TABLE Dim_Date (
    date_id INT IDENTITY(1,1) PRIMARY KEY,
    date DATE NOT NULL,
    year INT NOT NULL,
    month INT NOT NULL,
    day INT NOT NULL
);

-- Таблиця фактів для проектів
CREATE TABLE Fact_ProjectPerformance (
    fact_id INT IDENTITY(1,1) PRIMARY KEY,
    project_id INT,
    performer_id INT,
    agreement_id INT,
    customer_id INT,
    account_id INT,
    report_date_id INT,
    hours_worked INT,
    payment_sum DECIMAL(15,2),
    total_cost DECIMAL(15,2),
    FOREIGN KEY (project_id) REFERENCES Dim_Project(project_id),
    FOREIGN KEY (performer_id) REFERENCES Dim_Performer(performer_id),
    FOREIGN KEY (agreement_id) REFERENCES Dim_Agreement(agreement_id),
    FOREIGN KEY (customer_id) REFERENCES Dim_Customer(customer_id),
    FOREIGN KEY (account_id) REFERENCES Dim_Account(account_id),
    FOREIGN KEY (report_date_id) REFERENCES Dim_Date(date_id)
);

GO
