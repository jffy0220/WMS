-- ENABLE PGCRYPTO
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-------------------------------------------------------------
-- Addresses 
-------------------------------------------------------------
CREATE TABLE Addresses (
    id UUID PRIMARY KEY,
    addressOne VARCHAR(255),
    addressTwo VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(100),
    zip VARCHAR(50),
    country VARCHAR(255)
);

-------------------------------------------------------------
-- Roles
-------------------------------------------------------------
CREATE TABLE Roles (
    id UUID PRIMARY KEY,
    name VARCHAR(255),
    created TIMESTAMP,
    createdBy UUID
);

-------------------------------------------------------------
-- Users
-------------------------------------------------------------
CREATE TABLE Users (
    id UUID PRIMARY KEY,
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    created TIMESTAMP,
    roleId UUID,
    positionName VARCHAR(50),
    lastLogin TIMESTAMP,
    password VARCHAR(255),
    email VARCHAR(255)
);

-------------------------------------------------------------
-- Permissions
-------------------------------------------------------------
CREATE TABLE Permissions (
    id UUID PRIMARY KEY,
    name VARCHAR(255),
    roleId UUID,
    created TIMESTAMP,
    createdBy UUID
);

-------------------------------------------------------------
-- Customers
-------------------------------------------------------------
CREATE TABLE Customers (
    id UUID PRIMARY KEY,
    firstName TEXT,
    lastName TEXT,
    created TIMESTAMP,
    addressId UUID,
    phoneOne VARCHAR(50),
    phoneTwo VARCHAR(50),
    emailOne VARCHAR(255),
    emailTwo VARCHAR(255)
);

-------------------------------------------------------------
-- Orders
-------------------------------------------------------------
CREATE TABLE Orders (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    orderNumber VARCHAR(255),
    created TIMESTAMP,
    customerId UUID,
    salesChannelId UUID,
    shippingId UUID,
    orderStatus VARCHAR(50)
);

-------------------------------------------------------------
-- Sales Channel
-------------------------------------------------------------
CREATE TABLE SalesChannel (
    id UUID PRIMARY KEY,
    name VARCHAR(255),
    type VARCHAR(50),
    description TEXT,
    url VARCHAR(100),
    contactInfo VARCHAR(255),
    status VARCHAR(100),
    created TIMESTAMP,
    managerId UUID
);

-------------------------------------------------------------
-- Shipping
-------------------------------------------------------------
CREATE TABLE Shipping (
    id UUID PRIMARY KEY,
    orderId UUID,
    carrierName VARCHAR(100),
    trackingNumber VARCHAR(255),
    shippingMethod VARCHAR(50),
    shippingCost VARCHAR(50),
    shipDate TIMESTAMP,
    estimatedDeliveryDate TIMESTAMP,
    actualDeliveryDate TIMESTAMP,
    status VARCHAR(50),
    shipFromAddressId UUID,
    shipToAddressId UUID,
    weight INT,
    dimensions VARCHAR(25),
    notes TEXT,
    created TIMESTAMP,
    updated TIMESTAMP,
    updatedBy UUID
);


-------------------------------------------------------------
-- Products
-------------------------------------------------------------
CREATE TABLE Products (
    id UUID PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    price VARCHAR(255),
    sku VARCHAR(255),
    categoryId UUID
);

-------------------------------------------------------------
-- Product Category
-------------------------------------------------------------
CREATE TABLE ProductCategory (
    id UUID PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    parentCategoryId UUID NULL, -- Adding in NULL here because some categories wont have parent categories
    created TIMESTAMP,
    createdBy UUID
);

-------------------------------------------------------------
-- Inventory
-------------------------------------------------------------
CREATE TABLE Inventory (
    id UUID PRIMARY KEY,
    productId UUID,
    quantityAvailable INT,
    restockDate TIMESTAMP,
    supplierId UUID,
    stockLevel INT
);

-------------------------------------------------------------
-- Suppliers
-------------------------------------------------------------
CREATE TABLE Suppliers (
    id UUID PRIMARY KEY,
    name VARCHAR(255),
    phoneOne VARCHAR(25),
    phoneTwo VARCHAR(25),
    emailOne VARCHAR(25),
    emailTwo VARCHAR(25),
    addressId UUID
);

-------------------------------------------------------------
-- Order Details
-------------------------------------------------------------
CREATE TABLE OrderDetails (
    id UUID PRIMARY KEY,
    orderId UUID,
    productId UUID,
    quantity INT,
    unitPrice VARCHAR(25),
    discountId UUID,
    created TIMESTAMP,
    updated TIMESTAMP,
    updatedBy UUID
);

-------------------------------------------------------------
-- Payments
-------------------------------------------------------------
CREATE TABLE Payments (
    id UUID PRIMARY KEY,
    orderId UUID,
    amount VARCHAR(50),
    paymentMethod VARCHAR(255),
    paymentDate TIMESTAMP,
    status VARCHAR(50)
);

-------------------------------------------------------------
-- Returns
-------------------------------------------------------------
CREATE TABLE Returns (
    id UUID PRIMARY KEY,
    orderId UUID,
    productId UUID,
    reason TEXT,
    quantityReturned UUID,
    refundAmount VARCHAR(50),
    status VARCHAR(25)
);

-------------------------------------------------------------
-- Discounts
-------------------------------------------------------------
CREATE TABLE Discounts (
    id UUID PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    discountType VARCHAR(25),
    discountValue VARCHAR(25),
    startDate TIMESTAMP,
    endDate TIMESTAMP,
    created TIMESTAMP,
    createdBy UUID
);

-------------------------------------------------------------
-- AuditLog
-------------------------------------------------------------
CREATE TABLE AuditLog (
    id UUID PRIMARY KEY,
    action VARCHAR(255),
    userId UUID,
    timestamp TIMESTAMP,
    description TEXT
);

-- Adding foreign key constraints

-- Users & Roles circular dependency handled
-- Permissions
ALTER TABLE Permissions ADD CONSTRAINT fk_permissions_roleid FOREIGN KEY (roleId) REFERENCES Roles(id);
ALTER TABLE Permissions ADD CONSTRAINT fk_permissions_createdby FOREIGN KEY (createdBy) REFERENCES Users(id);

-- Customers
ALTER TABLE Customers ADD CONSTRAINT fk_customers_addressid FOREIGN KEY (addressId) REFERENCES Addresses(id);

-- Orders
ALTER TABLE Orders ADD CONSTRAINT fk_orders_customerid FOREIGN KEY (customerId) REFERENCES Customers(id);
ALTER TABLE Orders ADD CONSTRAINT fk_orders_saleschannelid FOREIGN KEY (salesChannelId) REFERENCES SalesChannel(id);
ALTER TABLE Orders ADD CONSTRAINT fk_orders_shippingid FOREIGN KEY (shippingId) REFERENCES Shipping(id);

-- Sales Channel
ALTER TABLE SalesChannel ADD CONSTRAINT fk_saleschannel_managerid FOREIGN KEY (managerId) REFERENCES Users(id);

-- Shipping
ALTER TABLE Shipping ADD CONSTRAINT fk_shipping_orderid FOREIGN KEY (orderId) REFERENCES Orders(id);
ALTER TABLE Shipping ADD CONSTRAINT fk_shipping_shipfromaddressid FOREIGN KEY (shipFromAddressId) REFERENCES Addresses(id);
ALTER TABLE Shipping ADD CONSTRAINT fk_shipping_shiptoaddressid FOREIGN KEY (shipToAddressId) REFERENCES Addresses(id);
ALTER TABLE Shipping ADD CONSTRAINT fk_shipping_updatedby FOREIGN KEY (updatedBy) REFERENCES Users(id);

-- Products & Product Category
ALTER TABLE Products ADD CONSTRAINT fk_products_categoryid FOREIGN KEY (categoryId) REFERENCES ProductCategory(id);
ALTER TABLE ProductCategory ADD CONSTRAINT fk_productcategory_parentcategoryid FOREIGN KEY (parentCategoryId) REFERENCES ProductCategory(id);
ALTER TABLE ProductCategory ADD CONSTRAINT fk_productcategory_createdby FOREIGN KEY (createdBy) REFERENCES Users(id);

-- Inventory
ALTER TABLE Inventory ADD CONSTRAINT fk_inventory_productid FOREIGN KEY (productId) REFERENCES Products(id);
ALTER TABLE Inventory ADD CONSTRAINT fk_inventory_supplierid FOREIGN KEY (supplierId) REFERENCES Suppliers(id);

-- Suppliers
ALTER TABLE Suppliers ADD CONSTRAINT fk_suppliers_addressid FOREIGN KEY (addressId) REFERENCES Addresses(id);

-- Order Details
ALTER TABLE OrderDetails ADD CONSTRAINT fk_orderdetails_orderid FOREIGN KEY (orderId) REFERENCES Orders(id);
ALTER TABLE OrderDetails ADD CONSTRAINT fk_orderdetails_productid FOREIGN KEY (productId) REFERENCES Products(id);
ALTER TABLE OrderDetails ADD CONSTRAINT fk_orderdetails_discountid FOREIGN KEY (discountId) REFERENCES Discounts(id);
ALTER TABLE OrderDetails ADD CONSTRAINT fk_orderdetails_updatedby FOREIGN KEY (updatedBy) REFERENCES Users(id);

-- Payments
ALTER TABLE Payments ADD CONSTRAINT fk_payments_orderid FOREIGN KEY (orderId) REFERENCES Orders(id);

-- Returns
ALTER TABLE Returns ADD CONSTRAINT fk_returns_orderid FOREIGN KEY (orderId) REFERENCES Orders(id);
ALTER TABLE Returns ADD CONSTRAINT fk_returns_productid FOREIGN KEY (productId) REFERENCES Products(id);

-- Discounts
ALTER TABLE Discounts ADD CONSTRAINT fk_discounts_createdby FOREIGN KEY (createdBy) REFERENCES Users(id);

-- AuditLog
ALTER TABLE AuditLog ADD CONSTRAINT fk_auditlog_userid FOREIGN KEY (userId) REFERENCES Users(id);


