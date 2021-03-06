--SqlServer的分区分为大致有以下个过程：1、创建文件组用以存放数据文件 2、创建文件组用户数据文件 3、创建分区函数 4、创建分区方案  5、在分区方案下创建表


--1、新建数据库，在属性中创建文件以及文件组


--2、创建分区函数
CREATE PARTITION FUNCTION [partitionById](int) 
AS RANGE LEFT FOR VALUES (100, 200, 300)

--3、创建分区方案
CREATE PARTITION SCHEME [partitionSchemeById] 
AS PARTITION [partitionById] --分区函数
TO ([FileGroup1], [FileGroup2],  [FileGroup3]，[FileGroup4])
/*
注意以上分区函数使用的是LEFT ,根据后面的值指明了数据库中如何存放。以上存放方式为：-∞，100],(100,200],(200,300],(300,+∞）.此分区方案是依据分区函数

partitionById 创建的。那就是说以上Id的存储区间分别被放在[FileGroup1], [FileGroup2],  [FileGroup3]，[FileGroup4]文件组的文件中。
*/


--4、依据分区方案创建表
CREATE TABLE [dbo].[Account](
    [Id] [int] NULL,
    [Name] [varchar](20) NULL,
    [Password] [varchar](20) NULL,
    [CreateTime] [datetime] NULL
) ON partitionSchemeById(Id)

　　--注意：创建表的脚本中需要指明分区方案和分区依据列


--查看某分区的数据：
SELECT * FROM 
[dbo].[Account]
WHERE $PARTITION.[partitionById](Id)=1


--如果数据不停的增长，希望分区也不断的自动增加。如：每天生成一个新的分区来存放分区新的数据。如到第二天时，新生成一个分区来存放(400，500 ]的数据。
--这里我采用了Sql Job的方式来自动产生分区：

DECLARE @maxValue INT,
    @secondMaxValue INT,
    @differ    INT,
    @fileGroupName VARCHAR(200),
    @fileNamePath    VARCHAR(200),
    @fileName   VARCHAR(200),
    @sql        NVARCHAR(1000)


SET @fileGroupName='FileGroup'+REPLACE(REPLACE(REPLACE(CONVERT(varchar, GETDATE(), 120 ),'-',''),' ',''),':','') 
PRINT @fileGroupName
SET @sql='ALTER DATABASE [Test] ADD FILEGROUP '+@fileGroupName
PRINT @sql
--EXEC(@sql)

SET @fileNamePath='C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLINSTANCE\MSSQL\DATA\'+REPLACE(REPLACE(REPLACE(CONVERT(varchar, GETDATE(), 120 ),'-',''),' ',''),':','') +'.NDF'
SET @fileName=N'File'+REPLACE(REPLACE(REPLACE(CONVERT(varchar, GETDATE(), 120 ),'-',''),' ',''),':','') 


SET @sql='ALTER DATABASE [Test] ADD FILE (NAME='''+@fileName+''',FILENAME=N'''+@fileNamePath+''') TO FILEGROUP'+'    '+@fileGroupName
PRINT @sql
PRINT 1
--EXEC(@sql)
PRINT 2

--修改分区方案，用一个新的文件组用于存放下一新增的数据
SET @sql='ALTER PARTITION SCHEME [partitionSchemeById] NEXT USED'+'    '+@fileGroupName
EXEC(@sql)
  --分区架构
PRINT 3 

SELECT @maxValue =CONVERT(INT,MAX(value))
FROM SYS.PARTITION_RANGE_VALUES PRV

SELECT @secondMaxValue = CONVERT(INT,MIN(value))
FROM 
(
    SELECT TOP 2 * FROM SYS.PARTITION_RANGE_VALUES ORDER BY VALUE DESC
)
 PRV 

SET @differ=@maxValue - @secondMaxValue 


ALTER PARTITION FUNCTION partitionById()  --分区函数
SPLIT RANGE (@maxValue+@differ) 

--当分拆逻辑为时间时,每个月增加一个分区
ALTER PARTITION FUNCTION partotionById()
SPLIT RANGE (LEFT(CONVERT(VARCHAR(20),GETDATE(),112)),6)


--SELECT LEFT(CONVERT(VARCHAR(20),GETDATE(),112),6)