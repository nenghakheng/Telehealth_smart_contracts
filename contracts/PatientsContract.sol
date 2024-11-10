// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PatientContract {
    struct PatientData {
        string medicalHistory;
        bool exists;
    }

    struct AccessRequest {
        address doctor;
        bool approved;
    }

    mapping(address => PatientData) private patientRecords;
    mapping(address => mapping(address => AccessRequest)) private accessPermissions; // patient -> doctor -> access request

    event DataAccessRequested(address indexed patient, address indexed doctor);
    event DataAccessGranted(address indexed patient, address indexed doctor);
    event DataAdded(address indexed patient, string medicalHistory);

    modifier onlyPatient(address _patient) {
        require(msg.sender == _patient, "Only the patient can perform this action");
        _;
    }

    // Add or update patient data
    function addPatientData(string memory _medicalHistory) public {
        patientRecords[msg.sender] = PatientData(_medicalHistory, true);
        emit DataAdded(msg.sender, _medicalHistory);
    }

    // Request data access
    function requestAccess(address _patient) public {
        require(patientRecords[_patient].exists, "Patient does not exist");
        accessPermissions[_patient][msg.sender] = AccessRequest(msg.sender, false);
        emit DataAccessRequested(_patient, msg.sender);
    }

    // Approve access request
    function approveAccess(address _doctor) public onlyPatient(msg.sender) {
        accessPermissions[msg.sender][_doctor].approved = true;
        emit DataAccessGranted(msg.sender, _doctor);
    }

    // Retrieve patient data if access is granted
    function getPatientData(address _patient) public view returns (string memory) {
        require(accessPermissions[_patient][msg.sender].approved, "Access not granted");
        return patientRecords[_patient].medicalHistory;
    }
}
