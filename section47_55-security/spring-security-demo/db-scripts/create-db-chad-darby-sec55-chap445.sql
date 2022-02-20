DROP DATABASE  IF EXISTS `chad_security_demo-bcrypt-db`;

CREATE DATABASE  IF NOT EXISTS `chad_security_demo-bcrypt-db`;
USE `chad_security_demo-bcrypt-db`;

-- 
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `username` varchar(50) NOT NULL,
  `password` varchar(68) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Inserting data for table `users`
--

INSERT INTO `users` 
VALUES 
('John','{bcrypt}$2a$10$wkDc7pUGmONKaGps74edlO1/d0gorXMO3qNYZo1fj7tZwIok1T.C.',1),
('Mary','{bcrypt}$2a$10$k/Yy6lbxeQuHHg9j/H9/He3dnN6BMDwFWcrSEu/WHSYZjct1WIEEC',1),
('Susan','{bcrypt}$2a$10$GEUNyc32LMsqk5/8JfvzQ.aRFR98hWsXMfA6089rAY8DeeUULlJlS',1);


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
CREATE ROUTINE, ALTER ROUTINE, event, TRIGGER ON `chad_security_demo-bcrypt-db`.* TO `chadadmin`@`%`;
CREATE USER IF NOT EXISTS `springuser`@`%` IDENTIFIED WITH mysql_native_password by 'springuser';
GRANT SELECT, INSERT, UPDATE, DELETE, SHOW VIEW ON `chad_security_demo-bcrypt-db`.* TO `springuser`@`%`;
FLUSH PRIVILEGES;



