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

-- -----------------------------------------------------
-- BULK SAMPLE DATA (For Stress Testing)
-- -----------------------------------------------------

-- Extra Departments
INSERT INTO department (department_id, department_name, audit_user_id, employee_id) VALUES
(401, 'Psychology', 1, 21),
(402, 'Chemistry', 2, 22),
(403, 'Physics', 3, 23),
(404, 'Economics', 4, 24),
(405, 'Anthropology', 1, 25),
(406, 'Geography', 2, 26),
(407, 'Statistics', 3, 27),
(408, 'Linguistics', 4, 28),
(409, 'Biotechnology', 1, 29),
(410, 'Law', 2, 30);

-- Extra Employees
INSERT INTO employee (employee_start_date, employee_end_date, audit_user_id, lookup_employee_role_id) VALUES
('2010-08-15', NULL, 1, 1), -- id 21
('2012-09-01', NULL, 2, 2), -- id 22
('2015-01-05', NULL, 3, 3), -- id 23
('2011-06-20', NULL, 4, 4), -- id 24
('2013-03-18', NULL, 1, 5), -- id 25
('2014-04-25', NULL, 2, 6), -- id 26
('2017-07-10', NULL, 3, 7), -- id 27
('2018-02-28', NULL, 4, 8), -- id 28
('2016-10-12', NULL, 1, 2), -- id 29
('2020-05-19', NULL, 2, 3); -- id 30

-- Extra Students
INSERT INTO student (student_admission_date, student_graduation_date, audit_user_id) VALUES
('2020-09-01', NULL, 1),
('2021-01-10', NULL, 2),
('2019-08-20', '2023-05-15', 3),
('2022-02-01', NULL, 4),
('2018-08-25', '2022-05-20', 1),
('2025-01-10', NULL, 2),
('2025-08-21', NULL, 3),
('2017-09-01', '2021-05-10', 4),
('2019-01-15', '2023-05-25', 1),
('2023-09-01', NULL, 2),
('2022-09-01', NULL, 3),
('2021-08-25', NULL, 4),
('2020-09-05', '2024-05-15', 1),
('2016-08-30', '2020-05-15', 2),
('2018-09-01', '2022-05-15', 3),
('2019-09-01', NULL, 4),
('2024-01-10', NULL, 1),
('2025-01-20', NULL, 2),
('2023-08-30', NULL, 3),
('2022-01-10', NULL, 4);

-- Extra Courses
INSERT INTO course (course_name, course_credit_hours, audit_user_id) VALUES
('Cognitive Psychology', 3, 1),
('Organic Chemistry', 4, 2),
('Quantum Physics', 4, 3),
('Microeconomics', 3, 4),
('Cultural Anthropology', 3, 1),
('GIS Mapping', 3, 2),
('Applied Statistics', 4, 3),
('Phonetics', 3, 4),
('Genetic Engineering', 4, 1),
('Business Law', 3, 2),
('Clinical Psychology', 4, 3),
('Physical Chemistry', 4, 4),
('Astrophysics', 4, 1),
('Macroeconomics', 3, 2),
('Archaeology', 3, 3),
('Urban Geography', 3, 4),
('Probability Theory', 4, 1),
('Syntax and Semantics', 3, 2),
('Molecular Biology', 4, 3),
('Constitutional Law', 3, 4);

-- Extra Semesters
INSERT INTO semester (semester_id, semester_season, audit_user_id) VALUES
(8, 'Spring 2027', 1),
(9, 'Fall 2027', 2),
(10, 'Spring 2028', 3),
(11, 'Fall 2028', 4),
(12, 'Spring 2029', 1),
(13, 'Fall 2029', 2),
(14, 'Spring 2030', 3),
(15, 'Fall 2030', 4),
(16, 'Spring 2031', 1),
(17, 'Fall 2031', 2);

-- Extra Enrollments (students 21-40 mapped into semesters 8-17)
INSERT INTO enrollment (enrollment_status, audit_user_id, student_student_id, semester_id, lookup_grade_id) VALUES
('Active', 1, 21, 8, 1),
('Completed', 2, 22, 8, 2),
('Active', 3, 23, 9, 3),
('Withdrawn', 4, 24, 9, 5),
('Active', 1, 25, 10, 1),
('Completed', 2, 26, 10, 2),
('Active', 3, 27, 11, 4),
('Active', 4, 28, 11, 3),
('Completed', 1, 29, 12, 2),
('Completed', 2, 30, 12, 1),
('Withdrawn', 3, 31, 13, 5),
('Active', 4, 32, 13, 3),
('Completed', 1, 33, 14, 2),
('Active', 2, 34, 14, 1),
('Completed', 3, 35, 15, 2),
('Active', 4, 36, 15, 3),
('Withdrawn', 1, 37, 16, 5),
('Completed', 2, 38, 16, 2),
('Active', 3, 39, 17, 1),
('Completed', 4, 40, 17, 2);

-- Extra Sections
INSERT INTO section (section_days, section_times, section_delivery_method, course_id, employee_id, student_id) VALUES
('MWF', '08:00-08:50', 'In-Person', 21, 21, 21),
('TTh', '09:30-10:45', 'Online', 22, 22, 22),
('MWF', '11:00-11:50', 'Hybrid', 23, 23, 23),
('TTh', '13:00-14:15', 'In-Person', 24, 24, 24),
('MWF', '14:00-14:50', 'Online', 25, 25, 25),
('TTh', '15:30-16:45', 'In-Person', 26, 26, 26),
('MWF', '16:00-16:50', 'In-Person', 27, 27, 27),
('TTh', '10:00-11:15', 'Hybrid', 28, 28, 28),
('MWF', '09:00-09:50', 'Online', 29, 29, 29),
('TTh', '14:00-15:15', 'In-Person', 30, 30, 30);

-- Extra Rooms
INSERT INTO building (building_name, building_room_number, building_room_capacity) VALUES
('Psychology Hall', 101, 60),
('Chemistry Center', 202, 100),
('Physics Tower', 303, 120),
('Economics Building', 404, 90),
('Anthropology Annex', 505, 50),
('Geography Center', 606, 70),
('Statistics Hall', 707, 80),
('Linguistics Block', 808, 40),
('Biotech Lab', 909, 30),
('Law Building', 1001, 150);

INSERT INTO room (room_name, room_capacity, audit_user_id, section_id, student_id, building_id, employee_id) VALUES
('Psych 101A', 60, 1, 21, 21, 401, 21),
('Chem 202B', 100, 2, 22, 22, 402, 22),
('Phys 303C', 120, 3, 23, 23, 403, 23),
('Econ 404D', 90, 4, 24, 24, 404, 24),
('Anthro 505E', 50, 1, 25, 25, 405, 25),
('Geo 606F', 70, 2, 26, 26, 406, 26),
('Stats 707G', 80, 3, 27, 27, 407, 27),
('Ling 808H', 40, 4, 28, 28, 408, 28),
('Biotech 909I', 30, 1, 29, 29, 409, 29),
('Law 1001J', 150, 2, 30, 30, 410, 30);

-- Extra Course-Department Links
INSERT INTO course_has_department (department_id, course_id) VALUES
(401, 21),
(402, 22),
(403, 23),
(404, 24),
(405, 25),
(406, 26),
(407, 27),
(408, 28),
(409, 29),
(410, 30);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
