import React, { Component } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import GeneralJournal from './GeneralJournal';
import TBalance from './TBalance';
import TrialBalance from './TrialBalance';
import './Navbar.css';

  class Transactions extends Component{
    constructor(props){
      super(props);
      this.state={
        GenJ:true, TBalance:false, TrialBalance:false
      };
    }

    //-------------------GJ, Tbalance, TrialBalance display functions for navbar--------------------------------------------

    displayGenJournal=() => {
      this.setState({
        GenJ:true,
        TBalance:false,
        TrialBalance:false
      });
    };

    displayTBalance=() => {
      this.setState({
        GenJ:false,
        TBalance:true,
        TrialBalance:false
      });
    };

    displayTrialBalance=() => {
      this.setState({
        GenJ:false,
        TBalance:false,
        TrialBalance:true
      });
    };

    render(){
      return(
      <div className="pageMargin transactions">
        {
          // ------------------------------------top menu--------------------------------------------------------
        }
        <div className="topmenu">
          <a onClick={()=> this.displayGenJournal()}>General Journal</a>
          <a onClick={()=> this.displayTBalance()}>T-Balance</a>
          <a onClick={()=> this.displayTrialBalance()}>Trial Balance</a>
        </div>

        {
         //-----------------------------------------------------------------------------------------------------------
         //--------------------------------General Journal------------------------------------------------------------
         //-----------------------------------------------------------------------------------------------------------
        }
        {
          this.state.GenJ && <GeneralJournal/>
        }

        {
         //-----------------------------------------------------------------------------------------------------------
         //--------------------------------TBalance------------------------------------------------------------
         //-----------------------------------------------------------------------------------------------------------
        }
        {
          this.state.TBalance && <TBalance/>
        }

        {
         //-----------------------------------------------------------------------------------------------------------
         //--------------------------------Trial Balance------------------------------------------------------------
         //-----------------------------------------------------------------------------------------------------------
        }
        {
          this.state.TrialBalance && <TrialBalance/>
        }

      </div>
    );
  }
}
export default Transactions;
