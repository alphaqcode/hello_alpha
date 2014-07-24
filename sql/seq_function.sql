create table po
	(
	PO			varchar(20),
	Vendor		varchar(20),
	OPO_Qty		float,
	Quota		float,
	Price		float,
	Stock		float,
	VMIStock	float,
	VMI_use		float,
	needQty		float,
	W1			float
	)

insert into po
values('6026B0175401','233492',106380,0.8,0.26,86584,160500,null,-124200,36300)

insert into po
values('6026B0175401','231170',30770,0.2,0.3439,0,0,null,-124200,10370 )
/*
PN				Vendor	OPO Qty	OPO %	PO L/T	Control Table	Quota	Price	Stock	VMI Stock	VMI可用庫存	最低補貨數量	W1
6026B0175401	233492	106380	78%		28		25				0.8		0.26	86584	160500					-124200			36,300 
6026B0175401	231170	30770	22%		28		25				0.2		0.3439													10,370 
*/

select PN,sum(W1) as W1
from po 
group by PN	

select PN,CASE when VMIStock >= W1 then W1 else VMIStock end
from po
order by

select row_number() over(order by item_type),* 
from items_bak
order by item_type

insert into items_bak select 'crison','tipe'

select rank() over(partition by item_type order by gate) as rank,*
from items_bak
order by item_type

select dense_rank() over(partition by item_type order by gate) as rank,*
from items_bak
order by item_type


select ntile(2) over(partition by item_type order by gate) as rank,*
from items_bak
order by item_type

select row_number() over(order by item_type),*
from items_bak
order by gate

select * from items_bak order by newid()


select newid()