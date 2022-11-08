//SPDX-License-Identifier: Unlicense
pragma solidity >=0.5.0 <0.9.0;

contract EventContract{
    struct Event{
        address organiser;
        string name;
        uint date;
        uint price;
        uint TotalTickets;
        uint ticketLeft;

    }

    mapping(uint=>Event) public events;
    mapping(address=>mapping(uint=>uint))public tickets;
    uint public nextId;

    function CreateEvent(string memory name,uint date,uint price,uint TotalTickets) external {
    
     require(date>block.timestamp,"Event has already PAST!!!");
     require(TotalTickets>0,"Events need atleast 1 ticket");
     events[nextId]=Event(msg.sender,name,date,price,TotalTickets,TotalTickets);
     nextId++;
        

    }


}