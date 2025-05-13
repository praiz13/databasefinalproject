-- Creating database for Clinic Booking System
CREATE DATABASE ClinicBookingSystem;
USE ClinicBookingSystem;

-- Table to store patient information
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY, 
    first_name VARCHAR(50) NOT NULL, 
    last_name VARCHAR(50) NOT NULL, 
    date_of_birth DATE NOT NULL, 
    gender ENUM('Male', 'Female', 'Other') NOT NULL, 
    phone_number VARCHAR(15) UNIQUE NOT NULL, 
    email VARCHAR(100) UNIQUE,
    address TEXT NOT NULL
);

-- Table to store doctor information
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY, 
    first_name VARCHAR(50) NOT NULL, 
    last_name VARCHAR(50) NOT NULL, 
    specialization_id INT, 
    phone_number VARCHAR(15) UNIQUE NOT NULL, 
    email VARCHAR(100) UNIQUE,
    FOREIGN KEY (specialization_id) REFERENCES Specializations(specialization_id) ON DELETE SET NULL
);

-- Table to store specializations
CREATE TABLE Specializations (
    specialization_id INT AUTO_INCREMENT PRIMARY KEY, 
    specialization_name VARCHAR(100) UNIQUE NOT NULL
);

-- Table to store appointments
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY, 
    patient_id INT, 
    doctor_id INT, 
    appointment_date DATETIME NOT NULL, 
    status ENUM('Pending', 'Completed', 'Cancelled') NOT NULL, 
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE
);

-- Table to store payment details for appointments
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY, 
    appointment_id INT, 
    payment_amount DECIMAL(10, 2) NOT NULL, 
    payment_date DATETIME NOT NULL, 
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) ON DELETE CASCADE
);

-- Many-to-Many relationship between doctors and specializations (Doctors can have multiple specializations)
CREATE TABLE DoctorSpecializations (
    doctor_id INT, 
    specialization_id INT, 
    PRIMARY KEY (doctor_id, specialization_id), 
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE,
    FOREIGN KEY (specialization_id) REFERENCES Specializations(specialization_id) ON DELETE CASCADE
);
