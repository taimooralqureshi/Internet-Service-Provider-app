import React, { Component } from 'react';
import { Table, Button, Modal } from 'react-bootstrap';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

  class TBalance extends Component{
    constructor(props){
      super(props);
      this.state={
        accounts:[], table:[], debit:[], credit:[]
      };
    }

    componentDidMount(){
      this.getAccounts();
    }

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

    getTable = name =>{
      fetch('http://localhost:4000/accounts/'+name)
      .then(res => {
        return res.json()
      })
      .then(fa_table => {
          this.setState({ table: fa_table })
      })
      .catch(err => console.error(err));
    };

    makeTable = name =>{
      this.getTable(name);
      let TCredit=0, TDebit=0;

      for(let i=0; i<this.state.table.length; i++){
        if(this.state.table[i].type=="Debit"){
          TDebit+=parseInt(this.state.table[i].amount);
          this.state.debit.push({
            "date":this.state.table[i].t_date,
            "amount":this.state.table[i].amount
          });
        }
        else{
          TCredit+=parseInt(this.state.table[i].amount);
          this.state.credit.push({
            "date":this.state.table[i].t_date,
            "amount":this.state.table[i].amount
          });
        }
      }

      while(this.state.debit.length<this.state.credit.length){
        this.state.debit.push({"date":'', "amount":''});
      }
      while(this.state.debit.length>this.state.credit.length){
        this.state.credit.push({"date":'', "amount":''});
      }

      if(TDebit-TCredit>0){
        this.state.debit.push({"date":'', "amount":TDebit-TCredit});
        this.state.credit.push({"date":'', "amount":''});
      }
      else{
        this.state.debit.push({"date":'', "amount":''});
        this.state.credit.push({"date":'', "amount":TCredit-TDebit});
      }

    }

    render(){
      return(
      <div id="tbalance">
      {
        this.state.accounts.map((item, i) => (
          this.makeTable(this.state.accounts[i].name),
          <Table bordered size="sm" style={{textAlign:"left"}}>
            <thead style={{backgroundColor:"white", borderBottom:"3px solid #ec9841", textAlign:"center"}}>
              <tr>
                <th colspan="2">{item.name}</th>
              </tr>
              <tr>
                <th>Debit</th>
                <th>Credit</th>
              </tr>
            </thead>
            <tbody>
              {
                this.state.debit.map((items, j) => (
                  <tr>
                    <td>{this.state.debit[j].date}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{this.state.debit[j].amount}</td>
                    <td>{this.state.credit[j].date}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{this.state.credit[j].amount}</td>
                  </tr>
                ))
              }
            </tbody>
          </Table>
        ))
      }\
      </div>
    );
  }
}

export default TBalance;
