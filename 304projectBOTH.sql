create table SignedUpFor(
	EventID char(10),
	MemberID char(10),
	primary key(EventID, MemberID),
	foreign key(EventID) references Event(EventID) ON DELETE CASCADE,
	foreign key(MemberID) references Member_Belongs_To(MemberID) ON DELETE CASCADE
);

create table Event(
	EventID char(10) not null,
	Name char(10) not null,
	Description char(10) null,
	primary key(EventID)
);

create table Member_Belongs_To(
	MemberID char(10) not null,
	PhoneNumber char(10) null,
	Name char(10) not null,
	AccountID char(10) not null,
	primary key(MemberID),
	foreign key(AccountID) references Account(AccountID) ON DELETE CASCADE
);

create table Account(
	AccountID char(10) not null,
	Balance int not null,
	Created date not null,
	NextRenewal date not null,
	AccountType char(20) not null,
	primary key(AccountID),
	foreign key(AccountType) references Account_Type(AccountType) ON DELETE CASCADE
);

create table Account_Type(
	AccountType char(20) not null,
	Fees int not null,
	primary key(AccountType)
);

create table ScheduledFor(
	EmployeeID char(10) not null,
	SlotDate date not null,
	ScheduledHours int not null,
	RoomNumber char(10),
	primary key(EmployeeID,SlotDate,ScheduledHours,RoomNumber),
	foreign key(EmployeeID) references Staff_Member(EmployeeID) ON DELETE CASCADE,
	foreign key(SlotDate,ScheduledHours,RoomNumber) references Time_Slot(SlotDate,ScheduledHours,RoomNumber) ON DELETE CASCADE
);

create table Runs(
	EmployeeID char(10) not null,
	EventID char(10) not null,
	primary key(EmployeeID,EventID),
	foreign key(EmployeeID) references Staff_Member(EmployeeID) ON DELETE CASCADE,
	foreign key(EventID) references Event(EventID) ON DELETE CASCADE
);

create table Staff_Member(
	EmployeeID char(10) not null,
	Name char(10) not null,
	primary key(EmployeeID)
);




create table Equipment_Borrowed_By_Stored_In(
	EquipType char(10) not null,
	EquipNumber char(10) not null,
	Availability char(3) not null,
	AccountID char(10) null,
	RoomNumber char(10) not null,
	primary key(EquipType, EquipNumber),
	foreign key(EquipType) references Equipment_Info(EquipType) ON DELETE CASCADE,
	foreign key(AccountID) references Account(AccountID) ON DELETE CASCADE,
	foreign key(RoomNumber) references Exercise_Room(RoomNumber) ON DELETE CASCADE
) ;

create table Equipment_Info(
	EquipType char(10) not null,
	Fees int not null,
	primary key(EquipType)
);

create table Room(
	RoomNumber char(10) not null,
	Name char(10) not null,
	HrsOpen char(10) not null,
	primary key(RoomNumber)
);

create table Study_Room(
	RoomNumber char(10) not null,
	NumSeats int not null,
	HasOutlets char(3) not null,
	primary key(RoomNumber),
	foreign key(RoomNumber) references Room(RoomNumber) ON DELETE CASCADE
);

create table Exercise_Room(
	RoomNumber char(10) not null,
	ActivityType char(20) not null,
	primary key(RoomNumber),
	foreign key(RoomNumber) references Room(RoomNumber) ON DELETE CASCADE
);

create table Time_Slot(
	ScheduledHrs char(11) not null,
	RoomNumber char(10) not null,
	SlotDate date not null,
	Duration int not null,
	EventID char(10) null,
	primary key(SlotDate,ScheduledHrs,RoomNumber),
	foreign key(RoomNumber) references Room(RoomNumber) ON DELETE CASCADE,
	foreign key(EventID) references Event(EventID) ON DELETE CASCADE
);

insert into SignedUpFor
values ('00000001','10000001'),
('00000002','10000002'),
('00000003','10000003'),
('00000004','10000004'),
('00000005','10000005');

insert into ScheduledFor
values	('00000001','2021-11-18', 2 , '3001' ),
('00000002','2021-11-10', 1, '3002' ),
('00000003','2021-11-02', 1, '3003'),
('00000004','2021-11-25', 1, '1004'),
('00000005','2021-11-21', 2, '3004');

insert into Runs
values	('00000001','00000001'),
('00000002','00000002' ),
('00000003', '00000003'),
('00000004','00000004'),
('00000005','00000005');

insert into Staff_Member
values	('00000001','John'),
('00000002','Jake'),
('00000003','James'),
('00000004','Jacob'),
('00000005','Jeffrey');

insert into Event
values	
('00000001','Basketball','Participants can practice, run drills and play against one another'),
('00000002','Hockey', 'Open session for participants to practice their skills'),
('00000003','Badminton', 'Participants can use available nets to practice their skills' );



insert into Member_Belongs_TO
values	
('10000001', '6047171250' ,'Bob', '20000001'),
('10000002','6043131691', 'Sarah', '20000002'),
('10000003','6048729246' ,'Logan', '20000003'),
('10000004','6047891285','Stephen', '20000004'),
('10000005','6042359226' ,'Jennifer', '20000005');

insert into Account
values	
('20000001', 100 ,'2019-03-17','2021-09-06', 'Teenager(13-17)'),
('20000002', 250 ,'2017-06-18','2021-09-17', 'Child(3-12)'),
('20000003', 170 ,'2019-01-26','2021-09-23', 'Teenager(13-17)'),
('20000004', 200 ,'2019-08-20','2021-09-25', 'Adult(18-64)'),
('20000005', 210 ,'2020-02-27','2021-09-29', 'Senior(65+)');

insert into Account_Type
values	
('Toddler(Under 3)', 0),
('Child(3-12)', 5),
('Teenager(13-17)', 15),
('Adult(18-64)', 25),
('Senior(65+)', 10);

insert into Equipment_Borrowed_By_Stored_In
values	
('0001', 'Basketball' ,'0',5, '20000001', '3001'),
('0002', 'Puck' ,'0',1, '20000002', '3002'),
('0003', 'Racket' ,'0',10, '20000003', '3003'),
('0004', 'Basketball' ,'0',5, '20000004', '3001'),
('0005', 'Yoga Mat' ,'1',7, '20000005', '3004');

insert into Equipment_Info
values 
('Basketball', 5),
('Puck', 1),
('Racket', 10),
('Yoga Mat', 7),
('Hockey Stick', 15);

insert into Room
values	
('1001', 'Arts and Crafts', '12'),
('1002', 'Music', '12'),
('1003', 'Swimming Pool', '12'),
('1004', 'Birthday Party', '10'),
('1005', 'Music', '8');

insert into Study_Room
values	
('2001', 20, '1'),
('2002', 10, '0'),
('2003', 20, '1'),
('2004', 40, '1'),
('2005', 15, '1');

insert into Exercise_Room
values	
('3001', 'Basketball Court'),
('3002', 'Hockey'),
('3003', 'Badminton'),
('3004', 'Yoga'),
('3005', 'Gym');

insert into Time_Slot
values	
('8:00-10:00 ', '2021-11-18', '1001', '00000001'),
('20:00-21:00 ', '2021-11-10' , '1005', '00000002'),
('12:00-13:00 ', '2021-11-02' , '1003', '00000003'),
('15:00-16:00 ', '2021-11-25'   '1004', '00000004'),
('16:00-18:00 ', '2021-11-21' , '3001', '00000005');


