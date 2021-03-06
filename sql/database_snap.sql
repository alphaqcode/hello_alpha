sp_helpdb 'duxh'
/*
使用快照的限制
    使用快照存在诸多限制，由于列表太长（详细请参考MSDN：http://msdn.microsoft.com/zh-cn/library/ms175158.aspx#LimitationsRequirements）,我只概括的说一下主要限制。

    当使用快照恢复数据库时，首先要删除其他快照
    快照在创建时的时间点上没有commit的数据不会被记入快照
    快照是快照整个数据库，而不是数据库的某一部分
    快照是只读的，意思是不能在快照上加任何更改，即使是你想加一个让报表跑得更快的索引
    在利用快照恢复数据库时，快照和源数据库都不可用
    快照和源数据必须在同一个实例上
    快照数据库的文件必须在NTFS格式的盘上
    当磁盘不能满足快照的增长时，快照数据库会被置为suspect状态
    快照上不能存在全文索引

*/

select * from sys.master_files where name in ('duxh','duxh_snapshot_20140509')

create database duxh_snapshot_20140509
on
(name = duxh ,filename = 'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\DATA\duxh_20140509.snap'),
(name = FileGroup1 ,filename = 'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\DATA\duxh_20140509_FileGroup1.snap')
as SNAPSHOT of duxh



dbcc checkdb

USE duxh_snapshot_20140509
go

select * from items with(nolock)