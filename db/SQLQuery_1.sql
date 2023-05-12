
use master;
DROP DATABASE jewelry_store;
GO
CREATE DATABASE jewelry_store;
GO
USE jewelry_store;
GO

CREATE TABLE Categories (
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
);
GO
CREATE TABLE Brands (
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
);
GO

CREATE TABLE Promotions (
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    start_date DATE NOT NULL,
	discount DECIMAL(10, 2) NOT NULL,
    end_date DATE NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
);
GO

CREATE TABLE Products(
    id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(255),
    description TEXT,
    price DECIMAL(10, 2),
    image_url NVARCHAR(255),
    category_id INT,
    brand_id INT,
    promotion_id INT,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (category_id) REFERENCES Categories(id),
    FOREIGN KEY (brand_id) REFERENCES Brands(id),
    FOREIGN KEY (promotion_id) REFERENCES Promotions(id)
);
GO

CREATE TABLE Accounts (
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
);
GO
CREATE TABLE Materials (
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
);
GO
CREATE TABLE Orders (
    id INT PRIMARY KEY IDENTITY(1,1),
    account_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_carts_accounts FOREIGN KEY (account_id) REFERENCES Accounts(id)
);
GO
CREATE TABLE Order_Details (
    id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (order_id) REFERENCES Orders(id),
    FOREIGN KEY (product_id) REFERENCES Products(id)
);
GO

CREATE TABLE promotion_product (
    promotion_id INT NOT NULL,
    product_id INT NOT NULL,
    PRIMARY KEY (promotion_id, product_id),
    FOREIGN KEY (promotion_id) REFERENCES promotions(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);
GO
CREATE TABLE Carts (
    id INT PRIMARY KEY IDENTITY(1,1),
    account_id INT NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (account_id) REFERENCES Accounts(id)
);
GO
CREATE TABLE Cart_Details (
    id INT PRIMARY KEY IDENTITY(1,1),
    cart_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (cart_id) REFERENCES Carts(id),
    FOREIGN KEY (product_id) REFERENCES Products(id)
);
GO
CREATE TABLE News (
    id INT PRIMARY KEY IDENTITY(1,1),
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    image VARCHAR(255),
    author VARCHAR(255),
    published_date DATE NOT NULL,
);
GO

INSERT INTO Categories (name, description) VALUES
('Electronics', 'Electronic devices and accessories'),
('Home & Kitchen', 'Kitchenware, bedding, and home appliances'),
('Clothing', 'Clothing and apparel'),
('Toys & Games', 'Toys, board games, and puzzles'),
('Sports & Outdoors', 'Sporting goods and outdoor gear'),
('Beauty & Personal Care', 'Beauty products and personal care items'),
('Books', 'Books and other printed materials'),
('Pet Supplies', 'Pet food and supplies'),
('Automotive', 'Auto parts and accessories'),
('Food & Beverages', 'Food and beverages');
GO

INSERT INTO Brands (name, description) VALUES
('Samsung', 'South Korean multinational conglomerate'),
('Apple', 'American multinational technology company'),
('LG', 'South Korean electronics company'),
('Sony', 'Japanese multinational conglomerate'),
('Nike', 'American multinational corporation'),
('Adidas', 'German multinational corporation'),
('Puma', 'German multinational corporation'),
('Coca-Cola', 'American multinational beverage corporation'),
('PepsiCo', 'American multinational food and beverage corporation'),
('Toyota', 'Japanese multinational automotive manufacturer');
GO

INSERT INTO Promotions (name, description, start_date, discount, end_date) VALUES
('Summer Sale', 'Save up to 50% on all products', '2023-06-01', 50, '2023-06-30'),
('Back to School', 'Get ready for school with our discounts', '2023-08-01', 25, '2023-08-31'),
('Black Friday', 'The biggest sale of the year', '2023-11-24', 70, '2023-11-27'),
('Christmas Sale', 'Shop for the perfect gifts and save', '2023-12-01', 40, '2023-12-31'),
('New Year Sale', 'Start the new year with new products and discounts', '2024-01-01', 30, '2024-01-15'),
('Valentine''s Day Sale', 'Celebrate love with our discounts', '2024-02-01', 20, '2024-02-14'),
('Easter Sale', 'Hop into savings with our Easter discounts', '2024-03-15', 15, '2024-04-15'),
('Summer Clearance', 'Clear out summer inventory with our discounts', '2024-07-01', 60, '2024-07-31'),
('Labor Day Sale', 'Enjoy the long weekend with our discounts', '2024-09-01', 35, '2024-09-04'),
('Halloween Sale', 'Spooky savings on all products', '2024-10-01', 45, '2024-10-31');
GO

INSERT INTO Materials (name, description) VALUES
('Cotton', 'Soft, fluffy fiber that grows in a boll around the seeds of the cotton plant.'),
('Polyester', 'A synthetic fabric made from petroleum.'),
('Nylon', 'A synthetic thermoplastic material that is lightweight and strong.'),
('Silk', 'A natural protein fiber that is produced by the silkworm.'),
('Leather', 'Material made from the skin of an animal by tanning or a similar process.'),
('Wool', 'A textile fiber obtained from sheep and other animals.'),
('Linen', 'A textile made from the fibers of the flax plant.'),
('Denim', 'A sturdy cotton twill fabric with a blue-black color.'),
('Suede', 'Leather with a napped finish, commonly used for jackets, shoes, shirts, purses, furniture, and other items.'),
('Fleece', 'A soft, warm, and comfortable fabric that is often used in jackets, blankets, and other clothing.');
GO

INSERT INTO Accounts (name, email, password, phone, address)
VALUES
('John Doe', 'john.doe@example.com', 'password123', '1234567890', '123 Main St, Anytown USA'),
('Jane Smith', 'jane.smith@example.com', 'password456', '0987654321', '456 Park Ave, Anytown USA'),
('Bob Johnson', 'bob.johnson@example.com', 'password789', '555-555-5555', '789 Broadway, Anytown USA'),
('Alice Brown', 'alice.brown@example.com', 'password321', '444-444-4444', '321 Elm St, Anytown USA'),
('Mike Davis', 'mike.davis@example.com', 'password654', '777-777-7777', '555 High St, Anytown USA'),
('Sarah Lee', 'sarah.lee@example.com', 'password987', '222-222-2222', '888 Low St, Anytown USA'),
('Tom Wilson', 'tom.wilson@example.com', 'passwordabc', '333-333-3333', '999 Oak St, Anytown USA'),
('Emily Nguyen', 'emily.nguyen@example.com', 'passworddef', '111-111-1111', '777 Pine St, Anytown USA'),
('David Kim', 'david.kim@example.com', 'passwordxyz', '666-666-6666', '666 Maple St, Anytown USA'),
('Samantha Lee', 'samantha.lee@example.com', 'password1234', '444-444-4444', '111 Cherry St, Anytown USA');
GO

INSERT INTO Products (name, description, price, image_url, category_id, brand_id, promotion_id) VALUES
('Samsung Galaxy S20', 'The Samsung Galaxy S20 is a high-end Android smartphone', 999.99, 'https://www.example.com/images/galaxys20.jpg', 1, 1, 1),
('Apple MacBook Pro', 'The MacBook Pro is a line of Macintosh portable computers', 1599.99, 'https://www.example.com/images/macbookpro.jpg', 1, 2, 1),
('Nike Air Max', 'Nike Air Max is a line of shoes first released by Nike, Inc. in 1987', 129.99, 'https://www.example.com/images/airmax.jpg', 3, 5, 2),
('Macbook Air 13-inch', 'The latest thin and light laptop from Apple', 1299.99, 'https://example.com/macbook-air.jpg', 1, 1, 1),
('iPhone 12 Pro', 'The most powerful iPhone ever', 1099.99, 'https://example.com/iphone-12-pro.jpg', 2, 1, 2),
('Dell XPS 13', 'Thin and light laptop with InfinityEdge display', 1199.99, 'https://example.com/dell-xps-13.jpg', 1, 2, 1),
('Samsung Galaxy S21 Ultra', 'The ultimate smartphone', 1399.99, 'https://example.com/samsung-galaxy-s21-ultra.jpg', 2, 3, 3),
('HP Spectre x360', 'Premium 2-in-1 laptop with stunning design', 1499.99, 'https://example.com/hp-spectre-x360.jpg', 1, 4, 2),
('Sony Alpha 7 III', 'Full-frame mirrorless camera with advanced AF', 2199.99, 'https://example.com/sony-alpha-7-iii.jpg', 3, 5, NULL),
('Bose QuietComfort 35 II', 'Premium noise-cancelling headphones', 299.99, 'https://example.com/bose-quietcomfort-35-ii.jpg', 4, 6, 4),
('Microsoft Surface Laptop 4', 'Thin and light laptop with excellent battery life', 1299.99, 'https://example.com/microsoft-surface-laptop-4.jpg', 1, 7, NULL),
('LG OLED CX Series', 'The best OLED TV of 2021', 1999.99, 'https://example.com/lg-oled-cx-series.jpg', 5, 8, 5),
('Nintendo Switch', 'The most popular gaming console of 2021', 299.99, 'https://example.com/nintendo-switch.jpg', 6, 9, NULL);
GO
INSERT INTO promotion_product (promotion_id, product_id) VALUES
(1, 1),
(1, 2),
(2, 3);


INSERT INTO Orders (account_id, order_date, total_price) VALUES
(1, '2023-05-08', 249.99),
(1, '2023-05-06', 169.99),
(2, '2023-05-07', 99.99),
(2, '2023-05-05', 299.99),
(3, '2023-05-03', 59.99),
(3, '2023-05-01', 199.99),
(4, '2023-05-02', 149.99),
(4, '2023-05-04', 79.99),
(5, '2023-05-06', 219.99),
(5, '2023-05-08', 149.99);
GO

INSERT INTO Order_Details (order_id, product_id, quantity, price) VALUES
(1, 1, 2, 99.99),
(1, 2, 1, 50.00),
(2, 3, 1, 69.99),
(2, 4, 2, 115.00),
(3, 5, 1, 99.99),
(3, 6, 1, 0.00),
(4, 7, 3, 199.99);
GO
