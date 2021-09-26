Assignment #12


This assignment will focus on your abilities to read requirements and turn them into a good database design.


Be sure to use the knowledge you’ve gain from normalization and relationships (1-to-1, 1-to-many, many-to-many)


I’d suggest using something like MS Excel or Google Spreadsheet to create the outline for your schema.


Q1: You’ll need to create the database schema for a new pizza restaurant.

The pizza restaurant needs a database that will allow them to keep track of incoming orders from customers.
When a customer places an order, they are able to request as many pizzas as they like.
They can choose from 4 different types of pizzas:


1.       Pepperoni & Cheese (7.99)

2.       Vegetarian (9.99)

3.       Meat Lovers (14.99)

4.       Hawaiian (12.99)


Customers are able to place as many individual orders as they like
(meaning they can order pizza again on the same day, or on any other day)


You’ll need to keep track of the customer’s name and phone number when they do place an order.


You’ll need to keep track of the date/time that the order came in for every customer order.


Hints to complete this database design are on the last page of this assignment. If you need help,
you can take a look.


Q2: Create your database based on your design in MySQL

Use your database design (done in MS Excel or Google Spreadsheet) and create it with a MySQL script.
What I mean by create it with a MySQL script is to just put all the SQL commands in a single .SQL file.


For bonus points, make the script re-runnable using the “IF EXISTS” tricks you learned last week.


Q3: Populate your database with three orders

Now that you’ve created your database in MySQL, it’s time to populate it with values. Create three
separate orders with these values:



Order #1:


Customer: Trevor Page

Phone number: 226-555-4982

Order date/time: 9/10/2014 9:47:00 AM

Pizza Order: 1x Pepperoni & Cheese Pizza, 1x Meat Lovers Pizza

1.       Pepperoni & Cheese (7.99)

2.       Vegetarian (9.99)

3.       Meat Lovers (14.99)

4.       Hawaiian (12.99)

Order #2:


Customer: John Doe

Phone number: 555-555-9498

Order date/time: 9/10/2014 13:20:00 AM

Pizza Order: 1x Vegetarian Pizza, 2x Meat Lovers Pizza



Order #3:


Customer: Trevor Page

Phone number: 226-555-4982

Order date/time: 9/10/2014 9:47:00 AM

Pizza Order: 1x Meat Lovers Pizza, 1x Hawaiian Pizza


Q4: Now the restaurant would like to know which customers are spending the most money at their
establishment. Write a SQL query which will tell them how much money each individual customer
has spent at their restaurant

Q5: Modify the query from Q4 to separate the orders not just by customer, but also by date so
they can see how much each customer is ordering on which date.


HINTS

Database Design hints:

The database designs can vary a bit, but here’s the general guidelines you should follow when
designing your database.


First identify all the tables that should be in the database… when I did this, I came up with
three different tables… Let’s just call them Tables A, B and C


Then identify what the relationships are between those tables… when I did this, I discovered
that there were two different Many-to-Many relationships.


Since I was using Many-to-Many relationships, this would mean I’d need to create a join table
for each of the two relationships… so I ended up with 5 tables in my database schema.


1.  Table A

2.  Table B

3.  Table A_B

4.  Table C

5.  Table B_C


Note: Tables 3 and 5 are the join tables

