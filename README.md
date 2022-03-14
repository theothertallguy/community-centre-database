#### project_r2x2b_w5a3b_y5y7z

# Milestone 1

## Project Description

The domain of our project is a community centre. More specifically, we will focus on managing accounts and events at the community centre. We are trying to put ourselves in the shoes of a front-desk receptionist, overlooking various services and equipment, as well as managing accounts, events, and memberships. 

The database is meant to provide an information system for the front desk person to know what is going on and give information with. It allows them to manage a person’s membership, with each member belonging to an account with at least one person assigned to that account (although it can have more). Our community centre offers two different kinds of rooms. There are workout rooms and study rooms, each with their own unique services and purpose. 

Our community centre also allows members to borrow equipment from the various exercise rooms, and manage the late fees associated with those pieces of equipment. However, it is important to note that we are tracking rentals based on the account, so if someone is late at returning a piece of equipment, everyone under that account will be held responsible and charged with late fees. 

Moreover, the staff members will help with hosting/running various events, as well as attending the correct time slot they’ve been assigned to during their workday. Time slots are specially designed to identify when an event is happening and from what duration a certain room is going to be occupied for. Events are things that describe what activity is happening. For example, some events that we offer include free math help and open basketball.

We will be using the CPSC department’s Oracle software, as well as PHP. We don’t see ourselves using any other outside software at this point.





# Milestone 2
Milestone 2

PART 2 - ER DIAGRAM
See ER Diagram from Milestone 1

PART 3 - SCHEMA
SignedUpFor
SignedUpFor(EventID, MemberID)
Primary Key: EventID, MemberID
Foreign Keys: EventID, MemberID
Candidate Keys: N/A

ScheduledFor
ScheduledFor(EmployeeID, ScheduledHrs,SlotDate,Room#)
Primary Key: EmployeeID, ScheduledHrs,SlotDate, Room#
Foreign Keys: EmployeeID, ScheduledHrs, SlotDate, Room#
Candidate Keys: N/A

Runs
Runs(EmployeeID, EventID)
Primary Key: EmployeeID, EventID
Foreign Keys: EmployeeID, EventID
Candidate Keys: N/A

Staff_Member
Staff_Member(EmployeeID,Name)
Primary Key: EmployeeID
Foreign Keys: N/A
Candidate Keys: N/A

Event
Event(EventID, Name, Description)
Primary Key: EventID
Foreign Keys: N/A
Candidate Keys: N/A

Member_Belongs_To
Member_Belongs_To(MemberID, Phone#, Name, AccountID)
Primary Key: MemberID
Foreign Keys: AccountID
Candidate Keys: Phone#

Account
Account(AccountID, AccountType, Balance, Fees, DateCreated, RenewalDate)
Primary Key: AccountID
Foreign Keys: N/A
Candidate Keys: N/A

Equipment_Borrowed_By_Stored_In
Equipment_Borrowed_By-Stored_In(EquipType, Number, Availability, LateFee, AccountID, Room#)
Primary Key: EquipType, Number
Foreign Keys: N/A
Candidate Keys: N/A

Room
Room(Room#,Name,HrsOpen)
Primary Key: Room#
Foreign Keys: N/A
Candidate Keys: N/A

StudyRoom
Study_Room(Room#, NumSeats, HasOutlets)
Primary Key: Room#
Foreign Keys: Room#
Candidate Keys: N/A

ExerciseRoom
Exercise_Room(Room#,Type)
Primary Key: Room#
Foreign Keys: Room#
Candidate Keys: N/A

Time_Slot
Time_Slot(ScheduledHrs, Room#, SlotDate, Duration, EventID)
Primary Key: ScheduledHrs, Room#, SlotDate
Foreign Keys : EventID
Candidate Keys: N/A


PART 4 - FUNCTIONAL DEPENDENCIES

SignedUpFor
No non-trivial FDs

ScheduledFor
No non-trivial FDs

Runs
No non-trivial FD’s

Staff_Member
EmployeeID -> Name

Event
EventID -> Name, Description

Member_Belongs_To
MemberID -> Phone#, Name, AccountID 

Account
AccountID -> AccountType, Balance, Fees, DateCreated, RenewalDate
AccountType -> Fees

Equipment_Borrowed_By_Stored_In
EquipType, Number -> Availability, LateFee, AccountID, Room#
EquipType -> LateFee

Room
Room# -> Name, HrsOpen

StudyRoom
Room# -> NumSeats, HasOutlets

ExerciseRoom
Room# -> Type

Time_Slot
ScheduledHrs, Room#, SlotDate -> Duration, EventID



PART 5 - NORMALIZATION

SignedUpFor
No non-trivial FDs
Is in 3NF/BCNF
SignedUpFor(EventID, MemberID)
Primary Key: EventID, MemberID
Foreign Keys: EventID, MemberID
Candidate Keys: N/A

ScheduledFor
No non-trivial FDs
Is in 3NF/BCNF
ScheduledFor(EmployeeID, ScheduledHrs,SlotDate,Room#)
Primary Key: EmployeeID, ScheduledHrs,SlotDate, Room#
Foreign Keys: EmployeeID, ScheduledHrs, SlotDate, Room#
Candidate Keys: N/A

Runs
No non-trivial FD’s
Is in 3NF/BCNF
Runs(EmployeeID, EventID)
Primary Key: EmployeeID, EventID
Foreign Keys: EmployeeID, EventID
Candidate Keys: N/A

Staff_Member
EmployeeID -> Name
Is in 3NF/BCNF
Staff_Member(EmployeeID,Name)
Primary Key: EmployeeID
Foreign Keys: N/A
Candidate Keys: N/A

Event
EventID -> Name, Description
Is in 3NF/BCNF
Event(EventID, Name, Description)
Primary Key: EventID
Foreign Keys: N/A
Candidate Keys: N/A

Member_Belongs_To
MemberID -> Phone#, Name, AccountID 
Is in 3NF/BCNF
Member_Belongs_To(MemberID, Phone#, Name, AccountID)
Primary Key: MemberID
Foreign Keys: AccountID
Candidate Keys: Phone#

Account
AccountID -> AccountType, Balance, Fees, DateCreated, RenewalDate
AccountType -> Fees
Is in 2NF (AccountType is not part of the primary key, not 3NF)

After Normalization:
Account(AccountID, AccountType, Balance, DateCreated, RenewalDate)
Primary Key: AccountID
Foreign Keys: AccountType
Candidate Keys: N/A
New Account Type table made for new relation

Account_Type
AccountType -> Fees
Is in 3NF/BCNF
Primary Key: EquipType
Foreign Keys: N/A
Candidate Keys: N/A

Equipment_Borrowed_By_Stored_In
EquipType, Number -> Availability, LateFee, AccountID, Room#
EquipType -> LateFee
Is in 1NF (partial dependency due to EquipType only being part of primary key)

After Normalization:
Equipment_Borrowed_By-Stored_In(EquipType, Number, Availability, AccountID, Room#)
Primary Key: EquipType, Number
Foreign Keys: EquipType
Candidate Keys: N/A
New Equipment Info table made for new relation

Equipment_Info
EquipType -> LateFee
Equipment_Fees(EquipType, LateFee)
Primary Key: EquipType
Foreign Keys: N/A
Candidate Keys: N/A

Room
Room# -> Name, HrsOpen
Is in 3NF/BCNF
Room(Room#,Name,HrsOpen)
Primary Key: Room#
Foreign Keys: N/A
Candidate Keys: N/A

StudyRoom
Room# -> NumSeats, HasOutlets
Is in 3NF/BCNF
Study_Room(Room#, NumSeats, HasOutlets)
Primary Key: Room#
Foreign Keys: Room#
Candidate Keys: N/A

ExerciseRoom
Room# -> Type
Is in 3NF/BCNF
Exercise_Room(Room#,Type)
Primary Key: Room#
Foreign Keys: Room#
Candidate Keys: N/A

Time_Slot
ScheduledHrs, Room#, SlotDate -> Duration, EventID,
Is in 3NF/BCNF
Time_Slot(ScheduledHrs, Room#, SlotDate, Duration, EventID)
Primary Key: ScheduledHrs, Room#, SlotDate
Foreign Keys : EventID
Candidate Keys: N/A



PART 6 AND 7 - SQL DDL AND TABLE POPULATION
The .sql files for the SQL DDL and the insert statements can be found here:
https://github.students.cs.ubc.ca/CPSC304-2021W-T1/project_r2x2b_w5a3b_y5y7z

PART 8 - QUERIES
Member borrows equipment, registered to their Account
Member signs up for Event
New Event is added to one or more consecutive Time Slots.
New Equipment is purchased, and registered to a Room
Assign a Staff Member to an Event
Schedule a Staff Member to a Time Slot
Change the Account type (UPDATE)
See what Room a type of Equipment is in
Check what Equipment is borrowed by an Account
Add a new Member to an Account
Create a new Account for a new Member (CREATE)
Delete a Member
Delete an Account (DELETE)
Check Event details (see location, room, staff assigned)
Change Equipment Fees

Beyond the three standard queries (update, delete, create), we have not explicitly covered any of the other queries in class. As such, these queries have not yet been categorized or assigned to any of the other query specifications.


# Milestone 4
No extra information
