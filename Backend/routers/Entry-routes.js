const router = require('express').Router();
const connection = require('../db');

router.get('/', (req,res) => {
    connection.query('CALL entries_data()', (err, result) => {
        if (err) throw err;
        else
          return res.json(result[0])
    });
});

router.get('/raw', (req,res) => {
    connection.query('select * from fa_Entry', (err, result) => {
        if (err) throw err;
        else
          return res.json(result);
    });
});

router.get('/raw/:id', function (req, res) {
    let id = req.params.id;

    connection.query("select * from fa_Entry where id = ?",id, (err, result) => {
        if (err) throw err;
        else
          return res.json(result[0])
    });

});


router.get('/:id', function (req, res) {
    let id = req.params.id;

    connection.query("call entry_data(?)",id, (err, result) => {
        if (err) throw err;
        else
          return res.json(result[0][0])
    });

});





//  Create New Customer
router.post('/', (req, res) => {
    let entry = req.body;

    connection.query("Insert into fa_Entry set ?; ", entry, (err, result) => {
        if (err) throw err;
        else
        {
            return res.send({ error: false, data: result, message: 'New entry has been created successfully.' });
        }
    });

});

// Update an existing customer
router.put('/:id', (request, response) => {
    const id = request.params.id;

    connection.query('UPDATE fa_Entry SET ? WHERE id = ?', [request.body, id], (error, result) => {
        if (error) throw error;

        response.send('Entry updated successfully.');
    });
});

// Delete a  Customer
router.delete('/:id', (request, response) => {
    const id = request.params.id;

    connection.query('DELETE FROM fa_Entry WHERE id = ?', id, (error, result) => {
        if (error) throw error;

        response.send('Entry deleted.');
    });
});

module.exports = router;
