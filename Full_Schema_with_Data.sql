-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema af25nathm1_collegev2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema af25nathm1_collegev2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `af25nathm1_collegev2` ;
USE `af25nathm1_collegev2` ;

-- -----------------------------------------------------
-- Table `af25nathm1_collegev2`.`building`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev2`.`building` (
  `building_id` INT(11) NOT NULL AUTO_INCREMENT,
  `building_name` VARCHAR(255) NULL DEFAULT NULL,
  `building_room_number` INT(11) NULL DEFAULT NULL,
  `building_room_capacity` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`building_id`),
  INDEX `BUILDING_NAME` (`building_name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 5;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev2`.`course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev2`.`course` (
  `course_id` INT(11) NOT NULL AUTO_INCREMENT,
  `course_name` VARCHAR(255) NULL DEFAULT NULL,
  `course_credit_hours` INT(11) NULL DEFAULT NULL,
  `course_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP(),
  `audit_user_id` INT(11) NOT NULL,
  `course_audited` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  PRIMARY KEY (`course_id`),
  INDEX `course_name` (`course_name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 5;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev2`.`lookup_employee_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev2`.`lookup_employee_role` (
  `lookup_employee_role_id` INT(11) NOT NULL AUTO_INCREMENT,
  `lookup_employee_role_name` VARCHAR(255) NULL DEFAULT NULL,
  `lookup_employee_role_security_level` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`lookup_employee_role_id`),
  INDEX `role` (`lookup_employee_role_name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 9;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev2`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev2`.`employee` (
  `employee_id` INT(11) NOT NULL AUTO_INCREMENT,
  `employee_start_date` DATE NULL DEFAULT NULL,
  `employee_end_date` DATE NULL DEFAULT NULL,
  `employee_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP(),
  `audit_user_id` INT(11) NOT NULL,
  `employee_edited` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  `lookup_employee_role_id` INT(11) NOT NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `fk_employee_lookup_employee_role1_idx` (`lookup_employee_role_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_lookup_employee_role1`
    FOREIGN KEY (`lookup_employee_role_id`)
    REFERENCES `af25nathm1_collegev2`.`lookup_employee_role` (`lookup_employee_role_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 9;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev2`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev2`.`department` (
  `department_id` INT(11) NOT NULL,
  `department_name` VARCHAR(255) NULL DEFAULT NULL,
  `department_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP(),
  `audit_user_id` INT(11) NOT NULL,
  `department_audited` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  `employee_id` INT(11) NOT NULL,
  PRIMARY KEY (`department_id`),
  INDEX `department_name` (`department_name` ASC) VISIBLE,
  INDEX `fk_department_employee1_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_department_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `af25nathm1_collegev2`.`employee` (`employee_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev2`.`course_has_department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev2`.`course_has_department` (
  `department_id` INT(11) NOT NULL,
  `course_id` INT(11) NOT NULL,
  INDEX `fk_course_has_department_department1_idx` (`department_id` ASC) VISIBLE,
  INDEX `fk_course_has_department_course1_idx` (`course_id` ASC) VISIBLE,
  CONSTRAINT `fk_course_has_department_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `af25nathm1_collegev2`.`course` (`course_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_course_has_department_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `af25nathm1_collegev2`.`department` (`department_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev2`.`lookup_grade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev2`.`lookup_grade` (
  `lookup_grade_id` INT(11) NOT NULL AUTO_INCREMENT,
  `lookup_grade_letter` VARCHAR(255) NULL DEFAULT NULL,
  `lookup_grade_point_value` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`lookup_grade_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev2`.`semester`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev2`.`semester` (
  `semester_id` INT(11) NOT NULL,
  `semester_season` VARCHAR(255) NULL DEFAULT NULL,
  `audit_user_id` INT(11) NOT NULL,
  PRIMARY KEY (`semester_id`),
  INDEX `semester_season` (`semester_season` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev2`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev2`.`student` (
  `student_id` INT(11) NOT NULL AUTO_INCREMENT,
  `student_admission_date` DATE NULL DEFAULT NULL,
  `student_graduation_date` DATE NULL DEFAULT NULL,
  `student_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP(),
  `audit_user_id` INT(11) NOT NULL,
  `faculty_edited` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  PRIMARY KEY (`student_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev2`.`enrollment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev2`.`enrollment` (
  `enrollment_id` INT(11) NOT NULL AUTO_INCREMENT,
  `enrollment_status` VARCHAR(255) NULL DEFAULT NULL,
  `enrolment_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP(),
  `audit_user_id` INT(11) NOT NULL,
  `enrollment_audited` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  `student_student_id` INT(11) NOT NULL,
  `semester_id` INT(11) NOT NULL,
  `lookup_grade_id` INT(11) NOT NULL,
  PRIMARY KEY (`enrollment_id`),
  INDEX `fk_enrollment_student1_idx` (`student_student_id` ASC) VISIBLE,
  INDEX `fk_enrollment_semester1_idx` (`semester_id` ASC) VISIBLE,
  INDEX `fk_enrollment_lookup_grade1_idx` (`lookup_grade_id` ASC) VISIBLE,
  CONSTRAINT `fk_enrollment_lookup_grade1`
    FOREIGN KEY (`lookup_grade_id`)
    REFERENCES `af25nathm1_collegev2`.`lookup_grade` (`lookup_grade_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_enrollment_semester1`
    FOREIGN KEY (`semester_id`)
    REFERENCES `af25nathm1_collegev2`.`semester` (`semester_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_enrollment_student1`
    FOREIGN KEY (`student_student_id`)
    REFERENCES `af25nathm1_collegev2`.`student` (`student_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 5;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev2`.`section`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev2`.`section` (
  `section_id` INT(11) NOT NULL AUTO_INCREMENT,
  `section_days` VARCHAR(255) NULL DEFAULT NULL,
  `section_times` VARCHAR(255) NULL DEFAULT NULL,
  `section_delivery_method` VARCHAR(255) NULL DEFAULT NULL,
  `course_id` INT(11) NOT NULL,
  `employee_id` INT(11) NOT NULL,
  `student_id` INT(11) NOT NULL,
  PRIMARY KEY (`section_id`),
  INDEX `fk_section_course1_idx` (`course_id` ASC) VISIBLE,
  INDEX `fk_section_employee1_idx` (`employee_id` ASC) VISIBLE,
  INDEX `fk_section_student1_idx` (`student_id` ASC) VISIBLE,
  CONSTRAINT `fk_section_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `af25nathm1_collegev2`.`course` (`course_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_section_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `af25nathm1_collegev2`.`employee` (`employee_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_section_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `af25nathm1_collegev2`.`student` (`student_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 5;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev2`.`room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev2`.`room` (
  `room_id` INT(11) NOT NULL AUTO_INCREMENT,
  `room_name` VARCHAR(255) NULL DEFAULT NULL,
  `room_capacity` INT(11) NULL DEFAULT NULL,
  `room_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP(),
  `audit_user_id` INT(11) NOT NULL,
  `room_audited` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  `section_id` INT(11) NOT NULL,
  `student_id` INT(11) NOT NULL,
  `building_id` INT(11) NOT NULL,
  `employee_id` INT(11) NOT NULL,
  PRIMARY KEY (`room_id`),
  INDEX `fk_room_section1_idx` (`section_id` ASC) VISIBLE,
  INDEX `fk_room_student1_idx` (`student_id` ASC) VISIBLE,
  INDEX `fk_room_building1_idx` (`building_id` ASC) VISIBLE,
  INDEX `fk_room_employee1_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_room_building1`
    FOREIGN KEY (`building_id`)
    REFERENCES `af25nathm1_collegev2`.`building` (`building_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_room_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `af25nathm1_collegev2`.`employee` (`employee_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_room_section1`
    FOREIGN KEY (`section_id`)
    REFERENCES `af25nathm1_collegev2`.`section` (`section_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_room_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `af25nathm1_collegev2`.`student` (`student_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 5;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev2`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev2`.`user` (
  `user_id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_fname` VARCHAR(255) NULL DEFAULT NULL,
  `user_lname` VARCHAR(255) NULL DEFAULT NULL,
  `user_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP(),
  `audit_id` INT(11) NOT NULL,
  `user_audited` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  `employee_employee_id` INT(11) NULL DEFAULT NULL,
  `student_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  INDEX `fk_user_employee_idx` (`employee_employee_id` ASC) VISIBLE,
  INDEX `first_name` (`user_fname` ASC) VISIBLE,
  INDEX `last_name` (`user_lname` ASC) VISIBLE,
  INDEX `fk_user_student1_idx` (`student_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_employee`
    FOREIGN KEY (`employee_employee_id`)
    REFERENCES `af25nathm1_collegev2`.`employee` (`employee_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `af25nathm1_collegev2`.`student` (`student_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 5;


-- ========== Sample Data ==========

-- Audit users
INSERT INTO audit_user (username, password) VALUES
('admin1', 'pass1'),
('admin2', 'pass2'),
('admin3', 'pass3'),
('admin4', 'pass4');

-- Employees
INSERT INTO employee (first_name, last_name, audit_user_id) VALUES
('John', 'Doe', 1),
('Jane', 'Smith', 2),
('Alan', 'Turing', 3),
('Grace', 'Hopper', 4);

-- Departments (IDs auto-generated now)
INSERT INTO department (department_name, audit_user_id, employee_id) VALUES
('Computer Science', 1, 1),
('Mathematics', 2, 2),
('History', 3, 3),
('Business Administration', 4, 4);

-- Courses
INSERT INTO course (course_name, department_id) VALUES
('Intro to CS', 1),
('Algorithms', 1),
('Calculus I', 2),
('World History', 3),
('Business Ethics', 4);

-- Semesters
INSERT INTO semester (semester_name, year) VALUES
('Fall', 2025),
('Spring', 2026);

-- Students
INSERT INTO student (first_name, last_name, audit_user_id) VALUES
('Alice', 'Brown', 1),
('Bob', 'White', 2),
('Charlie', 'Green', 3),
('Diana', 'Black', 4);

-- Enrollments
INSERT INTO enrollment (student_id, course_id, semester_id) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 2),
(4, 4, 2),
(1, 5, 1);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
