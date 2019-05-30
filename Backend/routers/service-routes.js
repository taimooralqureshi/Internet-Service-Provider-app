const router = require('express').Router();
const connection = require('./../db');
const SERVICE_QUERY = "SELECT * FROM service";

router.get('/', (req,res) => {
    connection.query(SERVICE_QUERY, (err, result) => {
        if (err) throw err;
        else
          return res.json(result)
    });
});

//  Retrieve user with id 
router.get('/:id', function (req, res) {
    let id = req.params.id;
    connection.query(SERVICE_QUERY+ " where id= ?", id, (err, result) => {
        if (err) throw err;
        else
          return res.json(result)
    });
   
});

//  Create New Device  
router.post('/', (req, res) => {
    let service = req.body;
    
    connection.query("Insert into service set ?; ", service, (err, result) => {
        if (err) throw err;
        else
        {
            return res.send({ error: false, data: result, message: 'New service has been created successfully.' });
        }
    });
   
});


// Update an existing Service
router.put('/:id', (request, response) => {
    const id = request.params.id;
 
    connection.query('UPDATE service SET ? WHERE id = ?', [request.body, id], (error, result) => {
        if (error) throw error;
 
        response.send('Service updated successfully.');
    });
});

// Delete a Service
router.delete('/:id', (request, response) => {
    const id = request.params.id;
 
    connection.query('DELETE FROM service WHERE id = ?', id, (error, result) => {
        if (error) throw error;
 
        response.send('Service deleted.');
    });
});

module.exports = router;