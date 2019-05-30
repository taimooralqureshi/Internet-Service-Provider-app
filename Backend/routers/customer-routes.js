const router = require('express').Router();
const connection = require('./../db');

router.get('/', (req,res) => {
    connection.query('CALL customers_data()', (err, result) => {
        if (err) throw err;
        else
          return res.json(result[0])
    });
});

router.get('/:id', function (req, res) {
    let id = req.params.id;
        
    connection.query("call customer_data(?)",id, (err, result) => {
        if (err) throw err;
        else
          return res.json(result[0])
    });
   
});


router.get('/raw', (req,res) => {
    connection.query('select * from customer', (err, result) => {
        if (err) throw err;
        else
          return res.json(result);
    });
});

router.get('/raw/:id', function (req, res) {
    let id = req.params.id;
        
    connection.query("select * from customer where id = ?",id, (err, result) => {
        if (err) throw err;
        else
          return res.json(result[0])
    });
   
});



//  Create New Customer  
router.post('/', (req, res) => {
    let customer = req.body;
    
    connection.query("Insert into customer set ?; ", customer, (err, result) => {
        if (err) throw err;
        else
        {
            return res.send({ error: false, data: result, message: 'New customer has been created successfully.' });
        }
    });
   
});

// Update an existing customer
router.put('/:id', (request, response) => {
    const id = request.params.id;
 
    connection.query('UPDATE customer SET ? WHERE id = ?', [request.body, id], (error, result) => {
        if (error) throw error;
 
        response.send('customer updated successfully.');
    });
});

// Delete a  Customer
router.delete('/:id', (request, response) => {
    const id = request.params.id;
 
    connection.query('DELETE FROM customer WHERE id = ?', id, (error, result) => {
        if (error) throw error;
 
        response.send('customer deleted.');
    });
});

module.exports = router;