// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "contracts/doctors/doctors.sol";

contract DoctorsContract {
    address[] public doctorList;

    uint256 public doctorCount = 0;

    mapping(address => Doctors) doctors;

    mapping(address => bool) isDoctor;

    mapping(address => mapping(address => bool)) isApproved;

    function setDoctor(
        string memory _id, 
        string memory _name, 
        string memory _phone, 
        string memory _gender,
        string memory _dob,
        string memory _qualification,
        string memory _major
    ) public {
        require(!isDoctor[msg.sender], "Doctor already registered");
        Doctors storage d = doctors[msg.sender];

        d.id = _id;
        d.name = _name;
        d.phone = _phone;
        d.gender = _gender;
        d.dob = _dob;
        d.qualification = _qualification;
        d.major = _major;
        d.addr = msg.sender;
        d.timestamp = block.timestamp;

        doctorList.push(msg.sender);
        isDoctor[msg.sender] = true;
        doctorCount++;
    }

    function getDoctors() public view returns(address[] memory) {
        return doctorList;
    }
}