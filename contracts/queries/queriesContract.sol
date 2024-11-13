// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "contracts/permissions/permissionsContract.sol";
import "contracts/patients/patientsContract.sol";

contract QueriesContract {
    PatientsContract patientsContract;
    PermissionsContract permissionsContract;

    constructor(address _patientsAddress, address _permissionsAddress) {
        patientsContract = PatientsContract(_patientsAddress);
        permissionsContract = PermissionsContract(_permissionsAddress);
    }

    function searchPatientDemographic(address _addr) public view returns(
        string memory id, 
        string memory name, 
        string memory phone, 
        string memory gender, 
        string memory dob
    ) {
        require(permissionsContract.isApproved(_addr, msg.sender), "Not authorized to view this record");
        return patientsContract.searchPatientDemographic(_addr);
    }
}