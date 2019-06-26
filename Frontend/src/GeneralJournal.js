import React, { Component } from 'react';
import { Table, Button, Modal } from 'react-bootstrap';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

  class GeneralJournal extends Component{
    constructor(props){
      super(props);
      this.state={
        showPopup:false, debitInput:[], creditInput:[],
        d_desc: '', d_amount: '', d_type: '', c_desc: '', c_amount: '', c_type: '', date:'', err:'', entry:"Normal",
        entries:[], transactions:[], GJtable:[],accounts:[]
      };
    }

    //-----------------------------------Database functions start-------------------------------------------------------

    componentDidMount(){
      this.getEntries();
      this.getTransactions();
      this.getAccounts();
    }

    getEntries = _ =>{
        fetch('http://localhost:4000/entries')
        .then(res => {
          return res.json()
       })
      .then(fa_Entry => {
        
                  
          this.setState({ entries: fa_Entry })
       })
        .catch(err => console.error(err));
    };

    getTransactions = _ =>{
        fetch('http://localhost:4000/transactions')
        .then(res => {
          return res.json()
       })
      .then(fa_transactions => {
          this.setState({ transactions: fa_transactions })
       })
        .catch(err => console.error(err));
    };

    getAccounts = _ =>{
      fetch('http://localhost:4000/accounts')
      .then(res => {
        return res.json()
     })
    .then(fa_accounts => {
        this.setState({ accounts: fa_accounts })
     })
      .catch(err => console.error(err));
  };


    addEntry = entry =>
    {
      fetch('http://localhost:4000/entries/',{
        method : 'POST',
        headers: {'Content-Type':'application/json'},
        body : JSON.stringify(entry)
      })
      .then(res => {
        this.getEntries();
        return res.json();
      })
      .catch(err => console.error(err));
    };

    addTransaction = trans =>
    {
      console.log(trans);

      fetch('http://localhost:4000/transactions/',{
        method : 'POST',
        headers: {'Content-Type':'application/json'},
        body : JSON.stringify(trans)

      })
      .then(res => {
        this.getTransactions();
        return res.json();
      })
      .catch(err => console.error(err));
    };

    deleteEntry = id =>{
      fetch('http://localhost:4000/entries/'+id,{method : 'DELETE'})
      .then(res => {
        this.getEntries();
        return res.json();
       })
      .catch(err => console.error(err));
    };

    //-----------------------------------Database functions ends--------------------------------------------------------

    //-----------------------------------Toggle functions start--------------------------------------------------------

    handleClose=()=> {
      this.setState({
        showPopup: false,
        d_desc:'', d_amount:'', d_type:'',
        c_desc:'', c_amount:'', c_type:'',
        date:'', err:'', chkbox:false,
        debitInput:[],
        creditInput:[]
      });
    }

    handleShow=()=> {
      this.setState({ showPopup: true });
    }

    toggleCheckox=()=> {
      this.setState({ chkbox: !this.state.chkbox });
    }

    change = e => {
      this.setState({
        [e.target.name]: e.target.value
      });
    };

    //-----------------------------------Toggle functions ends--------------------------------------------------------

    //-----------------------------------Add Delete functions start--------------------------------------------------------

    addDebit = () =>{
      if(this.state.d_desc=='' || this.state.d_amount==0 || this.state.d_type==''){
        this.setState({ err : 'empty field!' });
      }
      else{
        var input={description:this.state.d_desc, amount:this.state.d_amount, type:this.state.d_type}
        this.state.debitInput.push(input);
        this.setState({
          d_desc:'', d_amount:'', d_type:'', err:''
        });
      }
    };

    addCredit = () =>{
      if(this.state.c_desc=='' || this.state.c_amount==0 || this.state.c_type==''){
        this.setState({ err : 'empty field!' });
      }
      else{
        var input={description:this.state.c_desc, amount:this.state.c_amount, type:this.state.c_type}
        this.state.creditInput.push(input);
        this.setState({
          c_desc:'', c_amount:'', c_type:'', err:''
        });
      }
    };

    add = states => {

      let creditAmount=0, debitAmount=0;
      for(let i=0; i<states.debitInput.length; i++){
        debitAmount+=parseInt(states.debitInput[i].amount);
      }
      for(let i=0; i<states.creditInput.length; i++){
        creditAmount+=parseInt(states.creditInput[i].amount);
      }

      if(states.date=='' || states.debitInput.length==0 || states.creditInput.length==0){
        this.setState({
          err : 'empty field!'
        });
      }
      else if(debitAmount!=creditAmount){
        this.setState({
          err : 'inequal debit and credit amount!'
        });
      }
      else{
        var custom_trans = {
          "date": this.state.date,
          "trans_type": this.state.entry
        }
        this.addTransaction(custom_trans);

        for(let i=0; i<this.state.debitInput.length; i++)
        {
          var custom_entry = {
            "type": "Debit",
            "amount": this.state.debitInput[i].amount,
            "account_name": this.state.debitInput[i].description,
            "trans_id": this.state.transactions[this.state.transactions.length-1].id
          }
          this.addEntry(custom_entry);
        }
        for(let i=0; i<this.state.creditInput.length; i++)
        {
          var custom_entry = {
            "type": "Debit",
            "amount": this.state.creditInput[i].amount,
            "account_name": this.state.creditInput[i].description,
            "trans_id": this.state.transactions[this.state.transactions.length-1].id
          }
          this.addEntry(custom_entry);
        }

        this.handleClose();
      }

    };

    delete = (index, rows) => {
      rows.splice(index,1);
    };


    //-----------------------------------Add Delete functions ends--------------------------------------------------------

    //-----------------------------------Data processing functions start--------------------------------------------------------

    transDate = date => {
      var t_date =new Date(date);
      console.log(t_date);
      
     return t_date.getDate()+"/"+t_date.getMonth()+"/"+t_date.getFullYear();

   };
    maketable = () =>{
      let temp=this.state.entries;
      let debit=[], credit=[], debit_amount=[], credit_amount=[], table=[], key=0, date='', entry='';

      for(let i=0; i<temp.length; i++){
        if(temp[i].trans_id==key){
          if(temp[i].type=="Debit"){
            debit_amount.push(temp[i].amount);
            debit.push(temp[i].account_name);
          }
          else{
            credit_amount.push(temp[i].amount);
            credit.push(temp[i].account_name);
          }
        }
        else{
          table.push({
            "date":date,
            "entry":entry,
            "debit":debit,
            "credit":credit,
            "debit_amount":debit_amount,
            "credit_amount":credit_amount
          });
          key=temp[i].trans_id;
          date=temp[i].trans_date;
          entry=temp[i].trans_type;
          debit=[]; credit=[]; debit_amount=[]; credit_amount=[];
          i--;
        }
      }
      this.state.GJtable=table;
    }

    //-----------------------------------Data processing functions ends--------------------------------------------------------

    render(){
      return(
      <div id="GJ">
        {
        //------------------------------------------display table-------------------------------------------------
        }
        <Button id="addBtn" onClick={this.handleShow}>Add</Button><br/>
        <Table bordered size="sm"  style={{textAlign:"left"}}>
          <thead style={{backgroundColor:"white", borderBottom:"3px solid #ec9841"}}>
            <tr>
              <th>Date</th>
              <th>Entry</th>
              <th>General Journal</th>
              <th>Amount</th>
              <th>Delete</th>
            </tr>
          </thead>
          <tbody>
          {this.maketable()}
          {
            this.state.GJtable.map((item, i) => (
              <tr key={i}>
                <td>{item.date}</td>
                <td>{item.entry}</td>
                <td>
                  <div>{this.state.GJtable[i].debit.map((items, j) => (items))}</div>
                  <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{this.state.GJtable[i].credit.map((items, j) => (items))}</div>
                </td>
                <td>
                  <div>{item.debit_amount.map((items, j) => (items))}</div>
                  <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{item.credit_amount.map((items, j) => (items))}</div>
                </td>
                <td><a href="#" onClick={() =>
                  {
                    if (window.confirm('Are you sure you wish to delete this item?'))
                      this.deleteEntry(item.trans_id) }
                  }>
                  <FontAwesomeIcon className="icon" icon="trash" style={{marginLeft:"20%", color:"red"}} /></a>
                </td>
              </tr>
            ))
          }
          </tbody>
        </Table>

        {
          //----------------------------------------add button popup--------------------------------------------------
        }
        <Modal size="lg" show={this.state.showPopup} onHide={this.handleClose}>
          <Modal.Header closeButton>
            <Modal.Title>Add Transaction</Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <Table bordered size="sm">
              <thead  style={{color:"white", backgroundColor:"#ec9841"}}>
                <tr>
                  <th style={{backgroundColor:"white"}}></th>
                  <th>General Journal</th>
                  <th>Amount</th>
                  <th>Type</th>
                  <th>Action</th>
                </tr>
              </thead>
              <tbody>
              {
                //----------------display debit fields---------------------------
              }
                {
                  this.state.debitInput.map((item, i) => (
                  <tr key={i}>
                    <td style={{color:"white", backgroundColor:"#ec9841"}}>Debit</td>
                    <td>{item.description}</td>
                    <td>{item.amount}</td>
                    <td>{item.type}</td>
                    <td><a href="#" onClick={() => { if (window.confirm('Are you sure you wish to delete this item?')) this.delete(i, this.state.debitInput) } }>Delete</a></td>
                  </tr>
                  ))
                }
                {
                  //----------------input debit fields---------------------------
                }
                <tr>
                  <td style={{color:"white", backgroundColor:"#ec9841"}}>Debit</td>
                  <td><input type="text" name="d_desc" value={this.state.d_desc} onChange={e => this.change(e)}/></td>
                  <td><input type="number" name="d_amount" value={this.state.d_amount} onChange={e => this.change(e)}/></td>
                  <select name="d_type" value={this.state.d_type} onChange={e => this.change(e)}>
                    <option>Select</option>
                    { this.state.accounts.map((account) => <option value={account.id} >{account.name}</option>) }
                  </select>
                  <td><FontAwesomeIcon style={{color:"blue"}} onClick={()=> this.addDebit()} icon="plus" /></td>
                </tr>
                {
                  //----------------display credit fields---------------------------
                }
                {
                  this.state.creditInput.map((item, i) => (
                  <tr key={i}>
                    <td style={{color:"white", backgroundColor:"#ec9841"}}>Credit</td>
                    <td>{item.description}</td>
                    <td>{item.amount}</td>
                    <td>{item.type}</td>
                    <td><a href="#" onClick={() => { if (window.confirm('Are you sure you wish to delete this item?')) this.deleteDebit(i, this.state.creditInput) } }>Delete</a></td>
                  </tr>
                  ))
                }
                {
                  //----------------input credit fields---------------------------
                }
                <tr>
                  <td style={{color:"white", backgroundColor:"#ec9841"}}>Credit</td>
                  <td><input type="text" name="c_desc" value={this.state.c_desc} onChange={e => this.change(e)}/></td>
                  <td><input type="number" name="c_amount" value={this.state.c_amount} onChange={e => this.change(e)}/></td>
                  <select name="c_type" value={this.state.c_type} onChange={e => this.change(e)}>
                    <option>Select</option>
                    { this.state.accounts.map((account) => <option value={account.id} >{account.name}</option>) }
                  </select>
                  <td><FontAwesomeIcon style={{color:"blue"}} onClick={()=> this.addCredit()} icon="plus" /></td>
                </tr>
              </tbody>
            </Table>
            <label>Date:</label> &nbsp;
            <input type="date" name="date" value={this.state.date} onChange={e => this.change(e)}/>
            <span style={{color:"red"}}>{this.state.err}</span>
            <select style={{float:"right", margin:"7px 25px 0 0"}} name="entry" value={this.state.entry} onChange={e => this.change(e)}>
              <option>Normal</option>
              <option>Adjustment</option>
              <option>Closing</option>
            </select>
            <label style={{float:"right", marginRight:"5px", marginTop:"5px"}} for="entry">Entry Type:</label>
          </Modal.Body>
          <Modal.Footer>
            <Button variant="secondary" onClick={this.handleClose}>Close</Button>
            <Button variant="primary" onClick={()=> this.add(this.state)}>Add</Button>
          </Modal.Footer>
        </Modal>

      </div>
    );
  }
}

export default GeneralJournal;
