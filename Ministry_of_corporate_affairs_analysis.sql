create database MCA;

use MCA;

show tables;

create table Final_data(select * from jan23 j union all select * from feb23 f union all select * from march23 m union all select * from april23 a union all select * from may23 m2 union all select * from june23 j2
   union all select * from july23 j3);

alter table final_data  modify column  `Date of Registration` date ;

select * from final_data ;

#Total no of active companies from period January to July 2023

select count(*) from final_data where `company status`='Active';

#Total No companies class wise from period Jan to July 2023
select count(cin) from final_data;


#Total companies by class
create table totalbyclass select class,count(CIN) from final_data  where Class is not null group by Class;
select * from totalbyclass ;


alter table final_data add column Month varchar(20);

update final_data set Month=monthname(`Date of Registration`); 

#Total no of active companies state wise
select `company status`,`state`, count(`company status`) Total_count from final_data where `company status`='Active' group by State order by count(`Company Status`) desc;
#Top 5 state with highest active companies 
create table top5state(select `company status`,`state`,count(`company status`) Total_count from final_data where `company status`='Active' and State is not null group by State order by count(`Company Status`) desc limit 5);
select * from top5state ;

#Ranks of State w.r.t Total no of active companies
select `state`, count(`company status`) as Total_no_of_active_companies, rank() over(order by count(`Company Status`) desc) as Rank_of_state from final_data where `company status`='Active' group by State;

#top 5 category wise active companies
create table top5category select 	`ACTIVITY DESCRIPTION` ,count(`activity description`) from final_data where `company status`='Active' group by `activity description` order by count(`activity description`) desc limit 5;

select * from top5category ;
#Gujarat scenario
select 	`State`,`ACTIVITY DESCRIPTION` ,count(`activity description`) from final_data where `company status`='Active' and state='Gujarat'  group by `activity description` order by count(`activity description`) desc limit 5;

#Ahmedabad scenario
select `Month`,`ACTIVITY DESCRIPTION` ,count(`activity description`) from final_data where `company status`='Active' and ROC='ROC Ahmedabad' group by `activity description`,`Month` order by 
count(`activity description`) desc;

#Active companies by month and state
create table activebymonthstate select `State`,`Month`,`COMPANY STATUS`,count(cin) Total_active_companies from final_data where `COMPANY STATUS`='active' and `Month` in ('January','February','March','April','May','June','July') and STATE is not null group by `Month`,STATE ;
select `State`,`Month`,`COMPANY STATUS`,count(cin) Total_active_companies from final_data where `COMPANY STATUS`='active' and `Month` in ('January','February','March','April','May','June','July')  group by `Month`,STATE ;
select * from activebymonthstate ;
#Total paidup capital
create table paidupcapbycategory select `ACTIVITY DESCRIPTION` ,sum(`PAIDUP CAPITAL`) from final_data group by `ACTIVITY DESCRIPTION` order by sum(`PAIDUP CAPITAL`) desc ;

select  * from paidupcapbycategory ;
#category and state wise counts
select STATE,CATEGORY ,count(cin) from final_data where `COMPANY STATUS`='Active' group by CATEGORY ,STATE order by count(cin) desc;

#Companies limited by shares & guarantee
create table categorywiseactive2 select CATEGORY ,count(cin) from final_data where `COMPANY STATUS`='Active' and `Month` in ('January','February','March','April','May','June','July') group by CATEGORY ; 

select * from categorywiseactive2 ;

#Ahmedabad active comapnies
create table ahmactive select ROC,count(cin) from final_data where `COMPANY STATUS`='Active' and ROC='Roc-Ahmedabad' group by ROC ;

select * from ahmactive ;