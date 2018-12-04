USE MASTER
GO
-------------------------
IF EXISTS(SELECT * FROM SYSDATABASES WHERE NAME = 'DBATM')
	DROP DATABASE DBATM

CREATE DATABASE DBATM
-------------------------
USE DBATM
GO
-------------------------
CREATE TABLE Config(
	ConfigID VARCHAR(30) NOT NULL PRIMARY KEY,
	MinWithdraw INT,
	MaxWithdraw INT,
	DateModified TEXT,
	NumPerPage int
)
-------------------------
CREATE TABLE LogType(
	LogTypeID VARCHAR(30) NOT NULL PRIMARY KEY,
	Description NVARCHAR(100)
)
-------------------------
CREATE TABLE Money(
	MoneyID VARCHAR(30) NOT NULL PRIMARY KEY,
	MoneyValue INT
)
-------------------------
CREATE TABLE ATM(
	ATMID VARCHAR(30) NOT NULL PRIMARY KEY,
	Branch NVARCHAR(100),
	Address NVARCHAR(100)
)
-------------------------
CREATE TABLE Stock(
	StockID VARCHAR(30) NOT NULL PRIMARY KEY,
	Quantity INT,
	MoneyID VARCHAR(30),
	ATMID VARCHAR(30),

	CONSTRAINT FK_MONEY FOREIGN KEY(MoneyID)
		REFERENCES Money(MoneyID) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_ATM FOREIGN KEY(ATMID)
		REFERENCES ATM(ATMID) ON UPDATE CASCADE ON DELETE CASCADE
)
-------------------------
CREATE TABLE Customer(
	CustID VARCHAR(30) NOT NULL PRIMARY KEY,
	Name NVARCHAR(50),
	Email TEXT,
	Phone TEXT,
	Addr NVARCHAR(100)
)
-------------------------
CREATE TABLE OverDraft(
	ODID VARCHAR(30) NOT NULL PRIMARY KEY,
	Value INT
)
-------------------------
CREATE TABLE WithdrawLimit(
	WDID VARCHAR(30) NOT NULL PRIMARY KEY,
	Value INT
)
-------------------------
CREATE TABLE Account(
	AccountID VARCHAR(30) NOT NULL PRIMARY KEY,
	Balance INT,
	AccountNo TEXT,
	CustID VARCHAR(30),
	ODID VARCHAR(30),
	WDID VARCHAR(30),
	
	CONSTRAINT FK_CUSTOMER FOREIGN KEY(CustID)
		REFERENCES Customer(CustID) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_OVER FOREIGN KEY(ODID)
		REFERENCES OverDraft(ODID) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_WITHDRAW FOREIGN KEY(WDID)
		REFERENCES WithdrawLimit(WDID) ON UPDATE CASCADE ON DELETE CASCADE
)
-------------------------
CREATE TABLE Card(
	CardNo VARCHAR(30) NOT NULL PRIMARY KEY,
	PIN TEXT,
	Status TEXT,
	StartDate TEXT,
	ExpiredDate TEXT,
	Attempt INT,
	AccountID VARCHAR(30),

	CONSTRAINT FK_ACCOUNT FOREIGN KEY(AccountID)
		REFERENCES Account(AccountID) ON UPDATE CASCADE ON DELETE CASCADE
)
-------------------------
CREATE TABLE Log(
	LogID VARCHAR(30) NOT NULL PRIMARY KEY,
	LogDate TEXT,
	Amount INT,
	Details NVARCHAR(200),
	CardNoTo VARCHAR(30),
	LogTypeID VARCHAR(30),
	ATMID VARCHAR(30),
	CardNo VARCHAR(30),

	CONSTRAINT FK_LOGTYPE FOREIGN KEY(LogTypeID)
		REFERENCES LogType(LogTypeID) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_ATMLOG FOREIGN KEY(ATMID)
		REFERENCES ATM(ATMID) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_CARD FOREIGN KEY(CardNo)
		REFERENCES Card(CardNo) ON UPDATE CASCADE ON DELETE CASCADE
)

-------------------------
insert into Customer values('Cust01',N'Nguy?n ??c M?nh','manhnguyen97@gmail.com','0336672936',N'Phú Th?')
insert into Customer values('cust02',N'Ngô Minh Th?ng','thangthongminh@gmail.com','0982610708',N'Thanh Hóa')
insert into Customer values('cust03',N'Nguy?n V?n Ngh?a','nghia.nvnghia@gmail.com','0971472897',N'Hà N?i')
insert into Customer values('cust04',N'Nguy?n V?n A','A.nvnghia@gmail.com','0971472897',N'Hà N?i')
insert into Customer values('cust05',N'Nguy?n V?n B','B.nvnghia@gmail.com','0971472897',N'Hà N?i')
select * from Customer

insert into ATM values('ATM01',N'Phú Th?',N'??i h?c Công Nghi?p Hà N?i')
insert into ATM values('ATM02',N'C?u Gi?y',N'??i h?c Công Nghi?p Hà H?i')
insert into ATM values('ATM03',N'Phú Th?',N'??i h?c Công Nghi?p Hà H?i')
insert into ATM values('ATM04',N'C?u Gi?y',N'??i h?c Công Nghi?p Hà H?i')
insert into ATM values('ATM05',N'Phú Th?',N'??i h?c Công Nghi?p Hà H?i')
select * from ATM

insert into Money values('Money01',10000)
insert into Money values('Money02',20000)
insert into Money values('Money03',50000)
insert into Money values('Money04',100000)
insert into Money values('Money05',200000)
insert into Money values('Money06',500000)
select * from Money

insert into Stock values('stock01',500000000,'Money01','ATM01')
insert into Stock values('stock02',500000000,'Money02','ATM01')
insert into Stock values('stock03',500000000,'Money03','ATM01')
insert into Stock values('stock04',500000000,'Money04','ATM01')
insert into Stock values('stock05',500000000,'Money05','ATM01')
insert into Stock values('stock06',500000000,'Money06','ATM01')

insert into Stock values('stock07',500000000,'Money01','ATM02')
insert into Stock values('stock08',500000000,'Money02','ATM02')
insert into Stock values('stock09',500000000,'Money03','ATM02')
insert into Stock values('stock10',500000000,'Money04','ATM02')
insert into Stock values('stock11',500000000,'Money05','ATM02')
insert into Stock values('stock12',500000000,'Money06','ATM02')

insert into Stock values('stock13',500000000,'Money01','ATM03')
insert into Stock values('stock14',500000000,'Money02','ATM03')
insert into Stock values('stock15',500000000,'Money03','ATM03')
insert into Stock values('stock16',500000000,'Money04','ATM03')
insert into Stock values('stock17',500000000,'Money05','ATM03')
insert into Stock values('stock18',500000000,'Money06','ATM03')
select * from Stock
select Quantity from Stock  where ATMID = 'ATM01' and MoneyID ='Money01'


insert into OverDraft values('Od01',0)

insert into WithdrawLimit values('Wd01',25000000)

insert into Account values('Account01',40000000,'123','Cust01','Od01','Wd01')
insert into Account values('Account02',50000000,'456','Cust02','Od01','Wd01')
insert into Account values('Account03',10000000,'789','Cust03','Od01','Wd01')
insert into Account values('Account04',10000000,'890','Cust04','Od01','Wd01')
insert into Account values('Account05',10000000,'911','Cust05','Od01','Wd01')
select * from Account


insert into Card values('123456789','12345','normal','01/05/2018','30/05/2019',0,'Account01')
insert into Card values('987654321','12345','normal','12/07/2017','12/07/2018',0,'Account02')
insert into Card values('112233445','12345','block','04/06/2016','04/06/2017',0,'Account03')
insert into Card values('111111111','12345','normal','01/05/2018','30/05/2019',0,'Account04')
insert into Card values('222222222','12345','normal','12/07/2017','12/07/2018',0,'Account05')
select * from Card


insert into LogType values('Logtype01','Withdraw')
insert into LogType values('Logtype02','Transfer')
insert into LogType values('Logtype03','CheckBalance')
insert into LogType values('Logtype04','ChangePIN')
select * from LogType

insert into Log values('Log01','05/08/2018',1000000,'success','987654321','logtype02','ATM01','123456789')
insert into Log values('Log02','07/09/2017',51000000,'success','','logtype03','ATM02','987654321')
insert into Log values('Log03','05/08/2018',1000000,'success','987654321','logtype02','ATM01','123456789')
insert into Log values('Log04','07/09/2017',51000000,'success','','logtype03','ATM02','987654321')
insert into Log values('Log05','07/09/2017',51000000,'success','','logtype03','ATM02','987654321')
select * from Log

insert into Config values('config01',50000,25000000,'21/05/2017',5)
insert into Config values('config02',50000,25000000,'21/05/2017',5)
insert into Config values('config03',50000,25000000,'21/05/2017',5)
insert into Config values('config04',50000,25000000,'21/05/2017',5)
insert into Config values('config05',50000,25000000,'21/05/2017',5)
select * from Config
