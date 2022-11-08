// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;


// 統整解題方式說明於最後註解 謝謝助教

contract GradesContract {
    address public teacher;

    mapping (address => Grades) studentGrades;
    
    address[] studentIds;

    Grades gs;
    
    //由於原先Struct編譯後應無法新增Element 故改變了此結構 加入Subject陣列並得以Mapping到分數
    //而 len 儲存目前科目總數
    struct Grades {
        string[] subject;
        bool Registered;
        mapping(string => uint) subjectScore;
        uint len;
    }

    //由於原先題目就先加入了三科目 故在建構子Push入預設三科目
    constructor() {
        teacher = msg.sender;
        gs.subject.push("Chinese");
        gs.subject.push("English");
        gs.subject.push("Math");
        gs.len=3;
    }
    
    //利用 modifier onlyTeacher() 以及 modifier isGradesOf(studentId) 達成身分檢查
    //check permission (僅可 teacher 操作)
    modifier onlyTeacher() {
        require(msg.sender == teacher,"only the teacher can call this method");
        _;
    }

    //check permission (由於部分Function 可由 teacher 或 student 本人操作 故將條件以 OR 寫在一起)
    modifier isGradesOf(address input) {
        require(msg.sender == input||msg.sender == teacher,"only the student who owns these grades");
        _;
    }

    //可自由新增科目至Grades的Struct結構 並len+1 表示科目多一科
    function addSubject(string memory subjectName) external onlyTeacher{
        gs.subject.push(subjectName);
        gs.len +=1;
    }

    function putSubjectGrade(address studentId, string memory subjectName, uint subjectGrade) external onlyTeacher{
        // if it is first time registered
        if (studentGrades[studentId].Registered == false) {
            // then add to Ids array for tracking or iterating
            studentIds.push(studentId);
        }
        //利用 studentGrades[studentId] Mapping 到所屬 Struct，再利用 subjectName 以 Mapping 到該科目成績
        //即可取代、填入 subjectGrade 該科成績
        studentGrades[studentId].subjectScore[subjectName]=subjectGrade;
    }

    //同上，studentGrades[studentId] Mapping 到所屬 Struct，再利用 subjectName Mapping 取得科目成績
    function getSubjectGrade(address studentId, string memory subjectName) public view returns (uint) {
        return studentGrades[studentId].subjectScore[subjectName];
    }

    //studentGrades[studentId] Mapping 到所屬 Struct，再利用科目長度跑for loop，一一取出各科成績並加總 
    function getGradesSum(address studentId) isGradesOf(studentId) public view returns (uint) {           
        uint studentSum = 0;
        for(uint i = 0; i < gs.len; i++)
        {
            studentSum = studentSum + studentGrades[studentId].subjectScore[gs.subject[i]];
        }
        return studentSum;
    }
    
    //同上，僅最後除以科目長度 (p.s 尚未填入成績的科目預設為0分)
    function getGradesAverage(address studentId) external isGradesOf(studentId) view returns (uint) {
        uint studentSum = 0;
        for(uint i = 0; i < gs.len; i++)
        {
            studentSum = studentSum + studentGrades[studentId].subjectScore[gs.subject[i]];
        }
        return studentSum/gs.len;
    }
    
    //同上，僅改以雙重迴圈加總全員學生的成績
    function getClassGradesAverage() external onlyTeacher view returns (uint) {
        // iterate all the grades and calculate its average
        uint studentSum = 0;
        uint studentNum = studentIds.length;
        for (uint i = 0; i < studentNum; i++) {
            for(uint j = 0; j < gs.len; j++)
            {
            studentSum = studentSum + studentGrades[studentIds[i]].subjectScore[gs.subject[j]];
            }
        }
        return (studentSum / studentNum) / gs.len;
    }
}

    /*  
    簡單來說由於Struct結構在編譯後應無法加入新的Element(科目)，即無法改變其定義，
    為了盡量保留原題幹，所以學生保留並改寫Struct，讓科目在結構裡以動態Array呈現，
    並將分數以Mapping方式撰寫，使其得以透過交互方式達成加入新資料及新Element的效果。

    不過改變Struct的定義，實務上應該不是一個好的做法，
    不保留Struct的話，其實可以選擇使用多重Mapping也能達到一樣且更簡單的效果。
    */