-------------------------------------------------------------
-- Roles
-------------------------------------------------------------
INSERT INTO Roles ( id, name, created ) VALUES 
('44ee57a3-48f1-42c3-bd2e-af46fd1c431d', 'Admin', NOW()),
('c505d4a0-ee42-49e4-b977-5ba4f3a4ca79', 'Super Admin', NOW()),
('79fefaff-d4af-4ffb-86bc-f5a180ce5f53', 'Warehouse Manager', NOW()),
('e4f905dc-79a2-4e13-83a3-8e71f1e4b52e', 'User', NOW());

-------------------------------------------------------------
-- Companies
-------------------------------------------------------------
INSERT INTO Companies (id, name, created) VALUES
('0a7c3915-d892-4b7f-9343-6d05a6ebc290', 'Company A', NOW()),
('c436ae06-8280-44aa-b3c9-e3f5978e4f3a', 'Company B', NOW());

-------------------------------------------------------------
-- Users
-------------------------------------------------------------
INSERT INTO Users ( id, firstName, lastName, created, roleId, positionName, lastLogin, password, email, companyId ) VALUES
('dc67c823-5c83-4e64-b7dd-55ac7739ca95', 'Justin', 'Farley', NOW(), 'c505d4a0-ee42-49e4-b977-5ba4f3a4ca79', 'Root', NOW(), 'hashed-password', 'justin@test.com', '0a7c3915-d892-4b7f-9343-6d05a6ebc290'),
('10d06f1a-bf4e-4efb-b909-940ba9a55b3f', 'Super', 'User', NOW(), 'c505d4a0-ee42-49e4-b977-5ba4f3a4ca79', 'SuperUser', NOW(), 'hashed-password', 'super@user.com', 'c436ae06-8280-44aa-b3c9-e3f5978e4f3a'),
('32525092-9e2d-4eba-ab28-191f75890ad1', 'Warehouse', 'Manager', NOW(), '79fefaff-d4af-4ffb-86bc-f5a180ce5f53', 'WarehouseManager', NOW(), 'hashed-password', 'wh@manager.com', '0a7c3915-d892-4b7f-9343-6d05a6ebc290'),
('9de00f75-ac79-4ec0-9974-b5be5a72699a', 'Test', 'User', NOW(), 'e4f905dc-79a2-4e13-83a3-8e71f1e4b52e', 'TUser', NOW(), 'hashed-password', 't@user.com', 'c436ae06-8280-44aa-b3c9-e3f5978e4f3a');

-------------------------------------------------------------
-- Manage Circular Depdendency for Roles & Users
-------------------------------------------------------------
UPDATE Roles SET createdBy = 'dc67c823-5c83-4e64-b7dd-55ac7739ca95';

-------------------------------------------------------------
-- Permissions
-- 12/23 Doing basic CRUD for now, though we will get more granular with permissions in later versions
-------------------------------------------------------------
INSERT INTO Permissions ( id, name, roleId, created, createdBy ) VALUES 
( 'f84a3320-d16c-4ca0-bfbe-206e415c06be', 'Create', '44ee57a3-48f1-42c3-bd2e-af46fd1c431d', NOW(), 'dc67c823-5c83-4e64-b7dd-55ac7739ca95'),
( '7bdac8a2-2719-4697-aad8-27ff4322d86d', 'Read', '44ee57a3-48f1-42c3-bd2e-af46fd1c431d', NOW(), 'dc67c823-5c83-4e64-b7dd-55ac7739ca95'),
( 'feb55e7f-fc65-490b-82d4-f1248741dee7', 'Update', '44ee57a3-48f1-42c3-bd2e-af46fd1c431d', NOW(), 'dc67c823-5c83-4e64-b7dd-55ac7739ca95'),
( 'bdd438a9-bdc7-4995-88f2-a2f9fbcef1bd', 'Delete', '44ee57a3-48f1-42c3-bd2e-af46fd1c431d', NOW(), 'dc67c823-5c83-4e64-b7dd-55ac7739ca95');

-------------------------------------------------------------
-- Addresses
-------------------------------------------------------------
INSERT INTO Addresses ( id, addressOne, addressTwo, city, state, zip, country) VALUES
('c29ed97b-b7b8-4376-a7c1-1ed73436c490', '123 Main Street', '', 'Tacoma', 'WA', '12345', 'US'),
('16cdeb6f-7bc7-4ee1-94b5-b5c4aa00565f', '456 Main Street', '', 'Louisville', 'KY', '42005', 'US'),
('493c8853-50a2-4d73-84a8-9d2da21cc63d', '123 Cherry Road', '', 'Tacoma', 'WA', '12345', 'US'),
('55d4edc1-2e97-400c-ac2c-0612ec8e81f8', '987-123 Accord Street', '', 'Tampa', 'FL', '38655', 'US'),
('fc520889-6d81-4b51-afb5-ccd68caa959f', '38611 Main Avenue', '', 'Nashville', 'TN', '99987', 'US'),
('46777898-6c93-45e3-918b-a8d345747508', '12345 Warehouse Blvd', '', 'Nashville', 'TN', '99999', 'US'),
('aae29b6c-9b63-45c8-a61f-1fbf973657ce', '54321 Manufacter Rd', '', 'Denver', 'CO', '99987', 'US');

-------------------------------------------------------------
-- Suppliers
-------------------------------------------------------------
INSERT INTO Suppliers ( id, name, phoneOne, phoneTwo, emailOne, emailTwo, addressId ) VALUES
( 'a63eaa80-31a5-47cd-b7da-dac101a205a0', 'Amazon Warehouse One', '111-222-3333', '', 'amazon@test.com', '', '46777898-6c93-45e3-918b-a8d345747508'),
( 'f86ea317-f346-494d-988f-95e995ace8d7', 'Manufacturing Facility One', '222-333-4444', '', 'manu.test@test.com', '', 'aae29b6c-9b63-45c8-a61f-1fbf973657ce');

-------------------------------------------------------------
-- Product Category
-------------------------------------------------------------
INSERT INTO ProductCategory ( id, name, description, parentCategoryId, created, createdBy ) VALUES 
( 'fd6a40ad-4e29-456c-8218-8bd911c1b0a2', 'Test Product Line', 'This is an example product line', null, NOW(), '32525092-9e2d-4eba-ab28-191f75890ad1'),
( '8c6fbd28-d70a-4fe1-9df6-b2629624aab6', 'Processors', 'Central Processing Units for Computers', null, NOW(), '32525092-9e2d-4eba-ab28-191f75890ad1'),
( 'ca3157f4-1ce6-46ef-876a-116bf37dd012', 'Intel Processors', 'Intels Line of CPUs', '8c6fbd28-d70a-4fe1-9df6-b2629624aab6', NOW(), '32525092-9e2d-4eba-ab28-191f75890ad1'),
( '7ed5262f-b982-4b39-8b60-c5e496d3679e', 'AMD Processors', 'AMDs Line of CPUs', '8c6fbd28-d70a-4fe1-9df6-b2629624aab6', NOW(), '32525092-9e2d-4eba-ab28-191f75890ad1');

-------------------------------------------------------------
-- Products
-------------------------------------------------------------
INSERT INTO Products ( id, name, description, price, sku, categoryId ) VALUES
( 'bbcdf2f8-b079-4d20-97e6-0aa8be68282f', 'Intel Core i3', 'Intels Core i3 processor', '120.00', 'ABCD-123', 'ca3157f4-1ce6-46ef-876a-116bf37dd012'),
( 'fe0c8067-d76c-4935-962e-bbc5dea51c4d', 'Intel Core i5', 'Intels Core i5 processor', '299.99', 'BCDA-123', 'ca3157f4-1ce6-46ef-876a-116bf37dd012'),
( 'cd8e231d-2f09-4acc-bee4-e47ad9f11d95', 'Intel Core i7', 'Intels Core i7 processor', '399.99', 'CDAB-123', 'ca3157f4-1ce6-46ef-876a-116bf37dd012'),
( 'de6992ea-2c0c-4995-b3de-61e881be4e9b', 'Intel Core i9', 'Intels Core i9 processor', '544.99', 'DABC-123', 'ca3157f4-1ce6-46ef-876a-116bf37dd012'),
( 'acd3f574-79f1-4340-8670-5d764a4db06c', 'Intel Xeon', 'Intels Xeon processor', '125.99', 'BDAC-123', 'ca3157f4-1ce6-46ef-876a-116bf37dd012'),
( '5df1bb65-bdbb-41f8-8359-71b7511882c0', 'Intel Celeron', 'Intels Celeron processor', '237.99', 'DACB-123', 'ca3157f4-1ce6-46ef-876a-116bf37dd012'),
( '45b4c000-3cc7-4ebe-9bfd-f47c8182554c', 'Intel Core 2', 'Intels Core 2 processor', '59.99', 'ACBD-123', 'ca3157f4-1ce6-46ef-876a-116bf37dd012'),
( '1d90bc74-a9c3-4e44-b99f-43001093f019', 'Intel Core', 'Intels Core processor', '10.99', 'CBDA-123', 'ca3157f4-1ce6-46ef-876a-116bf37dd012'),
( 'e1602aee-f937-4951-a66c-66b5a9d5e188', 'Intel Raptor Lake', 'Intels Raptor Lake processor', '659.99', 'DCAB-123', 'ca3157f4-1ce6-46ef-876a-116bf37dd012'),
( '89ba3ddc-3193-4a90-9642-84d8fe7032d9', 'AMD Ryzen 9', 'AMDs Ryzen 9 Processor', '599.00', 'ABC-456', '7ed5262f-b982-4b39-8b60-c5e496d3679e'),
( 'd2f3fefd-c526-4a02-8f81-ede375b3dfcb', 'AMD Ryzen 9', 'AMDs Ryzen 9 Processor', '369.00', 'BCA-456', '7ed5262f-b982-4b39-8b60-c5e496d3679e'),
( 'a6835631-05f4-46b5-815d-2bb7cfc1d18b', 'AMD Ryzen 9', 'AMDs Ryzen 9 Processor', '229.00', 'CAB-456', '7ed5262f-b982-4b39-8b60-c5e496d3679e');

-------------------------------------------------------------
-- Customers
-------------------------------------------------------------
INSERT INTO Customers ( id, firstName, lastName, created, addressId, phoneOne, emailOne ) VALUES 
('7ccb11f8-913a-4d8b-85f0-2cd651a3a408', 'Justin', 'Farley', NOW(), 'c29ed97b-b7b8-4376-a7c1-1ed73436c490', '123-456-7890', 'test@test.com'),
('2003062a-7c42-4e27-86d0-ef698dfef501', 'John', 'Doe', NOW(), '16cdeb6f-7bc7-4ee1-94b5-b5c4aa00565f', '999-999-9999', 'john@doe.com'),
('16f46581-ab41-4a29-a765-4e91468ecfa9', 'Jane', 'Doe', NOW(), '493c8853-50a2-4d73-84a8-9d2da21cc63d', '111-111-1111', 'jane@doe.com'),
('25dfba65-147a-4460-a6af-0c796786360b', 'Mary', 'Joe', NOW(), '55d4edc1-2e97-400c-ac2c-0612ec8e81f8', '222-222-2222', 'mary@doe.com'),
('fb29e9cf-c99d-4f88-8207-6ffc28185560', 'Michael', 'Test', NOW(), 'fc520889-6d81-4b51-afb5-ccd68caa959f', '333-333-3333', 'michael@test.com');

-------------------------------------------------------------
-- Sales Channel
-------------------------------------------------------------
INSERT INTO SalesChannel ( id, name, type, description, url, contactInfo, status, created, managerId ) VALUES 
( '5e0f9552-8337-4816-8d0f-55d011128957', 'Primary', 'Standard', 'Primary Sales Channel', '', '555-555-5555', 'Active', NOW(), null);

-------------------------------------------------------------
-- Orders
-------------------------------------------------------------
INSERT INTO Orders (id, orderNumber, created, customerId, salesChannelId, shippingId, orderStatus, companyId ) VALUES
( '70071dc8-b86d-4c2a-98cd-47744cbbdcf7', 'ABCD-1234', NOW(), '7ccb11f8-913a-4d8b-85f0-2cd651a3a408', '5e0f9552-8337-4816-8d0f-55d011128957', null, 'CREATED', '0a7c3915-d892-4b7f-9343-6d05a6ebc290'),
( 'c52be51c-0338-4d7c-ad46-cacd3f53ef5b', 'ABCD-2345', NOW(), '2003062a-7c42-4e27-86d0-ef698dfef501', '5e0f9552-8337-4816-8d0f-55d011128957', null, 'CREATED', '0a7c3915-d892-4b7f-9343-6d05a6ebc290'),
( '79dc9c77-f0ea-47dd-a5f6-79653952f157', 'ABCD-3456', NOW(), '16f46581-ab41-4a29-a765-4e91468ecfa9', '5e0f9552-8337-4816-8d0f-55d011128957', null, 'CREATED', '0a7c3915-d892-4b7f-9343-6d05a6ebc290'),
( '1ce68f49-7997-411a-870a-8a441c4a785a', 'ABCD-4567', NOW(), '25dfba65-147a-4460-a6af-0c796786360b', '5e0f9552-8337-4816-8d0f-55d011128957', null, 'CREATED', '0a7c3915-d892-4b7f-9343-6d05a6ebc290'),
( '6ea60ef9-69d1-41d7-afd6-5f60abde1788', 'ABCD-5678', NOW(), 'fb29e9cf-c99d-4f88-8207-6ffc28185560', '5e0f9552-8337-4816-8d0f-55d011128957', null, 'CREATED', 'c436ae06-8280-44aa-b3c9-e3f5978e4f3a'),
( '332f6a66-05bc-4e4e-a6be-2d7c97db3ff9', 'ABCD-6789', NOW(), '7ccb11f8-913a-4d8b-85f0-2cd651a3a408', '5e0f9552-8337-4816-8d0f-55d011128957', null, 'CREATED', 'c436ae06-8280-44aa-b3c9-e3f5978e4f3a');

-------------------------------------------------------------
-- Shipping
-------------------------------------------------------------
-- NO DATA TO ADD AT THIS MOMENT, WILL HAVE TO DO IN A LATER VERSION IF WE WANT TO SIMULATE ORDERS THAT ARE IN PROGRESS OR ALREADY COMPLETE

-------------------------------------------------------------
-- Order Details
-------------------------------------------------------------
INSERT INTO OrderDetails ( id, orderId, productId, quantity, unitPrice, discountId, created, updatedBy ) VALUES
( 'f37c9c7c-0f1d-49ba-8eff-45d2457657c2', '70071dc8-b86d-4c2a-98cd-47744cbbdcf7', 'bbcdf2f8-b079-4d20-97e6-0aa8be68282f', 1, '$250.99', null, NOW(), '32525092-9e2d-4eba-ab28-191f75890ad1'),
( '163b0536-332e-49f6-9e99-e97515912043', '70071dc8-b86d-4c2a-98cd-47744cbbdcf7', 'cd8e231d-2f09-4acc-bee4-e47ad9f11d95', 2, '$350.99', null, NOW(), '32525092-9e2d-4eba-ab28-191f75890ad1'),
( 'b621ede8-1418-45de-b8ef-b7db833c0c5f', 'c52be51c-0338-4d7c-ad46-cacd3f53ef5b', '5df1bb65-bdbb-41f8-8359-71b7511882c0', 1, '$400.99', null, NOW(), '32525092-9e2d-4eba-ab28-191f75890ad1'),
( 'f700c1d8-08c8-40a1-9143-73286ce97256', '79dc9c77-f0ea-47dd-a5f6-79653952f157', '89ba3ddc-3193-4a90-9642-84d8fe7032d9', 1, '$999.99', null, NOW(), '32525092-9e2d-4eba-ab28-191f75890ad1'),
( '46df65bf-b362-42ed-8914-991d302fbc38', '1ce68f49-7997-411a-870a-8a441c4a785a', 'acd3f574-79f1-4340-8670-5d764a4db06c', 7, '$125.99', null, NOW(), '32525092-9e2d-4eba-ab28-191f75890ad1'),
( '281a3c89-8362-4b18-8973-fc8850c2ce78', '6ea60ef9-69d1-41d7-afd6-5f60abde1788', 'd2f3fefd-c526-4a02-8f81-ede375b3dfcb', 3, '$250.99', null, NOW(), '32525092-9e2d-4eba-ab28-191f75890ad1'),
( '46f38b8a-7a9e-4f5f-aadb-51b5ec24141a', '332f6a66-05bc-4e4e-a6be-2d7c97db3ff9', 'fe0c8067-d76c-4935-962e-bbc5dea51c4d', 5, '$333.99', null, NOW(), '32525092-9e2d-4eba-ab28-191f75890ad1');

-------------------------------------------------------------
-- Payments
-- NOTE: In the initial SQL, we will have some that aren't paid for yet, which will be marked "unpaid"
-- NOTE: This may have to changed slightly depending on how we link an ERP or payment system like Stripe to the WMS
-------------------------------------------------------------
INSERT INTO Payments ( id, orderId, amount, paymentMethod, paymentDate ) VALUES
( 'de113ba9-ddf1-4326-b6e3-d8cb3e37c301', '70071dc8-b86d-4c2a-98cd-47744cbbdcf7', '$601.98', 'CARD', NOW()),
( '5252a410-55cc-4dfe-9a0f-9059c2f7df59', 'c52be51c-0338-4d7c-ad46-cacd3f53ef5b', '$400.99', 'CARD', NOW()),
( 'c80b4193-845b-4ab1-a226-44bcc118410a', '79dc9c77-f0ea-47dd-a5f6-79653952f157', '$999.99', 'CARD', NOW());

-------------------------------------------------------------
-- Returns
-------------------------------------------------------------
-- NO RETURN DATA HAS BEEN CREATED YET, WE WILL CREATE IT IN LATER SQL TESTING SCRIPTS

-------------------------------------------------------------
-- Inventory
-- NOTE BECAUSE THIS IS INIT, THE STOCK LEVEL AND THE QUANTITY AVAILABLE WILL BE THE SAME SINCE THE SYSTEM HASNT ALLOCATED THE STOCK YET, LATER WE WILL AUTOMATE THAT
-------------------------------------------------------------
INSERT INTO Inventory ( id, productId, quantityAvailable, restockDate, supplierId, stockLevel ) VALUES
( 'f232d347-99f0-4fae-9ae0-1b694ddbeac0', 'bbcdf2f8-b079-4d20-97e6-0aa8be68282f', 100, '2024-03-05 12:00:00', 'f86ea317-f346-494d-988f-95e995ace8d7', 100),
( '68cd754f-effb-44ab-8d03-84f3df4fa0d8', 'fe0c8067-d76c-4935-962e-bbc5dea51c4d', 100, '2024-03-08 12:00:00', 'f86ea317-f346-494d-988f-95e995ace8d7', 100),
( '3a25dd27-42ba-4c05-96b9-ea4d1ca58fc6', 'cd8e231d-2f09-4acc-bee4-e47ad9f11d95', 100, '2024-03-20 12:00:00', 'f86ea317-f346-494d-988f-95e995ace8d7', 100),
( '3efd8aff-ca61-4038-a5ac-6480fd018fc9', 'de6992ea-2c0c-4995-b3de-61e881be4e9b', 100, '2024-03-10 12:00:00', 'f86ea317-f346-494d-988f-95e995ace8d7', 100),
( 'a0653924-0243-48e7-8ac9-89ac396820bd', 'acd3f574-79f1-4340-8670-5d764a4db06c', 100, '2024-03-01 12:00:00', 'f86ea317-f346-494d-988f-95e995ace8d7', 100),
( '2aecf1cd-69ed-4042-ab41-9957b56d77a4', '5df1bb65-bdbb-41f8-8359-71b7511882c0', 100, '2024-02-28 12:00:00', 'f86ea317-f346-494d-988f-95e995ace8d7', 100),
( 'a54a7432-90fb-4d02-8cc1-c432a72d1177', '45b4c000-3cc7-4ebe-9bfd-f47c8182554c', 100, '2024-03-04 12:00:00', 'a63eaa80-31a5-47cd-b7da-dac101a205a0', 100),
( 'b67284a3-7936-4756-bbd9-0b89241452aa', '1d90bc74-a9c3-4e44-b99f-43001093f019', 100, '2024-03-08 12:00:00', 'a63eaa80-31a5-47cd-b7da-dac101a205a0', 100),
( '22bb6450-1e8b-4f31-b1a3-8c1f56263aa3', 'e1602aee-f937-4951-a66c-66b5a9d5e188', 100, '2024-02-25 12:00:00', 'a63eaa80-31a5-47cd-b7da-dac101a205a0', 100),
( '22a21e2d-0e75-4cd3-bbd8-2938bee42fb1', '89ba3ddc-3193-4a90-9642-84d8fe7032d9', 100, '2024-02-10 12:00:00', 'a63eaa80-31a5-47cd-b7da-dac101a205a0', 100),
( 'f62ea3b4-8355-4716-ba27-5e7dc4c084d3', 'd2f3fefd-c526-4a02-8f81-ede375b3dfcb', 100, '2024-02-29 12:00:00', 'a63eaa80-31a5-47cd-b7da-dac101a205a0', 100),
( 'de1d0f2e-7f86-4a89-b31d-f2c8cdf14eab', 'a6835631-05f4-46b5-815d-2bb7cfc1d18b', 100, '2024-03-14 12:00:00', 'a63eaa80-31a5-47cd-b7da-dac101a205a0', 100);