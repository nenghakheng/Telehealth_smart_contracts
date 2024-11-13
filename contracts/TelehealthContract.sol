// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "contracts/doctors/doctorsContract.sol";
import "contracts/patients/patientsContract.sol";
import "contracts/permissions/permissionsContract.sol";
import "contracts/queries/queriesContract.sol";

contract TelehealthContract {
    address owner;
    DoctorsContract doctorsContract;
    PatientsContract patientsContract;
    PermissionsContract permissionsContract;
    QueriesContract queriesContract;

    constructor(
        address _doctorsAddress,
        address _patientsAddress,
        address _permissionAddress,
        address _queriesAddress
    ) {
        owner = msg.sender;
        doctorsContract = DoctorsContract(_doctorsAddress);
        patientsContract = PatientsContract(_patientsAddress);
        permissionsContract = PermissionsContract(_permissionAddress);
        queriesContract = QueriesContract(_queriesAddress);
    }

    function registerDoctor(
        string memory _id, 
        string memory _name, 
        string memory _phone, 
        string memory _gender,
        string memory _dob,
        string memory _qualification,
        string memory _major
    ) public {
        doctorsContract.setDoctor(_id, _name, _phone, _gender, _dob, _qualification, _major);
    }

    function registerPatient(
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
        patientsContract.setPatient(_ic, _name, _phone, _gender, _dob, _houseAddr, _bloodGroup, _diagnoses, _medication);
    }

    function getDoctors() public view returns(address[] memory) {
        return doctorsContract.getDoctors();
    }

    function getPatients() public view returns(address[] memory) {
        return patientsContract.getPatients();
    }

    function grantPermission(address _addr) public returns(bool){
        return permissionsContract.grantPermission(_addr);
    }

    function getPatientDemographic(address _addr) public view returns(
        string memory id, 
        string memory name, 
        string memory phone, 
        string memory gender, 
        string memory dob
    ) {
        return queriesContract.searchPatientDemographic(_addr);
    }
}