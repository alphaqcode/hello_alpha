drop procedure if exists sp_start_new_guess;
delimiter //
create procedure sp_start_new_guess(p_user_name varchar(20),p_a_no varchar(4))
begin
	
	insert into guess_no_step_history
	select * from guess_no_step
	where user_name = p_user_name;
	
	delete from guess_no_step
	where user_name = p_user_name;

	insert into guess_no_history
	select * from guess_no
 	where user_name = p_user_name;

	delete from guess_no
	where user_name = p_user_name;

	if length(p_a_no) <> 4 then	
		set p_a_no = ft_guess_create();

	end if;

	insert into guess_no(user_name,a_no)
 	select p_user_name,p_a_no; 

end//
DELIMITER ;

/*           */
drop procedure if exists sp_guess;
delimiter //
create procedure sp_guess(p_user_name varchar(20),p_g_no varchar(4))
begin
	declare g_id_no		int;
	declare right_no	varchar(4);
	declare step_no		int;
	declare resultstr	varchar(4);

	select g_id,a_no into g_id_no,right_no 
	from guess_no where user_name = p_user_name;
	-- if can not find username,start new guess
	if g_id_no is null then
		call sp_start_new_guess(p_user_name,'');
		select g_id,a_no into g_id_no,right_no 
		from guess_no where user_name = p_user_name;
	end if;

	-- compare
	select ft_guess_compare(right_no,p_g_no) into resultstr;
	-- step
	select max(step) + 1 into step_no 
	from guess_no_step where user_name = p_user_name;
	set step_no = ifnull(step_no,1);
	-- insert step
	insert into guess_no_step
	select g_id_no,p_user_name,step_no,p_g_no,resultstr;

	-- if guess number right , start new guess
	if resultstr = '4A0B' then
		call sp_start_new_guess(p_user_name,'');
	end if;

	select resultstr;
end//
DELIMITER ;


drop function if exists ft_guess_compare;
delimiter //
create function ft_guess_compare(p_a_no varchar(4),p_g_no varchar(4))
returns varchar(4)
begin
	declare a_cnt int default 0;
	declare b_cnt int default 0;
	declare pos int default 1;

	while pos <= 4 do
		if substring(p_g_no,pos,1) = substring(p_a_no,pos,1) then
			set a_cnt = a_cnt + 1;
		elseif LOCATE(substring(p_g_no,pos,1), p_a_no) > 0 then
			set b_cnt = b_cnt + 1;
		end if;

		set pos = pos + 1;
	end while;
	return CONCAT(cast(a_cnt as char) , 'A' , cast(b_cnt as char) , 'B');

end//
delimiter ;

drop function if exists ft_guess_create;
delimiter //
create function ft_guess_create()
returns varchar(4)
begin
	declare guess_no varchar(4) default '';
	declare new_no varchar(1) default '';

	select cast(floor(rand()*10) as char) into new_no;
	while length(guess_no) <> 4 do
		if locate(new_no,guess_no) = 0 then
			set guess_no = CONCAT(guess_no,new_no);
		else
			select cast(floor(rand()*10) as char) into new_no;
		end if;
	end while;
	return guess_no;
end//
delimiter ;


drop procedure if exists sp_toplist;
delimiter //
create procedure sp_toplist()
begin
	
end//
delimiter ;

/****test*****/
select ft_guess_create();
select ft_guess_compare('5689','5678');

call sp_start_new_guess('cy','');
call sp_guess('sean','3185');

select * from guess_no;
select * from guess_no_step;
select * from guess_no_history;
select * from guess_no_step_history;

SET SQL_SAFE_UPDATES=0;
/****test*****/

select user_name,cast(avg(step) as decimal(10,3))
from guess_no_step_history
where result = '4A0B'
group by user_name
order by avg(step) desc
