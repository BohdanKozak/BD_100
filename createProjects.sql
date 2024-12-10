-- Створення бази даних
CREATE DATABASE Projects;
GO

USE Projects;
GO

-- Таблиця для замовників
CREATE TABLE Customer (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    adress VARCHAR(100) NOT NULL,
    contact_person VARCHAR(50) NOT NULL,
    phone VARCHAR(20) NOT NULL
);

-- Таблиця для договорів
CREATE TABLE Agreement (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    customer INT NOT NULL,
    contract_category VARCHAR(50) NOT NULL,
    date DATE NOT NULL,
    payment INT NOT NULL,
    FOREIGN KEY (customer) REFERENCES Customer(id)
);

-- Таблиця для рахунків
CREATE TABLE Account (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_agreement INT NOT NULL,
    sum INT NOT NULL,
    status_of_payment VARCHAR(16) NOT NULL,
    FOREIGN KEY (id_agreement) REFERENCES Agreement(id)
);

-- Таблиця для проектів
CREATE TABLE Project (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    customer INT NOT NULL,
    project_manager VARCHAR(50) NOT NULL,
    planned_duration INT NOT NULL,
    difficulty_category VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    FOREIGN KEY (customer) REFERENCES Customer(id)
);

-- Таблиця для виконавців
CREATE TABLE Performer (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    post VARCHAR(50) NOT NULL,
    qualification VARCHAR(50) NOT NULL,
    time_rate DECIMAL(10,2) NOT NULL,
    allowance_factor DECIMAL(10,2) NOT NULL,
    hours_worked INT NOT NULL
);

-- Таблиця для зв’язку виконавців та проектів
CREATE TABLE Performers_Projects (
    performer_id INT NOT NULL,
    project_id INT NOT NULL,
    PRIMARY KEY (performer_id, project_id),
    FOREIGN KEY (performer_id) REFERENCES Performer(id),
    FOREIGN KEY (project_id) REFERENCES Project(id)
);

-- Таблиця для звітів
CREATE TABLE Reports (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_performer INT NOT NULL,
    id_project INT NOT NULL,
    date DATE NOT NULL,
    description VARCHAR(256) NOT NULL,
    hours_worked INT NOT NULL,
    FOREIGN KEY (id_performer) REFERENCES Performer(id),
    FOREIGN KEY (id_project) REFERENCES Project(id)
);
GO
