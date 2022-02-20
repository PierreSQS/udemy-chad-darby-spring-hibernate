DROP DATABASE  IF EXISTS `chad_security_demo-db`;

CREATE DATABASE  IF NOT EXISTS `chad_security_demo-db`;
USE `chad_security_demo-db`;

-- 
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Inserting data for table `users`
--

INSERT INTO `users` 
VALUES 
('John','{noop}John',1),
('Mary','{noop}Mary',1),
('Susan','{noop}Susan',1);


--
-- Table structure for table `authorities`
--

DROP TABLE IF EXISTS `authorities`;
CREATE TABLE `authorities` (
  `username` varchar(50) NOT NULL,
  `authority` varchar(50) NOT NULL,
  UNIQUE KEY `authorities_idx_1` (`username`,`authority`),
  CONSTRAINT `authorities_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Inserting data for table `authorities`
--

INSERT INTO `authorities` 
VALUES 
('John','ROLE_EMPLOYEE'),
('Mary','ROLE_EMPLOYEE'),
('Mary','ROLE_MANAGER'),
('Susan','ROLE_EMPLOYEE'),
('Susan','ROLE_ADMIN');

CREATE USER IF NOT EXISTS `chadadmin`@`%` IDENTIFIED WITH mysql_native_password BY 'chadadmin';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, REFERENCES, INDEX, ALTER, EXECUTE, CREATE VIEW, SHOW VIEW,
CREATE ROUTINE, ALTER ROUTINE, event, TRIGGER ON `chad_security_demo-db`.* TO `chadadmin`@`%`;
CREATE USER IF NOT EXISTS `springuser`@`%` IDENTIFIED WITH mysql_native_password by 'springuser';
GRANT SELECT, INSERT, UPDATE, DELETE, SHOW VIEW ON `chad_security_demo-db`.* TO `springuser`@`%`;
FLUSH PRIVILEGES;
