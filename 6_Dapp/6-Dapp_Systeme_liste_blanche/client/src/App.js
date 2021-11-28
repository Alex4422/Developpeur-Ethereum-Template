import React, { Component } from "react";
import 'bootstrap/dist/css/bootstrap.min.css';
import Button from 'react-bootstrap/Button';
import Form from 'react-bootstrap/Form';
import Card from 'react-bootstrap/Card';
import ListGroup from 'react-bootstrap/ListGroup';
import Table from 'react-bootstrap/Table';
import WhitelistContract from "./contracts/Whitelist.json";
import getWeb3 from "./getWeb3";



import "./App.css";

class App extends Component {
  state = { storageValue: 0, web3: null, accounts: null, contract: null, whitelist: null };

  componentDidMount = async () => {
    try {
      // Get network provider and web3 instance.
      const web3 = await getWeb3();

      // Use web3 to get the user's accounts.
      const accounts = await web3.eth.getAccounts();

      // Get the contract instance.
      const networkId = await web3.eth.net.getId();
      const deployedNetwork = WhitelistContract.networks[networkId];
      const instance = new web3.eth.Contract(
          WhitelistContract.abi,
        deployedNetwork && deployedNetwork.address,
      );

      // Set web3, accounts, and contract to the state, and then proceed with an
      // example of interacting with the contract's methods.
      this.setState({ web3, accounts, contract: instance }, this.runExample);
    } catch (error) {
      // Catch any errors for any of the above operations.
      alert(
        `Failed to load web3, accounts, or contract. Check console for details.`,
      );
      console.error(error);
    }
  };

  /**
   *
   * @returns {Promise<void>}
   */
  runInit = async() => {
    const { accounts, contract } = this.state;

    //Get the authorised account list
    const whitelist = await contract.methods.getAddresses().call();

    //update the state
    this.setState({whitelist: whitelist});
  };

  /**
   *
   * @returns {Promise<void>}
   */
  whitelist = async() => {
    const { accounts, contract} = this.state;
    const address = this.address.value;

    //Interaction with the smart contract to add an account
    await contract.methods.whitelist(address).send({from: accounts[0]});

    //get the list of authorised account list
    this.runInit();
  }




  render(){
    const { whitelist } = this.state;
    if (!this.state.web3) {
      return <div>Loading Web3, accounts, and contract...</div>;
    }

    return (

        <div className="App">
          Hi, this is Alex!

          <div>
            <h2 className="text-center">Système d'une liste blanche</h2>
            <hr></hr>
            <br></br>
          </div>
          <div style={{display: 'flex', justifyContent: 'center'}}>
            <Card style={{ width: '50rem' }}>
              <Card.Header><strong>Liste des comptes autorisés</strong></Card.Header>
              <Card.Body>
                <ListGroup variant="flush">
                  <ListGroup.Item>
                    <Table striped bordered hover>
                      <thead>
                      <tr>
                        <th>@</th>
                      </tr>
                      </thead>
                      <tbody>
                      {whitelist !== null &&
                      whitelist.map((a) => <tr><td key="{a}">{a}</td></tr>)
                      }
                      </tbody>
                    </Table>
                  </ListGroup.Item>
                </ListGroup>
              </Card.Body>
            </Card>
          </div>
          <br></br>
          <div style={{display: 'flex', justifyContent: 'center'}}>
            <Card style={{ width: '50rem' }}>
              <Card.Header><strong>Autoriser un nouveau compte</strong></Card.Header>
              <Card.Body>
                <Form.Group controlId="formAddress">
                  <Form.Control type="text"
                                ref={(input) => { this.address = input }}
                  />
                </Form.Group>
                <Button onClick={ this.whitelist } variant="dark" > Autoriser </Button>
              </Card.Body>
            </Card>
          </div>
          <br></br>

        </div>

    )

  }

}







export default App;