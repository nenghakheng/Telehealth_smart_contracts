// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "contracts/patients/patients.sol";
import "contracts/permissions/permissionsContract.sol";

contract PatientsContract {
    // Instance of PermissionsContract
    PermissionsContract permissionsContract;

    constructor(address _permissionsContract) {
        permissionsContract = PermissionsContract(_permissionsContract);
    }

    // Variables to store data
    address[] public patientList; 

    mapping(address => Patients) patients;

    // Variables for state check
    mapping(address => bool) isPatient;

    // Variables for counting
    uint256 public patientCount = 0;

    function getPatients() public  view returns(address[] memory) {
        return patientList;
    }

    function setPatient(
        string memory _ic, 
        string memory _name, 
        string memory _phone, 
        string memory _gender, 
        string memory _dob, 
        // string memory _height, 
        // string memory _weight, 
        string memory _houseAddr,
        string memory _bloodGroup,
        string memory _diagnoses,
        string memory _medication
        // string memory _emergencyName,
        // string memory _emergencyContact,
    ) public {
        // Check if msg.sender is already a patient
        require(!isPatient[msg.sender], "Patient already registered.");
        Patients storage p = patients[msg.sender];

        p.ic = _ic;
        p.name = _name;
        p.phone = _phone;
        p.gender = _gender;
        p.dob = _dob;
        // p.height = _height;
        // p.weight = _weight;
        p.houseAddr = _houseAddr;
        p.bloodGroup = _bloodGroup;
        p.diagnoses = _diagnoses;
        p.medication = _medication;
        // p.emergencyName = _emergencyName;
        // p.emergencyContact = _emergencyContact;
        p.addr = msg.sender;
        p.timestamp = block.timestamp;

        patientList.push(msg.sender);
        isPatient[msg.sender] = true;
        permissionsContract.grantPermission(msg.sender);
        patientCount++;
    }

    // Edit patient function
    function editPatient() public {}
    
    function searchPatientDemographic(address _addr) public view returns(
        string memory id, 
        string memory name, 
        string memory phone, 
        string memory gender, 
        string memory dob
    ) {
        Patients storage p = patients[_addr];

        return (p.ic, p.name, p.phone, p.gender, p.dob);
    }

    
    function searchPatientMedical(address _addr) public view returns(
        string memory homeAddr, 
        string memory bloodGroup, 
        string memory diagnoses, 
        string memory medication
    ) {
        Patients storage p = patients[_addr];

        return (p.houseAddr, p.bloodGroup, p.diagnoses, p.medication);
    }
}