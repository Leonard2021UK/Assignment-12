#Q2: Create your database based on your design in MySQL

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `db` ;

-- -----------------------------------------------------
-- Table `db`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db`.`customers` (
  `idcustomers` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `phoneNr` VARCHAR(45) NULL DEFAULT NULL,
  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idcustomers`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db`.`orders` (
  `idorders` INT NOT NULL AUTO_INCREMENT,
  `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `orderDate` DATETIME NOT NULL,
  `customers_idcustomers` INT NOT NULL,
  PRIMARY KEY (`idorders`),
  INDEX `fk_orders_customers1_idx` (`customers_idcustomers` ASC) VISIBLE,
  CONSTRAINT `fk_orders_customers1`
    FOREIGN KEY (`customers_idcustomers`)
    REFERENCES `db`.`customers` (`idcustomers`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db`.`pizzas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db`.`pizzas` (
  `idpizzas` INT NOT NULL AUTO_INCREMENT,
  `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `price` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`idpizzas`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db`.`orders_has_pizzas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db`.`orders_has_pizzas` (
  `orders_idorders` INT NOT NULL,
  `pizzas_idpizzas` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`orders_idorders`, `pizzas_idpizzas`),
  INDEX `fk_orders_has_pizzas_pizzas1_idx` (`pizzas_idpizzas` ASC) VISIBLE,
  INDEX `fk_orders_has_pizzas_orders1_idx` (`orders_idorders` ASC) VISIBLE,
  CONSTRAINT `fk_orders_has_pizzas_orders1`
    FOREIGN KEY (`orders_idorders`)
    REFERENCES `db`.`orders` (`idorders`),
  CONSTRAINT `fk_orders_has_pizzas_pizzas1`
    FOREIGN KEY (`pizzas_idpizzas`)
    REFERENCES `db`.`pizzas` (`idpizzas`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

#RESETS AUTO INCREMENTS FOR EVERY TABLE
# IT ALLOWS INSERTIONS TO WORK MULTIPLE TIMES
ALTER TABLE db.pizzas AUTO_INCREMENT = 1;
ALTER TABLE db.customers AUTO_INCREMENT = 1;
ALTER TABLE db.orders AUTO_INCREMENT = 1;
ALTER TABLE db.orders_has_pizzas AUTO_INCREMENT = 1;

# Q3: Populate your database with three orders
#PIZZAS
INSERT INTO db.pizzas (createdAt, name, price)
VALUES ('2021-09-26 15:32:22', 'Pepperoni & Cheese', 7.99),
       ('2021-09-26 15:33:56', 'Vegetarian', 9.99),
       ('2021-09-26 15:33:58', 'Meat Lovers', 14.99),
       ('2021-09-26 15:33:59', 'Hawaiian', 12.99);

#ADD CUSTOMERS
INSERT INTO db.customers (name, phoneNr, createdAt)
VALUES ('Trevor Page', '226-555-4982', '2021-09-26 15:41:00'),
       ('John Doe', '555-555-9498', '2021-09-26 15:42:17'),
       ('Trevor Page', '226-555-4982', '2021-09-26 15:42:19');

#ADD ORDERS
INSERT INTO db.orders (createdAt, orderDate, customers_idcustomers)
VALUES ('2021-09-26 15:39:04', '2014-10-09 09:47:00', 1),
       ('2021-09-26 15:44:53', '2014-10-09 13:20:00', 2),
       ('2021-09-26 15:46:37', '2014-10-09 09:47:00', 1);

#ADD ORDERS AND PIZZAS
INSERT INTO db.orders_has_pizzas (orders_idorders, pizzas_idpizzas, quantity)
VALUES (1, 1, 1),(1, 3, 1),(2, 2, 1),(2, 3, 2),(3, 3, 1),(3, 4, 1);

# Q4: Now the restaurant would like to know which customers are spending the most money at their
# establishment. Write a SQL query which will tell them how much money each individual customer
# has spent at their restaurant
SELECT c.name, SUM(p.price * op.quantity) as total FROM db.pizzas p
    JOIN db.orders_has_pizzas op ON p.idpizzas = op.pizzas_idpizzas
        JOIN db.orders o ON o.idorders = op.orders_idorders
            JOIN db.customers c ON c.idcustomers = c.idcustomers
WHERE o.customers_idcustomers = c.idcustomers
GROUP BY c.name;

# Q5: Modify the query from Q4 to separate the orders not just by customer, but also by date so
# they can see how much each customer is ordering on which date.
SELECT c.name,o.orderDate, SUM(p.price * op.quantity) as total FROM db.pizzas p
    JOIN db.orders_has_pizzas op ON p.idpizzas = op.pizzas_idpizzas
        JOIN db.orders o ON o.idorders = op.orders_idorders
            JOIN db.customers c ON c.idcustomers = c.idcustomers
WHERE o.customers_idcustomers = c.idcustomers
GROUP BY o.orderDate, c.name
ORDER BY c.name;
