const Web3 = require('web3');
const web3 = new Web3('HTTP://127.0.0.1:7545');


function submitForm() {
    const parkingTime = parseFloat(document.getElementById("parking_time").value);
    const plateNumber = document.getElementById("plate_number").value;
    const fromAccount = document.getElementById("ethereum_account").value;
    const toAccount = document.getElementById("to_account").value;
    console.log("Parking Time:", parkingTime);
    console.log("Plate Number:", plateNumber);
    console.log("From Account:", fromAccount);
    console.log("To Account:", toAccount);
    return null;
}
