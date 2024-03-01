
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
    const { orderId } = req.params;
    const updateFields = req.body;

    try {

        const updatedOrder = await Order.update(orderId, updateFields);

        if (updatedOrder) {
            res.json({
                message: 'Order Updated Successfully',
                order: updatedOrder
            })
        } else {
            res.status(404).json({ message: "Order not found" });
        }

    } catch (error) {
        res.status(500).json({ message: 'Error updating order' });
    }
}

exports.deleteOrder = async (req, res) => {
    const { orderId } = req.params;

    try {

        const deletedOrder = await Order.delete(orderId);

        if (deletedOrder) {
            return res.status(201).json({ message: 'Order successfully deleted' });
        } else {
            return res.status(404).json({ message: "Order not found" });
        }

    } catch (error) {
        res.status(500).json({ message: 'Error deleting order' });
    }
}

exports.getOrderByCompanyId = async (req, res) => {
    try {
        console.log(req.params); // TESTING
        const order = await Order.findOrdersByCompany(req.params.companyId);
        if (!order) {
            return res.status(404).json({ message: 'Order not found' });
        }
        res.status(201).json(order);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

exports.getCompleteOrder = async (req, res) => {
    const { companyId } = req.params;
    
    try {
        console.log(companyId);
        const orders = await Order.getCompleteOrdersByCompanyId(companyId);

        if (!orders) {
            return res.status(404).json({ message: "No Orders Found" });
        }

        res.json(orders);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: "Error fetching order information" });
    }
}