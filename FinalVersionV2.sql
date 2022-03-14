drop table Equipment_Borrowed_By_Stored_In;
drop table ScheduledFor;
drop table Time_Slot;
drop table Exercise_Room;
drop table Study_Room;
drop table Runs;
drop table SignedUpFor;
drop table Member_Belongs_To;
drop table Account;
drop table Room;
drop table Equipment_Info;
drop table Event;
drop table Account_Type;
drop table Staff_Member;

create table Event(
	EventID char(30) not null,
	Name char(30) not null,
	Description char(100) null,
	primary key(EventID)
);

create table Account_Type(
	AccountType char(20) not null,
	Fees int not null,
	primary key(AccountType)
);

create table Staff_Member(
	EmployeeID char(30) not null,
	Name char(30) not null,
	primary key(EmployeeID)
);

create table Equipment_Info(
	EquipType char(30) not null,
	Fees int not null,
	primary key(EquipType)
);

create table Room(
	RoomNumber char(30) not null,
	Name char(30) not null,
	HrsOpen char(30) not null,
	primary key(RoomNumber)
);

create table Account(
	AccountID char(30) not null,
	Balance int not null,
	Created date not null,
	NextRenewal date not null,
	AccountType char(20) not null,
	primary key(AccountID),
	foreign key(AccountType) references Account_Type(AccountType) ON DELETE CASCADE
);

create table Member_Belongs_To(
	MemberID char(30) not null,
	PhoneNumber char(30) null,
	Name char(30) not null,
	AccountID char(30) not null,
	primary key(MemberID),
	foreign key(AccountID) references Account(AccountID) ON DELETE CASCADE
);

create table SignedUpFor(
	EventID char(30),
	MemberID char(30),
	primary key(EventID, MemberID),
	foreign key(EventID) references Event(EventID) ON DELETE CASCADE,
	foreign key(MemberID) references Member_Belongs_To(MemberID) ON DELETE CASCADE
);

create table Runs(
	EmployeeID char(30) not null,
	EventID char(30) not null,
	primary key(EmployeeID,EventID),
	foreign key(EmployeeID) references Staff_Member(EmployeeID) ON DELETE CASCADE,
	foreign key(EventID) references Event(EventID) ON DELETE CASCADE
);

create table Study_Room(
	RoomNumber char(30) not null,
	NumSeats int not null,
	HasOutlets char(3) not null,
	primary key(RoomNumber),
	foreign key(RoomNumber) references Room(RoomNumber) ON DELETE CASCADE
);

create table Exercise_Room(
	RoomNumber char(30) not null,
	ActivityType char(20) not null,
	primary key(RoomNumber),
	foreign key(RoomNumber) references Room(RoomNumber) ON DELETE CASCADE
);

create table Time_Slot(
	ScheduledHrs char(30) not null,
	RoomNumber char(30) not null,
	SlotDate date not null,
	Duration int not null,
	EventID char(30) null,
	primary key(SlotDate,ScheduledHrs,RoomNumber),
	foreign key(RoomNumber) references Room(RoomNumber) ON DELETE CASCADE,
	foreign key(EventID) references Event(EventID) ON DELETE CASCADE
);

create table ScheduledFor(
	EmployeeID char(30) not null,
	SlotDate date not null,
	ScheduledHours char(30) not null,
	RoomNumber char(30),
	primary key(EmployeeID,SlotDate,ScheduledHours,RoomNumber),
	foreign key(EmployeeID) references Staff_Member(EmployeeID) ON DELETE CASCADE,
	foreign key(SlotDate,ScheduledHours,RoomNumber) references Time_Slot(SlotDate,ScheduledHrs,RoomNumber) ON DELETE CASCADE
);

create table Equipment_Borrowed_By_Stored_In(
	EquipNumber char(30) not null,
	EquipType char(30) not null,
	Availability char(3) not null,
	AccountID char(30) null,
	RoomNumber char(30) not null,
	primary key(EquipType, EquipNumber),
	foreign key(EquipType) references Equipment_Info(EquipType) ON DELETE CASCADE,
	foreign key(AccountID) references Account(AccountID) ON DELETE CASCADE,
	foreign key(RoomNumber) references Exercise_Room(RoomNumber) ON DELETE CASCADE
) ;

insert into Event values
('00000001','Basketball','Participants can practice, run drills and play against one another');
insert into Event values
('00000002','Hockey', 'Open session for participants to practice their skills');
insert into Event values
('00000003','Badminton', 'Participants can use available nets to practice their skills');
insert into Event values
('00000004','Soccer', 'Participants can use either indoor court or outdoor field');
insert into Event values
('00000005','Baseball', 'Participants can use the baseball diamond');


insert into Account_Type values
('Toddler(Under 3)', 0);
insert into Account_Type values
('Child(3-12)', 5);
insert into Account_Type values
('Teenager(13-17)', 15);
insert into Account_Type values
('Adult(18-64)', 25);
insert into Account_Type values
('Senior(65+)', 10);

insert into Staff_Member values
('00000001','John');
insert into Staff_Member values
('00000002','Jake');
insert into Staff_Member values
('00000003','James');
insert into Staff_Member values
('00000004','Jacob');
insert into Staff_Member values
('00000005','Jeffrey');

insert into Equipment_Info values
('Basketball', 5);
insert into Equipment_Info values
('Puck', 1);
insert into Equipment_Info values
('Racket', 10);
insert into Equipment_Info values
('Yoga Mat', 7);
insert into Equipment_Info values
('Hockey Stick', 15);

insert into Room values
('1001', 'Arts and Crafts', '12');
insert into Room values
('1002', 'Music', '12');
insert into Room values
('1003', 'Swimming Pool', '12');
insert into Room values
('1004', 'Birthday Party', '10');
insert into Room values
('1005', 'Music', '8');

insert into Account values
('20000001', 100 ,DATE'2019-03-17',DATE'2021-09-06', 'Teenager(13-17)');
insert into Account values
('20000002', 250 ,DATE'2017-06-18',DATE'2021-09-17', 'Child(3-12)');
insert into Account values
('20000003', 170 ,DATE'2019-01-26',DATE'2021-09-23', 'Teenager(13-17)');
insert into Account values
('20000004', 200 ,DATE'2019-08-20',DATE'2021-09-25', 'Adult(18-64)');
insert into Account values
('20000005', 210 ,DATE'2020-02-27',DATE'2021-09-29', 'Senior(65+)');

insert into Member_Belongs_To values
('10000001', '6047171250' ,'Bob', '20000001');
insert into Member_Belongs_To values
('10100001', '6047171251' ,'Jeff', '20000001');
insert into Member_Belongs_To values
('10030401', '6047170304' ,'Rachel', '20000001');
insert into Member_Belongs_To values
('10000002','6043131691', 'Sarah', '20000002');
insert into Member_Belongs_To values
('10000003','6048729246' ,'Logan', '20000003');
insert into Member_Belongs_To values
('10000223','6048111146' ,'Matholomew', '20000003');
insert into Member_Belongs_To values
('10000004','6047891285','Stephen', '20000004');
insert into Member_Belongs_To values
('10012304','6047123485','Iyamahumin', '20000004');
insert into Member_Belongs_To values
('10000005','6042359226' ,'Jennifer', '20000005');

insert into SignedUpFor values
('00000001','10000001');
insert into SignedUpFor values
('00000001','10000002');
insert into SignedUpFor values
('00000001','10000003');
insert into SignedUpFor values
('00000001','10000004');
insert into SignedUpFor values
('00000001','10000005');
insert into SignedUpFor values
('00000002','10000002');
insert into SignedUpFor values
('00000003','10000003');
insert into SignedUpFor values
('00000004','10000004');
insert into SignedUpFor values
('00000005','10000005');

insert into Runs values
('00000001','00000001');
insert into Runs values
('00000002','00000002' );
insert into Runs values
('00000004','00000004');
insert into Runs values
('00000005','00000005');
insert into Runs values
('00000003', '00000003');

insert into Study_Room values
('1001', 20, '1');
insert into Study_Room values
('1002', 10, '0');
insert into Study_Room values
('1003', 20, '1');
insert into Study_Room values
('1004', 40, '1');
insert into Study_Room values
('1005', 15, '1');
--
insert into Exercise_Room values
('1001', 'Basketball Court');
insert into Exercise_Room values
('1002', 'Hockey');
insert into Exercise_Room values
('1004', 'Yoga');
insert into Exercise_Room values
('1005', 'Gym');
insert into Exercise_Room values
('1003', 'Badminton');
--
insert into Time_Slot values
('8:00-10:00', '1001',DATE'2021-11-18' , 2, '00000001');
insert into Time_Slot values
('20:00-21:00', '1005', DATE'2021-11-10' , 1,'00000002');
insert into Time_Slot values
('12:00-13:00', '1003',DATE'2021-11-02' , 1, '00000003');
insert into Time_Slot values
('15:00-16:00',  '1004', DATE '2021-11-25', 1,'00000004');
insert into Time_Slot values
('16:00-18:00', '1001', DATE'2021-11-21' , 2,'00000005');
--
--
insert into ScheduledFor values
('00000001',DATE'2021-11-18', '8:00-10:00', '1001' );
insert into ScheduledFor values
('00000003',DATE'2021-11-18', '18:00-20:00', '1001' );
insert into ScheduledFor values
('00000003',DATE'2021-11-02', '12:00-13:00', '1003');
insert into ScheduledFor values
('00000004',DATE'2021-11-25', '15:00-16:00', '1004');
insert into ScheduledFor values
('00000005',DATE'2021-11-21', '16:00-18:00', '1001');
--
--
insert into Equipment_Borrowed_By_Stored_In values
('0001', 'Basketball' ,'0', '20000001', '1001');
insert into Equipment_Borrowed_By_Stored_In values
('0021', 'Basketball' ,'0', '20000001', '1002');
insert into Equipment_Borrowed_By_Stored_In values
('0031', 'Basketball' ,'0', '20000001', '1003');
insert into Equipment_Borrowed_By_Stored_In values
('0041', 'Basketball' ,'0', '20000001', '1004');
insert into Equipment_Borrowed_By_Stored_In values
('0051', 'Basketball' ,'0', '20000001', '1005');
insert into Equipment_Borrowed_By_Stored_In values
('0006', 'Puck' ,'0', '20000001', '1001');
insert into Equipment_Borrowed_By_Stored_In values
('0007', 'Racket' ,'0', '20000001', '1001');
insert into Equipment_Borrowed_By_Stored_In values
('0002', 'Puck' ,'0', '20000002', '1002');
insert into Equipment_Borrowed_By_Stored_In values
('0003', 'Racket' ,'0', '20000003', '1003');
insert into Equipment_Borrowed_By_Stored_In values
('0004', 'Basketball' ,'0', '20000004', '1001');
insert into Equipment_Borrowed_By_Stored_In values
('0005', 'Yoga Mat' ,'1', '20000005', '1004');
insert into Equipment_Borrowed_By_Stored_In values
('0011', 'Yoga Mat' ,'0', '20000001', '1001');
insert into Equipment_Borrowed_By_Stored_In values
('0012', 'Hockey Stick' ,'0', '20000001', '1001');
