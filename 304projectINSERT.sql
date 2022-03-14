insert into SignedUpFor
values('00000001','10000001'),
('00000002','10000002'),
('00000003','10000003'),
('00000004','10000004'),
('00000005','10000005');

insert into ScheduledFor
values	('00000001','2021-11-18', 2 , '3001' ,),
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
('00000001','Basketball','Participants can practice, run drills and play against one another)',
('00000002','Hockey', 'Open session for participants to practice their skills)',
('00000003','Badminton', 'Participants can use available nets to practice their skills' ),
('00000004','Birthday Party', 'Participants can host private birthday parties in a room and be allowed to bring up to 20 guests. Staff members may set up games that participants choose such as Soccer, Dodgeball, Basketball,etc'),
('00000005','Yoga', 'Yoga sessions will be hosted by a special instructor. Sessions are suitable for people of all levels and will introduce people to a variety of poses to induce physical and mental relaxation');

insert into Member-Belongs_TO
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
('Basketball', 5)
('Puck', 1)
('Racket', 10)
('Yoga Mat', 7)
('Hockey Stick', 15)

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
('8:00-10:00 ' '2021-11-18', , '1001', '00000001'),
('20:00-21:00 ' '2021-11-10' , '1005', '00000002'),
('12:00-13:00 ' '2021-11-02' , '1003', '00000003'),
('15:00-16:00 ' '2021-11-25'   '1004', '00000004'),
('16:00-18:00 ' '2021-11-21' , '3001', '00000005');

