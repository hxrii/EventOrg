//SPDX-License-Identifier: Unlicense
pragma solidity >=0.5.0 <0.9.0;

contract EventContract{    //Declaring Contract for event organisation
    struct Event{          //Structure variables of Contract
        address organiser;
        string name;
        uint date;
        uint price;
        uint TotalTickets;
        uint ticketLeft;

    }

    mapping(uint=>Event) public events;  //Mapping index of event with each events

    mapping(address=>mapping(uint=>uint))public tickets; //Mapping Addresses and Indexes for each events
                                                         // to get each person's no of ticket for the event
                                                         // Similar to 2D array, tickets[address][EventID] 
                                                         // is mapped to the number of tickets of eventID's event
                                                         // that the address holds


    uint public nextId;  //variable for storing index values of each added events.

    function CreateEvent(string memory name,uint date,uint price,uint TotalTickets) external {
    
        //Function to create Event 
        //Event should have a future date and No of tickets should be > 0


     require(date>block.timestamp,"WAIT!!! Event has already PAST!!!");
     require(TotalTickets>0,"Hey, Events need atleast 1 ticket");
     events[nextId]=Event(msg.sender,name,date,price,TotalTickets,TotalTickets);
     nextId++;
        

    }

    function buyTicket(uint id, uint Qty) external payable {

        //Function to Buy Ticket 
        //Event should have a valid future date and msg.sender should have enough balance
        //Remaining tickets should be greater than or equal to Qty of purchase


        require(events[id].date!=0,"Sorry!!! The Event doesn't Exist.");
        require(events[id].date>block.timestamp,"WAIT!!! Event has already PAST!!!"); 

        Event storage _event = events[id];
        require(msg.value==(_event.price*Qty),"Sorry!!! Not Enough balance");
        require(_event.ticketLeft>=Qty,"Sorry!!! Tickets are SOLD OUT");
        _event.ticketLeft -=Qty;
        tickets[msg.sender][id]+=Qty;



    }



    function transfer(uint eventID, uint quantity, address to)external  
    {
        // Should have valid eventID and event should have future date
        // Also msg.sender's eventID tickets >= Quantity to be transfered
        
        require(events[eventID].date!=0,"SORRY!!! The Event does not exist");
        require(events[eventID].date>block.timestamp,"SORRY!!! The Event has ended");
        require(tickets[msg.sender][eventID]>=quantity,"SORRY!!! You do not have Enough Tickets");
        tickets[msg.sender][eventID] -= quantity;
        tickets[to][eventID] += quantity;



    }

}