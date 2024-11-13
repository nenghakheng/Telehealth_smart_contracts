// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PermissionsContract {
    mapping(address => mapping(address => bool)) public isApproved;
    uint256 permissionGrantedCount = 0;

    function grantPermission(address _addr) public returns(bool){
        isApproved[msg.sender][_addr] = true;
        permissionGrantedCount++;
        return true;
    }

    function revokePermisson(address _addr) public  returns(bool) {
        isApproved[msg.sender][_addr] = false;
        return true;
    } 

    function checkPermission(address patientAddr, address callerAddr) public view returns(bool) {
        return isApproved[patientAddr][msg.sender];
    }
}