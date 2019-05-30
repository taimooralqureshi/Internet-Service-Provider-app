const router = require('express').Router();
const connection = require('./../db');
const DEVICE_QUERY = "SELECT * FROM device";

router.get('/', (req,res) => {
    connection.query(DEVICE_QUERY, (err, result) => {
        if (err) throw err;
        else
          return res.json(result)
    });
});

//  Retrieve user with id 
router.get('/:id', function (req, res) {
    let id = req.params.id;
    connection.query(DEVICE_QUERY+' where id=?', id, (err, result) => {
        if (err) throw err;
        else
          return res.json(result)
    });
   
});

//  Create New Device  
router.post('/', (req, res) => {
    let device = req.body;
    
    connection.query("Insert into device set ?; ", device, (err, result) => {
        if (err) throw err;
        else
        {
            return res.send({ error: false, data: result, message: 'New device has been created successfully.' });
        }
    });
   
});


// Update an existing device
router.put('/:id', (request, response) => {
    const id = request.params.id;
 
    connection.query('UPDATE device SET ? WHERE id = ?', [request.body, id], (error, result) => {
        if (error) throw error;
 
        response.send('Device updated successfully.');
    });
});

// Delete a device
router.delete('/:id', (request, response) => {
    const id = request.params.id;
 
    connection.query('DELETE FROM device WHERE id = ?', id, (error, result) => {
        if (error) throw error;
 
        response.send('Device deleted.');
    });
});

module.exports = router;