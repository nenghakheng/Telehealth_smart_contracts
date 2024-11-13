## Telehealth Smart Contract System
### This project includes Solidity contracts for a telehealth platform, managing permissions, doctors, patients, and data queries.

### Contract Overview
- PermissionsContract: Manages access permissions.
- PatientsContract: Manages patient registration and data.
- DoctorsContract: Manages doctor registration and data.
- QueriesContract: Allows authorized users to query patient data.
- TelehealthContract: Main contract integrating all functionalities.

### Deployment Order
- Deploy PermissionsContract – Manages access permissions.
- Deploy PatientsContract – Requires PermissionsContract address.
- Deploy QueriesContract – Requires PermissionsContract and PatientsContract addresses.
- Deploy DoctorsContract – No dependencies.
- Deploy TelehealthContract – Requires addresses of all contracts above.

### Basic Usage
- Register Doctor: registerDoctor(...)
- Register Patient: registerPatient(...)
- Grant Permission: grantAccessPermission(address _addr)
- Query Patient Data: getPatientDemographics(address _patientAddress)

### Notes
Deploy contracts in order to avoid dependency issues.
Interact primarily through TelehealthContract.