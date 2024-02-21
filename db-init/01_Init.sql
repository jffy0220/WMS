-------------------------------------------------------------
-- Orders
-------------------------------------------------------------
CREATE TABLE Orders (
    id INT PRIMARY KEY,
    orderNumber VARCHAR(255),
    created DATETIME,
    customerId INT,
    salesChannelId INT,
    shippingId INT,
    orderStatus VARCHAR(50),
    FOREIGN KEY (customerId) REFERENCES Customers(id),
    FOREIGN KEY (salesChannelId) REFERENCES SalesChannel(id),
    FOREIGN KEY (shippingId) REFERENCES Shipping(id)
);

-------------------------------------------------------------
-- Customers
-------------------------------------------------------------
CREATE TABLE Customers (
    id INT PRIMARY KEY,
    firstName TEXT,
    lastName TEXT,
    created DATETIME,
    addressId INT,
    phoneOne VARCHAR(50),
    phoneTwo VARCHAR(50),
    emailOne VARCHAR(255),
    emailTwo VARCHAR(255)
    FOREIGN KEY (addressId) REFERENCES Addresses(id)
);

-------------------------------------------------------------
-- Addresses 
-------------------------------------------------------------
CREATE TABLE Addresses (
    id INT PRIMARY KEY,
    addressOne VARCHAR(255),
    addressTwo VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(100),
    zip VARCHAR(50),
    country VARCHAR(255)
);

-------------------------------------------------------------
-- Sales Channel
-------------------------------------------------------------
CREATE TABLE SalesChannel (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    type VARCHAR(50),
    description TEXT,
    url VARCHAR(100),
    contactInfo VARCHAR(255),
    status VARCHAR(100),
    created DATETIME,
    managerId INT,
    FOREIGN KEY (managerId) REFERENCES Users(id)
);

-------------------------------------------------------------
-- Shipping
-------------------------------------------------------------
CREATE TABLE Shipping (
    id INT PRIMARY KEY,
    orderId INT,
    carrierName VARCHAR(100),
    trackingNumber VARCHAR(255),
    shippingMethod VARCHAR(50),
    shippingCost VARCHAR(50),
    shipDate DATETIME,
    estimatedDeliveryDate DATETIME,
    actualDeliveryDate DATETIME,
    status VARCHAR(50),
    shipFromAddressId INT,
    shipToAddressId INT,
    weight INT,
    dimensions VARCHAR(25),
    notes TEXT,
    created DATETIME,
    updated DATETIME,
    updatedBy INT,
    FOREIGN KEY (orderId) REFERENCES Orders(id),
    FOREIGN KEY (shipFromAddressId) REFERENCES Addresses(id),
    FOREIGN KEY (shipToAddressId) REFERENCES Addresses(id),
    FOREIGN KEY (updatedBy) REFERENCES Users(id)
);

-------------------------------------------------------------
-- Users
-------------------------------------------------------------
CREATE TABLE Users (
    id INT PRIMARY KEY,
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    created DATETIME,
    roleId INT,
    positionName VARCHAR(50),
    lastLogin DATETIME,
    password VARCHAR(255),
    email VARCHAR(255),
    FOREIGN KEY (roleId) REFERENCES Roles(id)
);

-------------------------------------------------------------
-- Products
-------------------------------------------------------------
CREATE TABLE Products (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    price VARCHAR(255),
    sku VARCHAR(255),
    categoryId INT,
    FOREIGN KEY (categoryId) REFERENCES ProductCategory(id)
);

-------------------------------------------------------------
-- Product Category
-------------------------------------------------------------
CREATE TABLE ProductCategory (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    parentCategoryId INT,
    created DATETIME,
    createdBy INT,
    FOREIGN KEY (parentCategoryId) REFERENCES ProductCategory(id),
    FOREIGN KEY (createdBy) REFERENCES Users(id)
);

-------------------------------------------------------------
-- Inventory
-------------------------------------------------------------
CREATE TABLE Inventory (
    id INT PRIMARY KEY,
    productId INT,
    quantityAvailable INT,
    restockDate DATETIME,
    supplierId INT,
    stockLevel INT,
    FOREIGN KEY (productId) REFERENCES Products(id),
    FOREIGN KEY (supplierId) REFERENCES Suppliers(id)
);

-------------------------------------------------------------
-- Suppliers
-------------------------------------------------------------
CREATE TABLE Suppliers (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    phoneOne VARCHAR(25),
    phoneTwo VARCHAR(25),
    emailOne VARCHAR(25),
    emailTwo VARCHAR(25),
    addressId INT,
    FOREIGN KEY (addressid) REFERENCES Addresses(id)
);

-------------------------------------------------------------
-- Order Details
-------------------------------------------------------------
CREATE TABLE OrderDetails (
    id INT PRIMARY KEY,
    orderId INT,
    productId INT,
    quantity INT,
    unitPrice VARCHAR(25),
    discountId INT,
    created DATETIME,
    updated DATETIME,
    updatedBy INT,
    FOREIGN KEY (orderId) REFERENCES Orders(id),
    FOREIGN KEY (productId) REFERENCES Products(id),
    FOREIGN KEY (dicountId) REFERENCES Discounts(id),
    FOREIGN KEY (updatedBy) REFERENCES Users(id)
);

-------------------------------------------------------------
-- Payments
-------------------------------------------------------------
CREATE TABLE Payments (
    id INT PRIMARY KEY,
    orderId INT,
    amount VARCHAR(50),
    paymentMethod VARCHAR(255),
    paymentDate DATETIME,
    status VARCHAR(50),
    FOREIGN KEY (orderId) REFERENCES Orders(id)
);

-------------------------------------------------------------
-- Returns
-------------------------------------------------------------
CREATE TABLE Returns (
    id INT PRIMARY KEY,
    orderId INT,
    productId INT,
    reason TEXT,
    quantityReturned INT,
    refundAmount VARCHAR(50),
    status VARCHAR(25),
    FOREIGN KEY (orderId) REFERENCES Orders(id),
    FOREIGN KEY (productId) REFERENCES Products(id)
);

-------------------------------------------------------------
-- Discounts
-------------------------------------------------------------
CREATE TABLE Discounts (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    discountType VARCHAR(25),
    discountValue VARCHAR(25),
    startDate DATETIME,
    endDate DATETIME,
    created DATETIME,
    createdBy INT,
    FOREIGN KEY (createdBy) REFERENCES Users(id),
);

-------------------------------------------------------------
-- AuditLog
-------------------------------------------------------------
CREATE TABLE AuditLog (
    id INT PRIMARY KEY,
    action VARCHAR(255),
    userId INT,
    timestamp TIMESTAMP,
    description TEXT,
    FOREIGN KEY (userId) REFERENCES Users(id),
);

-------------------------------------------------------------
-- Roles
-------------------------------------------------------------
CREATE TABLE Roles (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    created DATETIME,
    createdBy INT,
    FOREIGN KEY (createdBy) REFERENCES Users(id)
);

-------------------------------------------------------------
-- Permissions
-------------------------------------------------------------
CREATE TABLE Permissions (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    roleId INT,
    created DATETIME,
    createdBy INT,
    FOREIGN KEY (roleId) REFERENCES Roles(id),
    FOREIGN KEY (createdBy) REFERENCES Users(id)
);