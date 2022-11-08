// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract GradesContract {
    address public teacher;
    
    mapping (address => mapping(string => uint)) studentGrades;
    mapping (address => bool) registered;
    
    address[] studentIds;
    string[] _subjectName;
    
    constructor() {
        teacher = msg.sender;
        // _subjectName = ["Chinese","English","Math"];
        // _subjectName.push("tommy");
    }
    
    modifier isTeacher(){
        require (msg.sender == teacher,"You are not teacher!");
        _;
    }

    modifier isTeacherOrStudent(address input){
        require (msg.sender == teacher || msg.sender == input,"You are not teacher or student who own grades!");
        _;
    }

    function addSubject(string memory subjectName) external isTeacher{
        _subjectName.push(subjectName);
    }

    function getSubjectGrade(address studentId, string memory subjectName) external isTeacher view returns (uint){
        return studentGrades[studentId][subjectName];
    }

    function putSubjectGrade(address studentId, string memory subjectName, uint subjectGrade) external isTeacher{
        if (registered[studentId] == false) {
            // then add to Ids array for tracking or iterating
            studentIds.push(studentId);
        }
        studentGrades[studentId][subjectName]=subjectGrade;
    }
    
    function getGradesSum(address studentId) public isTeacher isTeacherOrStudent(studentId) view returns (uint) {        
        uint GradesSum;
        for(uint i = 0 ; i < _subjectName.length ; i++) 
        {
            GradesSum = GradesSum + studentGrades[studentId][_subjectName[i]];
        }
        return GradesSum;
    }
    
    function getGradesAverage(address studentId) external isTeacher isTeacherOrStudent(studentId) view returns (uint) {
        return getGradesSum(studentId) / _subjectName.length;
    }
    
    function getClassGradesAverage() external isTeacher view returns (uint) {

        // iterate all the grades and calculate its average
        uint sum = 0;
        uint studentNum = studentIds.length;
        for (uint i = 0; i < studentNum; i++) {
            sum = sum + getGradesSum(studentIds[i]);
        }
        return (sum / studentNum) / _subjectName.length;
    }

    function checksubnum() external view returns (uint){
        return(_subjectName.length);
    }
}

