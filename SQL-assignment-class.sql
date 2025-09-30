create database sportswear;
use database sportswear;

CREATE TABLE color (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    extra_fee DECIMAL(10,2)
);

INSERT INTO color (id, name, extra_fee) VALUES
(1, 'Red', 10.00),
(2, 'Blue', 12.50),
(3, 'Green', 15.00),
(4, 'Black', 8.00),
(5, 'White', 5.50);

CREATE TABLE customer (
    id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    favorite_color_id INT,
    FOREIGN KEY(favorite_color_id) REFERENCES color(id)
);

INSERT INTO customer (id, first_name, last_name, favorite_color_id) VALUES
(1, 'Sara', 'Ahmed', 2),
(2, 'Omar', 'Malik', 3),
(3, 'Ali', 'Khan', 1),
(4, 'Ayesha', 'Farooq', 4),
(5, 'Bilal', 'Shah', 5);


CREATE TABLE category (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    parent_id INT NULL,
    FOREIGN KEY(parent_id) REFERENCES category(id)
);

INSERT INTO category (id, name, parent_id) VALUES
(1, 'Tops', NULL),
(2, 'Bottoms', NULL),
(3, 'T-Shirts', 1),
(4, 'Jeans', 2),
(5, 'Jackets', 1);


CREATE TABLE clothing (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    size VARCHAR(10),
    price DECIMAL(10,2),
    color_id INT,
    category_id INT,
    FOREIGN KEY(color_id) REFERENCES color(id),
    FOREIGN KEY(category_id) REFERENCES category(id)
);

INSERT INTO clothing (id, name, size, price, color_id, category_id) VALUES
(1, 'Jeans', 'M', 45.00, 2, 4),
(2, 'Jacket', 'L', 80.00, 3, 5),
(3, 'T-Shirt', 'S', 20.00, 1, 3),
(4, 'Hoodie', 'XL', 60.00, 4, 5),
(5, 'Shorts', 'M', 25.00, 5, 2);


CREATE TABLE clothing_order (
    id INT PRIMARY KEY,
    customer_id INT,
    clothing_id INT,
    items INT,
    order_date DATE,
    FOREIGN KEY(customer_id) REFERENCES customer(id),
    FOREIGN KEY(clothing_id) REFERENCES clothing(id)
);

INSERT INTO clothing_order (id, customer_id, clothing_id, items, order_date) VALUES
(1, 1, 1, 1, '2025-09-01'),
(2, 2, 2, 2, '2025-09-02'),
(3, 3, 3, 1, '2025-09-03'),
(4, 1, 4, 1, '2025-09-05'),
(5, 5, 5, 3, '2025-09-06');



SELECT 
    clothing.name AS clothes,
    color.name AS color,
    customer.last_name,
    customer.first_name
FROM clothing
JOIN color 
    ON clothing.color_id = color.id
JOIN clothing_order
    ON clothing.id = clothing_order.clothing_id
JOIN customer
    ON clothing_order.customer_id = customer.id
WHERE customer.favourite_color_id = color.id
ORDER BY color.name ASC;

SELECT 
    c.first_name,
	c.last_name,
    col.name AS favourite_color
FROM customer c
LEFT JOIN clothing_order o
    ON c.id = o.customer_id
LEFT JOIN color col
    ON c.favourite_color_id = col.id
WHERE o.id IS NULL;


SELECT 
    main.name AS category,
    sub.name AS subcategory
FROM category main
LEFT JOIN category sub
    ON sub.parent_id = main.id
WHERE main.parent_id IS NULL;


create database sportsclub;
use sportsclub;

CREATE TABLE runner (
    id INT PRIMARY KEY,
    name VARCHAR(225),
    main_distance DECIMAL(10,2),
    age INT,
    is_female BIT
);



CREATE TABLE event (
    id INT PRIMARY KEY,
    name VARCHAR(225),
    start_date DATE,
    city VARCHAR(225)
);

CREATE TABLE runner_event (
    runner_id INT,
    event_id INT,
    PRIMARY KEY (runner_id, event_id),
    FOREIGN KEY (runner_id) REFERENCES runner(id),
    FOREIGN KEY (event_id) REFERENCES event(id)
);


INSERT INTO runner (id, name, main_distance, age, is_female)
VALUES 
(1, 'Ali Khan', 5000, 25, 0),   
(2, 'Sara Malik', 10000, 28, 1), 
(3, 'Omar Sheikh', 1500, 22, 0),
(4, 'Ayesha Noor', 5000, 30, 1),
(5, 'Hassan Raza', 10000, 35, 0);


INSERT INTO event (id, name, start_date, city)
VALUES
(1, 'Karachi Marathon', '2025-01-15', 'Karachi'),
(2, 'Lahore Half Marathon', '2025-02-10', 'Lahore'),
(3, 'Islamabad Run', '2025-03-05', 'Islamabad');



INSERT INTO runner_event (runner_id, event_id)
VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 3),
(5, 2),
(2, 3);

SELECT 
    main_distance,
    COUNT(*) AS runners_number
FROM runner
GROUP BY main_distance
HAVING COUNT(*) > 3;


INSERT INTO runner (id, name, main_distance, age, is_female)
VALUES
(6, 'Bilal Ahmed', 5000, 27, 0),
(7, 'Nida Fatima', 5000, 29, 1);



SELECT 
    e.name AS event_name,
    COUNT(re.runner_id) AS runner_count
FROM event e
LEFT JOIN runner_event re ON e.id = re.event_id
GROUP BY e.name;

SELECT 
    main_distance,
    SUM(CASE WHEN age < 20 THEN 1 ELSE 0 END) AS under_20,
    SUM(CASE WHEN age BETWEEN 20 AND 29 THEN 1 ELSE 0 END) AS age_20_29,
    SUM(CASE WHEN age BETWEEN 30 AND 39 THEN 1 ELSE 0 END) AS age_30_39,
    SUM(CASE WHEN age BETWEEN 40 AND 49 THEN 1 ELSE 0 END) AS age_40_49,
    SUM(CASE WHEN age >= 50 THEN 1 ELSE 0 END) AS over_50
FROM runner
GROUP BY main_distance;


create database Northwind
use Northwind


CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    email VARCHAR(225),
    full_name VARCHAR(225),
    address VARCHAR(225),
    city VARCHAR(225),
    region VARCHAR(225),
    postal_code VARCHAR(20),
    country VARCHAR(225),
    phone VARCHAR(25),
    registration_date DATE,
    channel_id INT,
    first_order_id INT,
    first_order_date DATE,
    last_order_id INT,
    last_order_date DATE,
    FOREIGN KEY (channel_id) REFERENCES channels(id)
);


CREATE TABLE channels (
    id INT PRIMARY KEY,
    channel_name VARCHAR(225) NOT NULL
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    ship_name VARCHAR(225),
    ship_address VARCHAR(225),
    ship_city VARCHAR(225),
    ship_region VARCHAR(225),
    ship_postalcode VARCHAR(20),
    ship_country VARCHAR(225),
    shipped_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(225),
    category_id INT,
    unit_price DECIMAL(10,2),
    discontinued BIT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(225) NOT NULL,
    description VARCHAR(500)
);


CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    discount DECIMAL(5,2) DEFAULT 0,  
    PRIMARY KEY (order_id, product_id), 
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


INSERT INTO channels (id, channel_name) VALUES
(1, 'Website'),
(2, 'Mobile App'),
(3, 'Phone'),
(4, 'Email'),
(5, 'Retail Store');


INSERT INTO customers (
    customer_id, email, full_name, address, city, region, postal_code,
    country, phone, registration_date, channel_id,
    first_order_id, first_order_date, last_order_id, last_order_date
) VALUES
(1, 'ali@example.com', 'Ali Khan', '123 Main St', 'Karachi', 'Sindh', '75000', 'Pakistan', '03001234567', '2023-01-10', 1, 101, '2023-01-15', 105, '2023-03-20'),
(2, 'sara@example.com', 'Sara Malik', '45 Street 9', 'Lahore', 'Punjab', '54000', 'Pakistan', '03007654321', '2023-02-05', 2, 102, '2023-02-10', 106, '2023-04-05'),
(3, 'john@example.com', 'John Doe', '78 Elm St', 'London', NULL, 'E1 6AN', 'UK', '441234567890', '2023-03-01', 3, NULL, NULL, NULL, NULL);

INSERT INTO categories (category_id, category_name, description) VALUES
(1, 'Beverages', 'Soft drinks, coffees, teas, beers, and ales'),
(2, 'Condiments', 'Sweet and savory sauces, relishes, spreads, and seasonings'),
(3, 'Confections', 'Desserts, candies, and sweet breads');


INSERT INTO products (product_id, product_name, category_id, unit_price, discontinued) VALUES
(1, 'Chai', 1, 18.00, 0),
(2, 'Chang', 1, 19.00, 0),
(3, 'Aniseed Syrup', 2, 10.00, 0),
(4, 'Chef Anton\'s Cajun Seasoning', 2, 22.00, 0),
(5, 'Chocolate Biscuits', 3, 12.50, 1);


INSERT INTO orders (
    order_id, customer_id, order_date, total_amount,
    ship_name, ship_address, ship_city, ship_region,
    ship_postalcode, ship_country, shipped_date
) VALUES
(101, 1, '2023-01-15', 50.00, 'Ali Khan', '123 Main St', 'Karachi', 'Sindh', '75000', 'Pakistan', '2023-01-20'),
(102, 2, '2023-02-10', 75.00, 'Sara Malik', '45 Street 9', 'Lahore', 'Punjab', '54000', 'Pakistan', '2023-02-15'),
(103, 1, '2023-03-05', 40.00, 'Ali Khan', '123 Main St', 'Karachi', 'Sindh', '75000', 'Pakistan', '2023-03-10'),
(104, 3, '2023-04-01', 60.00, 'John Doe', '78 Elm St', 'London', NULL, 'E1 6AN', 'UK', '2023-04-05');



INSERT INTO order_items (order_id, product_id, unit_price, quantity, discount) VALUES
(101, 1, 18.00, 2, 0),
(101, 3, 10.00, 1, 0),
(102, 2, 19.00, 3, 0.05),
(103, 4, 22.00, 2, 0),
(104, 5, 12.50, 5, 0.10);

INSERT INTO products (product_id, product_name, category_id, unit_price, discontinued) VALUES
(1, 'Chai', 1, 18.00, 0),
(2, 'Chang', 1, 19.00, 0),
(3, 'Aniseed Syrup', 2, 10.00, 0),
(4, 'Chef Anton''s Cajun Seasoning', 2, 22.00, 0),
(5, 'Chocolate Biscuits', 3, 12.50, 1);


WITH RankedOrders AS (
    SELECT 
        customer_id,       
        total_amount,
        order_date,
        DENSE_RANK() OVER (ORDER BY total_amount DESC, order_date ASC) AS rank
    FROM orders
)
SELECT 
    rank,
    customer_id,
    total_amount,
    order_date
FROM RankedOrders
WHERE rank <= 3
ORDER BY rank, order_date;




SELECT
    customer_id,
    order_date,
    total_amount,
    LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_value,
    total_amount - LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS delta
FROM orders
ORDER BY customer_id, order_date;

SELECT
    o.customer_id,
    c.full_name,
    o.order_id,
    o.order_date,
    o.total_amount,
    SUM(o.total_amount) OVER (PARTITION BY o.customer_id ORDER BY o.order_date 
                              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.customer_id, o.order_date;
