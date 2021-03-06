--
--alphaqcode
USE master
go
SELECT  name ,
        CASE is_published
          WHEN 0 THEN N'未发布'
          ELSE N'已发布'
        END N'是否发布' ,
        CASE is_subscribed
          WHEN 0 THEN N'未订阅'
          ELSE N'已订阅'
        END N'是否订阅'
FROM    sys.databases
WHERE   name = 'AdventureWorks'

USE duxh
go
UPDATE  dbo.trace_duxh_20140519
SET TextData = 'test 3rd publish for update datetime2',
	StartTime = GETDATE()
WHERE RowNumber = 1

SELECT * FROM duxh.dbo.trace_duxh_20140519
WHERE RowNumber = 1

USE duxh_sub
go
DELETE FROM dbo.trace_duxh_20140519
--SELECT * FROM duxh_sub.dbo.trace_duxh_20140519
WHERE RowNumber = 1

SET IDENTITY_INSERT dbo.trace_duxh_20140519 ON
 
INSERT INTO dbo.trace_duxh_20140519
        ( 
			RowNumber,
		EventClass ,
          TextData ,
          SPID ,
          StartTime ,
          BinaryData
        )
VALUES  ( 1,
			0 , -- EventClass - int
          NULL , -- TextData - ntext
          0 , -- SPID - int
          '2014-05-29 06:25:01' , -- StartTime - datetime
          NULL  -- BinaryData - image
        )



SELECT * FROM [散發].dbo.MSrepl_errors
ORDER BY time DESC
--根据上面查询的结果，取出xact_seqno（出错的命令的事务号）、command_id（命令id），在根据下面的系统存储过程定位到具体的语句
USE [散發]
go
sp_browsereplcmds '0x0000001900000131000900000000','0x0000001900000131000900000000' --两个字符串均是上一步获取的xact_seqno

{CALL [sp_MSupd_dbotrace_duxh_20140519] (,,N'test 3rd publish for update not found',,,,1,0x04)}
{CALL [sp_MSupd_dbotrace_duxh_20140519] (,,N'test 3rd publish for update datetime2',,2014-05-29 14:50:12.453,,1,0x14)}

DECLARE @bitmap binary(1) 
SET @bitmap = 0x14
SELECT  SUBSTRING(@bitmap,1,1)
SELECT  SUBSTRING(@bitmap,1,1) & 4
SELECT  SUBSTRING(@bitmap,1,1) & 16

SELECT CONVERT(binary(1) ,2)
SELECT CONVERT(binary(1) ,4)
SELECT CONVERT(binary(1) ,8)
SELECT CONVERT(binary(1) ,16)
SELECT CONVERT(binary(1) ,32)
SELECT CONVERT(binary(1) ,64)
SELECT CONVERT(binary(1) ,128)
SELECT CONVERT(binary(1) ,256)

SELECT CONVERT(INT,0XFF)


SELECT 4&14
100


USE duxh_sub
go
sp_helptext '[sp_MSupd_dbotrace_duxh_20140519]'

create procedure [sp_MSupd_dbotrace_duxh_20140519]   
 @c1 int = null,@c2 int = null,@c3 ntext = null,@c4 int = null,@c5 datetime = null,@c6 image = null,@pkc1 int  
,@bitmap binary(1)  
as  
begin  
update [dbo].[trace_duxh_20140519] set   
 [EventClass] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [EventClass] end  
,[TextData] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [TextData] end  
,[SPID] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [SPID] end  
,[StartTime] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [StartTime] end  
,[BinaryData] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [BinaryData] end  
where [RowNumber] = @pkc1  
if @@rowcount = 0  
    if @@microsoftversion>0x07320000  
        exec sp_MSreplraiserror 20598  
end  