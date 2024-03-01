const pool = require('../db/db');

class Order {
    constructor(orderData) {
        this.orderData = orderData;
    }

    static async findAll() {
        const { rows } = await pool.query('Select * FROM Orders');
        return rows.map(row => new Order(row));
    }

    static async findById(id) {
        const { rows } = await pool.query('SELECT * FROM Orders WHERE id = $1', [id]);
        return rows.length ? new Order(rows[0]) : null;
    }

    async save() {
        const { orderNumber, customerId, salesChannelId, shippingId, orderStatus } = this.orderData;
        const { rows } = await pool.query(
            'INSERT INTO Orders ( orderNumber, customerId, salesChannelId, shippingId, orderStatus) VALUES ($1, $2, $3, $4, $5) RETURNING *',
            [orderNumber, customerId, salesChannelId, shippingId, orderStatus]
        );

        this.orderData = rows[0];
    }

    static async update(id, updateFields) {
        const setString = Object.keys(updateFields)
            .map((key, index) => `${key} = $${index + 1}`)
            .join(', ');

        const values = Object.values(updateFields);

        const { rows } = await pool.query(
            `UPDATE Orders SET ${setString} WHERE id = $${values.length + 1} RETURNING *`, // This makes no logical sense to me, I figure we should be putting the id in here
            [...values, id]
        );

        return rows.length ? new Order(rows[0]) : null;
    }

    static async delete(id) {
        await pool.query('DELETE FROM Orders WHERE id = $1', [id]);
    }

    static async findOrdersByCompany(companyId) {
        const { rows } = await pool.query('SELECT * FROM Orders WHERE companyId = $1', [companyId]);
        return rows.map(row => new Order(row));
    }

    static async getCompleteOrdersByCompanyId(companyId) {
        const { rows } = await pool.query('SELECT * FROM Orders WHERE companyId = $1', [companyId]);
        const orderRows = rows;
        console.log(orderRows);
    
        let data = [];
    
        for (let row of orderRows) {
            let info = {}; // Reset the information each pass through our orders
    
            info["orderNumber"] = row.orderNumber;
            info["created"] = row.created;
            info["orderStatus"] = row.orderStatus;
    
            const salesChannelRows = await pool.query('SELECT name FROM SalesChannel WHERE id = $1', [row.salesChannelId]);
            if (salesChannelRows.rows.length > 0) {
                console.log(salesChannelRows.rows[0])
                info["salesChannel"] = salesChannelRows.rows[0].name;
            }
    
            if (row.shippingId !== null) {
                const shippingRows = await pool.query('SELECT shipDate, estimatedDeliveryDate, actualDeliveryDate, status FROM Shipping WHERE id = $1', [row.shippingId]);
                if (shippingRows.rows.length > 0) {
                    const shippingInfo = shippingRows.rows[0];
                    info["shipDate"] = shippingInfo.shipDate;
                    info["estimatedDeliveryDate"] = shippingInfo.estimatedDeliveryDate;
                    info["actualDeliveryDate"] = shippingInfo.actualDeliveryDate;
                    info["status"] = shippingInfo.status;
                }
            } else {
                info["shipping"] = false;
            }
    
            const customerRows = await pool.query('SELECT firstName, lastName, addressId FROM Customers WHERE id =$1', [row.customerId]);
            if (customerRows.rows.length > 0) {
                const customer = customerRows.rows[0];
                info["customerName"] = `${customer.firstName} ${customer.lastName}`;
                info["addressId"] = customer.addressId;
            }
    
            data.push(info);
        }
    
        return data;
    }
}

module.exports = Order;