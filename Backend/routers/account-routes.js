const router = require('express').Router();
const connection = require('./../db');

router.get('/', (req,res) => {
    connection.query('SELECT * FROM fa_account', (err, result) => {
        if (err) throw err;
        else
          return res.json(result)
    });
});


router.get('/:account', (req,res) => {
    let account_name = req.params.account;
    
    connection.query('call T_Account(?) ',account_name, (err, result) => {
        if (err) throw err;
        else
          return res.json(result[0])
    });
});



module.exports = router;