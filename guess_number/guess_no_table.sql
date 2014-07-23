drop table if exists wx_user;
create table wx_user
	(
		user_name	varchar(20)
	)
;

drop table if exists guess_no;
create table guess_no
	(
		g_id		int primary key auto_increment,
		user_name	varchar(20),
		a_no		varchar(4)
	)
;

drop table if exists guess_no_history;
create table guess_no_history
	(
		g_id		int,
		user_name	varchar(20),
		a_no		varchar(4)
	)
;
drop table if exists guess_no_step;
create table guess_no_step
	(
		g_id		int,
		user_name	varchar(20),
		step		int,
		g_no		varchar(4),
		result		varchar(4)
	)
;
drop table if exists guess_no_step_history;
create table guess_no_step_history
	(
		g_id		int,
		user_name	varchar(20),
		step		int,
		g_no		varchar(4),
		result		varchar(4)
	)
;
