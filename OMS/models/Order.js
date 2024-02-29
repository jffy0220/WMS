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
}

module.exports = Order;