CREATE TABLE IF NOT EXISTS orders (
    id UUID PRIMARY KEY NOT NULL,
    customerId UUID NOT NULL,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    totalAmount FLOAT,
    status NOT NULL DEFAULT 'Created'
);

CREATE TABLE IF NOT EXISTS orderDetails (
    id UUID PRIMARY KEY NOT NULL,
    orderId UUID NOT NULL,
    productId UUID NOT NULL,
    quantity INT NOT NULL,
    unitPrice FLOAT NOT NULL
);

CREATE TABLE IF NOT EXISTS inventory (
    id UUID PRIMARY KEY NOT NULL,
    sku TEXT,
    stockLevel INT NOT NULL,
    locationId UUID NOT NULL
);

CREATE TABLE IF NOT EXISTS customers (
    id UUID PRIMARY KEY NOT NULL,
    firstName VARCHAR(255) NOT NULL,
    lastName VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(15),
    addressId UUID NOT NULL
);

