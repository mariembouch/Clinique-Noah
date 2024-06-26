// SPDX-License-Identifier: MIT

pragma solidity >=0.4.22 <0.9.0;

contract Auth {

    address public adminAddress;
    bool public adminCreated;
    string public adminUsername;
    string public adminEmail;
    string public adminPassword;
    Account[] public AllAccounts;


    event AdminCreated(
        address add,
        string username,
        string email,
        string password
    );
    constructor() {
        adminAddress = 0xA598B97C46320Cc45AeE4110B715BA998A4D4e5a;
        adminUsername = "Mariem Turki";
        adminEmail = "mariem.turki@isimg.tn";
        adminPassword = "mariem123";
        adminCreated = true;
        emit AdminCreated(
            adminAddress,
            adminUsername,
            adminEmail,
            adminPassword
        );
        AllAccounts.push(Account(adminAddress, adminEmail, adminPassword, "admin"));
    }

    function getAdminAddress() public view returns (address) {
        return adminAddress;
    }

    function getEmailAdmin() public view returns (string memory) {
        return adminEmail;
    }

    function getPasswordAdmin() public view returns (string memory) {
        return adminPassword;
    }


    bool public doctorCreated;

    struct Doctor {
        address add;
        string username;
        string email;
        string password;
        string service;
    }
    mapping(string => Doctor) public doctorsList;
    mapping(string => Doctor[]) public doctorsByService; 
    address[] public doctorAddresses;

    event DoctorCreated(
        address add,
        string username,
        string email,
        string password,
        string service
    );

    function createDoctor(address _add, string memory _username, string memory _email, string memory _password,string memory _service) public {
        require(msg.sender == adminAddress, "Only admin can create doctor");
        doctorsList[_email] = Doctor(_add, _username, _email, _password,_service);
        doctorsByService[_service].push(Doctor(_add, _username, _email, _password, _service));
        AllAccounts.push(Account(_add, _email, _password, "doctor"));
        doctorAddresses.push(_add);
        doctorCreated = true;
        emit DoctorCreated(_add, _username, _email, _password,_service);
    }


     function getDoctorsByService(string memory _service) public view returns (string[] memory) {
        uint256 count = doctorsByService[_service].length;
        string[] memory doctorNames = new string[](count);
        
        for (uint256 i = 0; i < count; i++) {
            doctorNames[i] = doctorsByService[_service][i].username;
        }
        
        return doctorNames;
    }
   function getDoctorsList() public view returns (address[] memory) {
        return doctorAddresses;
    }
    
   function getDoctorAddress(string memory _email) public view returns (address) {
    return doctorsList[_email].add;
}

function getDoctorPassword(string memory _email) public view returns (string memory) {
    return doctorsList[_email].password;
}

 
    bool public assistantCreated;

struct Assistant {
    address add;
    string username;
    string email;
    string password;
}

mapping(string => Assistant) public assistantsList;
address[] public assistantAddresses;

event AssistantCreated(
    address add,
    string username,
    string email,
    string password
);

function createAssistant(address _add, string memory _username, string memory _email, string memory _password) public {
    require(msg.sender == adminAddress, "Only admin can create assistant");
    assistantsList[_email] = Assistant(_add, _username, _email, _password);
    AllAccounts.push(Account(_add,_email, _password, "assistant"));

    assistantAddresses.push(_add);
    assistantCreated = true;
    emit AssistantCreated(_add, _username, _email, _password);
}

function getAssistantAddress(string memory _email) public view returns (address) {
    return assistantsList[_email].add;
}


function getAssistantPassword(string memory _email) public view returns (string memory) {
    return assistantsList[_email].password;
}

function getAssistantsList() public view returns (address[] memory) {
    return assistantAddresses;
}

 struct Account {
        address adr;
        string email;
        string pwd;
        string role;
    }
event AccountCreated(
        address adr,
        string email,
        string pwd,
        string role
    );

function VerifyRole(string memory _email, string memory _pwd) public view returns (string memory) {
    
        for (uint256 i = 0; i < AllAccounts.length; i++) {

            if (keccak256(bytes(AllAccounts[i].pwd)) == keccak256(bytes(_pwd)) &&
                keccak256(bytes(AllAccounts[i].email)) == keccak256(bytes(_email)) &&
                msg.sender == AllAccounts[i].adr) {
                return AllAccounts[i].role;
            }
        }
                return _pwd; 

    }
function getAllAccounts() public view returns (Account[] memory) {
    return AllAccounts;
}
}
