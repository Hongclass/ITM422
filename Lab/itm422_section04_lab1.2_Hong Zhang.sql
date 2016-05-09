drop table rahcustomer_price_decks;

create table rahcustomer_price_decks(
	custid		number,
	custname	varchar2(50),
	yearsales	number,
	yearcust		number not null
);

insert into rahcustomer_price_decks values(1,'Sammy Sosa',45000.01,1987);
insert into rahcustomer_price_decks values(2,'Mark Grace',78799.98,1983);
insert into rahcustomer_price_decks values(3,'Kerry Wood',458687.89,1997);
insert into rahcustomer_price_decks values(4,'Mark Prior',null,2003);

insert into rahcustomer_price_decks values(5,'Moises Alou',43234.55,1997);

insert into rahcustomer_price_decks values(5,'Moises Alou',43234.55,1997);

insert into rahcustomer_price_decks (custid,custname,yearsales,yearcust) values (5,'Moises Alou',43234.55,1997);

insert into rahcustomer_price_decks (yearcust,custid,custname,yearsales) values (1997,5,'Moises Alou',43234.55);

insert into rahcustomer_price_decks (yearcust,custid,custname,yearsales) values (1997,5,'Moises Alou',43234.55);

insert into rahcustomer_price_decks (yearcust,custid,custname,yearsales) values (1997,5,'Moises Alou',43234.55);

insert into rahcustomer_price_decks values(3,'Kerry Wood',458687.89,1997);

insert into rahcustomer_price_decks (yearcust,custid) values (1967,5);

create table rahcustomer_price_backup as select * from rahcustomer_price_decks;

alter table rahcustomer_price_decks add year_traded number;

update rahcustomer_price_decks set yearsales = 0 where yearsales is null;
alter table rahcustomer_price_decks modify yearsales not null;

alter table rahcustomer_price_decks drop column yearsales;

alter table rahcustomer_price_decks rename to bob;

