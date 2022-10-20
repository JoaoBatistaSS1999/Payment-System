// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract CromJob is Ownable {

    uint constant SALARY_COUNTER = 5;
    Employee[] public activeEmployees;
    mapping (string => uint) public employeesBalances;

    uint public counter;

    struct Employee {
        string name;
        uint daysToGetPayed;
        uint salary;
    }

    function getAllEployees() public view returns(Employee[] memory) {
        return activeEmployees;
    }

    function createEmployee(string calldata _name, uint _salary) public {
        activeEmployees.push(Employee({name: _name, daysToGetPayed: SALARY_COUNTER, salary: _salary}));
    }

    function newDay() public onlyOwner {
       for(uint i; i < activeEmployees.length; i++) {
            activeEmployees[i].daysToGetPayed = activeEmployees[i].daysToGetPayed - 1;
       }

       payEmployees();
    }

    function payEmployees() public onlyOwner {

        for(uint i; i < activeEmployees.length; i++) {

            if(activeEmployees[i].daysToGetPayed == 0) {
                 employeesBalances[activeEmployees[i].name] += activeEmployees[i].salary;
                 activeEmployees[i].daysToGetPayed = SALARY_COUNTER;
            }

       }
    }

}