const express = require('express');
const orderController = require('../controllers/orderController');

const router = express.Router();

router.post('/', orderController.createOrder);
router.get('/:orderId', orderController.getOrderbyId);
router.get('/', orderController.getAllOrders);
router.get('/company/:companyId', orderController.getOrderByCompanyId);
router.put('/:orderId', orderController.updateOrder);
router.delete('/orderId', orderController.deleteOrder);
router.get('/complete-order/:companyId', orderController.getCompleteOrder);

module.exports = router;