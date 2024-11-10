// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PatientsContract.sol";

contract HealthcareProviderContract {
    PatientContract private patientContract;

    constructor(address _patientContractAddress) {
        patientContract = PatientContract(_patientContractAddress);
    }

    event PatientDataValidated(address indexed doctor, address indexed patient);

    // Function for doctor to validate patient data
    function validateData(address _patient, string memory _data) public {
        // Assume the doctor is a validator, proceed with validation logic
        // Only verified doctors could use this function in production
        patientContract.addPatientData(_data);
        emit PatientDataValidated(msg.sender, _patient);
    }
}
