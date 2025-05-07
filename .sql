-- Membuat databases ecommerce

CREATE DATABASE ecommerce_db;
USE ecommerce_db;

-- Tabel Users
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    role ENUM('customer', 'admin') DEFAULT 'customer'
);

-- Tabel Categories
CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

-- Tabel Products
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL,
    category_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE SET NULL
);

-- Tabel Cart
CREATE TABLE Cart (
    cart_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Tabel Cart_Items
CREATE TABLE Cart_Items (
    cart_item_id INT PRIMARY KEY AUTO_INCREMENT,
    cart_id INT,
    product_id INT, 
    quantity INT NOT NULL,
    FOREIGN KEY (cart_id) REFERENCES Cart(cart_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);

-- Tabel Orders
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pending', 'shipped', 'delivered', 'canceled') DEFAULT 'pending',
    total_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Tabel Order_Items
CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);

-- Tabel Reviews
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    product_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);

-- Data Users
INSERT INTO Users (name, email, password, phone, address, role) VALUES
('Arman', 'arman@gmail.com', 'password123', '08123456789', 'Aceh, Indonesia', 'admin'),
('Arir', 'arir@gmail.com', 'password123', '08123456789', 'Kalimantan, Indonesia', 'admin'),
('Username', 'gmail@gmail.com', 'password', '08234567890', 'Jakarta, Indonesia', 'customer'),
('Username', 'gmail@gmail.com', 'password', '08345678901', 'Bandung, Indonesia', 'customer');

-- Data Categories
INSERT INTO Categories (name) VALUES
('Elektronik'),
('Fashion'),   
('Makanan & Minuman'),
('Peralatan Rumah Tangga');

-- Data Products
INSERT INTO Products (name, description, price, stock_quantity, category_id, created_at, updated_at) VALUES
('Laptop Gaming ASUS', 'Laptop gaming dengan spek tinggi', 15000000, 10, 1, NOW(), NOW()),
('Kaos Polos Hitam', 'Kaos polos bahan katun', 75000, 50, 2, NOW(), NOW()),
('Kopi Aceh Gayo', 'Kopi asli Aceh berkualitas', 120000, 30, 3, NOW(), NOW()),
('Blender Philips', 'Blender serbaguna dengan kapasitas besar', 500000, 20, 4, NOW(), NOW());

-- Data Cart
INSERT INTO Cart (user_id, created_at) VALUES
(2, NOW()),
(3, NOW());

-- Data Cart_Items
INSERT INTO Cart_Items (cart_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 3, 2),
(2, 2, 3);

-- Data Orders
INSERT INTO Orders (user_id, order_date, status, total_price) VALUES
(2, NOW(), 'pending', 15120000),
(3, NOW(), 'completed', 225000);

-- Data Order_Items
INSERT INTO Order_Items (order_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 3, 2),
(2, 2, 3);

-- Data Reviews
INSERT INTO Reviews (user_id, product_id, rating, comment, created_at) VALUES
(2, 1, 5, 'Laptopnya mantap!', NOW()),
(3, 2, 4, 'Kaosnya nyaman dipakai.', NOW()),
(2, 3, 5, 'Kopi terbaik yang pernah saya coba!', NOW());

-- Select Table Databases
Select * from Nama_table;

-- Update Table Users
UPDATE Users
SET name = 'Tibet',
    email = 'tibet@gmail.com',
    phone = '08999888777',
    role = 'admin'
WHERE user_id = 2;


-- Kode Hapus Database
DROP DATABASE ecommerce_db;
