
const Order = require('../models/Order');

/*
    Obviously you wouldn't return error messages like this, but this is development only for now
*/

exports.createOrder = async (req, res) => {
    try {
        const order = new Order(req.body);
        await order.save();
        res.status(201).json(order);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

exports.getOrderbyId = async (req, res) => {
    try {
        console.log(req.params); // TESTING
        const order = await Order.findById(req.params.orderId);
        if (!order) {
            return res.status(404).json({ message: 'Order not found' });
        }
        res.status(201).json(order);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

exports.getAllOrders = async (req, res) => {
    try {
        const order = await Order.findAll();

        if (!order) {
            return res.status(404).json({ message: 'No Orders Found' });
        }

        res.status(201).json(order);

    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

exports.updateOrder = async (req, res) => {
    res.send('Not implemented yet');
}

exports.deleteOrder = async (req, res) => {
    res.send('Not implemented yet');
}