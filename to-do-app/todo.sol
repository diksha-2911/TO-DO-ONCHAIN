// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract ToDo{
    enum TaskStatus {Pending, Finished}
    address owner;
    struct Task{
        string desc;
        TaskStatus status;
    }

    //array of Task struct type
    Task[] public tasks;

    constructor(){
        owner = msg.sender;
    }

    //only owner can make changes
    modifier onlyOwner{
        require(msg.sender == owner, "Not Owner");
        _;
    }

    function addTask(string memory _desc) public onlyOwner{
        tasks.push(Task(_desc, TaskStatus.Pending)); //append task to array
    }

    function markAsFinished(uint256 id) public onlyOwner{
        require(id < tasks.length, "No task has been added");
        tasks[id].status = TaskStatus.Finished;
    }

    function getAllTasks() public view returns (Task[] memory){
        return tasks;
    }

    function getTask(uint id) public view returns (string memory, TaskStatus){
        require(id < tasks.length, "No task has been added");
        return(tasks[id].desc, tasks[id].status);
    }


}