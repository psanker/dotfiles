" Vim syntax file
" Language:   Transact-SQL
" Maintainer: Krzysztof Cieslak
" Repository: https://github.com/krcs/vim-tsql-syntax
" License:    Vim

if exists("b:current_syntax")
  finish
endif

syn case ignore
setlocal iskeyword+=@-@
setlocal iskeyword+=$

"
" Reserved Keywords:
"
syn keyword tsqlReserved
\ ADD ALTER AS ASC AUTHORIZATION BACKUP BEGIN BREAK BROWSE BULK BY CASCADE
\ CASE CATCH CHECK CHECKPOINT CLOSE CLUSTERED COALESCE COLLATE COLUMN COMMIT COMPUTE
\ CONSTRAINT CONTAINSTABLE CONTINUE CREATE CROSS CURRENT CURRENT_DATE
\ CURRENT_TIME DATABASE DBCC DEALLOCATE DECLARE DEFAULT DELETE DENY DESC DISK
\ DISTINCT DISTRIBUTED DOUBLE DROP DUMP ELSE END ERRLVL ESCAPE EXCEPT EXEC
\ EXECUTE EXIT EXTERNAL FETCH FILE FILLFACTOR FOR FOREIGN FREETEXT
\ FREETEXTTABLE FROM FULL FUNCTION GOTO GRANT GROUP HAVING HOLDLOCK IDENTITYCOL
\ IDENTITY_INSERT IF INDEX INNER INSERT INTO IS JOIN KEY KILL LINENO LOAD MERGE
\ NATIONAL NOCHECK NONCLUSTERED NULL NULLIF OF OFF OFFSETS ON OPEN OPTION ORDER
\ OUTER OVER PERCENT PIVOT PLAN PRECISION PRIMARY PRINT PROC PROCEDURE PUBLIC
\ RAISERROR READTEXT RECONFIGURE REFERENCES REPLICATION RESTORE RESTRICT RETURN
\ RETURNS REVERT REVOKE ROLLBACK ROWCOUNT ROWGUIDCOL RULE SAVE SCHEMA SCHEMABINDING
\ SECURITYAUDIT SELECT SEMANTICKEYPHRASETABLE SEMANTICSIMILARITYDETAILSTABLE
\ SEMANTICSIMILARITYTABLE SET SETUSER SHUTDOWN STATISTICS TABLESAMPLE
\ THEN THROW TO TOP TRAN TRANSACTION TRIGGER TRUNCATE TRY TSEQUAL UNIQUE UNPIVOT UPDATE
\ UPDATETEXT USE USING VALUES VARYING VIEW WAITFOR WHEN WHERE WHILE WITH WRITETEXT
\ NEXT GO WITHIN ENCRYPTION OUT AFTER BEFORE INSENSITIVE SCROLL LOCAL GLOBAL
\ FORWARD_ONLY STATIC KEYSET DYNAMIC FAST_FORWARD READ_ONLY SCROLL_LOCKS
\ OPTIMISTIC TYPE_WARNING
syn match tsqlReserved "CONTAINS"
syn match tsqlReserved "\(LEFT\|RIGHT\)"

"
" Sets:
"
syn keyword tsqlSets
\ ANSI_DEFAULTS ANSI_NULL_DFLT_OFF ANSI_NULL_DFLT_ON ANSI_NULLS ANSI_PADDING
\ ANSI_WARNINGS ARITHABORT ARITHIGNORE CONCAT_NULL_YIELDS_NULL CONTEXT_INFO
\ CURSOR_CLOSE_ON_COMMIT DATEFIRST DATEFORMAT DEADLOCK_PRIORITY FIPS_FLAGGER
\ FMTONLY FORCEPLAN IDENTITY_INSERT IMPLICIT_TRANSACTIONS LANGUAGE LOCK_TIMEOUT
\ NOCOUNT NOEXEC NUMERIC_ROUNDABORT OFFSETS PARSEONLY QUERY_GOVERNOR_COST_LIMIT
\ QUOTED_IDENTIFIER REMOTE_PROC_TRANSACTIONS ROWCOUNT SHOWPLAN_ALL SHOWPLAN_TEXT
\ SHOWPLAN_XML STATISTICS IO STATISTICS PROFILE STATISTICS TIME STATISTICS XML
\ TEXTSIZE TRANSACTION ISOLATION LEVEL XACT_ABORT 

"
" Aggregate Functions:
"
syn keyword tsqlAggregateFn
\ APPROX_COUNT_DISTINCT AVG CHECKSUM_AGG COUNT COUNT_BIG GROUPING GROUPING_ID
\ MAX MIN STDEV STDEVP SUM VAR VARP

"
" Analytic Functions:
"
syn keyword tsqlAnalyticFn
\ CUME_DIST FIRST_VALUE LAG LAST_VALUE LEAD PERCENTILE_COUNT PERCENTILE_DISC
\ PERCENT_RANK

"
" Collation Functions:
"
syn keyword tsqlCollactionFn COLLATIONPROPERTY TERTIARY_WEIGHTS

"
" Configuration Functions:
"
syn keyword tsqlConfigFn
\ @@DATEFIRST @@DBTS @@LANGID @@LANGUAGE @@LOCK_TIMEOUT @@MAX_CONNECTIONS
\ @@MAX_PRECISION @@NESTLEVEL @@OPTIONS @@REMSERVER @@SERVERNAME @@SERVICENAME
\ @@SPID @@TEXTSIZE @@VERSION

"
" Conversion Functions:
"
syn keyword tsqlConvFn CAST CONVERT PARSE TRY_CAST TRY_CONVERT TRY_PARSE

"
" Cryptographic Functions:
"
syn keyword tsqlCryptoFn 
\ ASYMKEYPROPERTY ASYMKEY_ID CERTPROPERTY CERT_ID CRYPT_GEN_RANDOM
\ DECRYPTBYASYMKEY DECRYPTBYCERT DECRYPTBYKEY DECRYPTBYKEYAUTOASYMKEY
\ DECRYPTBYKEYAUTOCERT DECRYPTBYPASSPHRASE ENCRYPTBYASYMKEY ENCRYPTBYCERT
\ ENCRYPTBYKEY ENCRYPTBYPASSPHRASE HASHBYTES IS_OBJECTSIGNED KEY_GUID KEY_ID
\ KEY_NAME SIGNBYASYMKEY SIGNBYCERT SYMKEYPROPERTY VERIFYSIGNEDBYASYMKEY
\ VERIFYSIGNEDBYCERT

"
" Cursor Functions:
"
syn keyword tsqlCursorFn 
\ @@CURSOR_ROWS @@FETCH_STATUS CURSOR_STATUS

"
" Data Type Functions:
"
syn keyword tsqlDataTypeFn
\ DATALENGTH IDENT_CURRENT IDENT_INCR IDENT_SEED IDENTITY SQL_VARIANT_PROPERTY

"
" Date And Time Functions:
"
syn keyword tsqlDateTimeFn
\ DATEFIRST CURRENT_TIMESTAMP CURRENT_TIMEZONE CURRENT_TIMEZONE_ID DATEADD
\ DATEDIFF DATEDIFF_BIG DATEFROMPARTS DATENAME DATEPART DATETIME2FROMPARTS
\ DATETIMEFROMPARTS DATETIMEOFFSETFROMPARTS DAY EOMONTH GETDATE GETUTCDATE
\ ISDATE MONTH SMALLDATETIMEFROMPARTS SWITCHOFFSET SYSDATETIME
\ SYSDATETIMEOFFSET SYSUTCDATETIME TIMEFROMPARTS TODATETIMEOFFSET YEAR

"
" JSON Functions:
"
syn keyword tsqlJsonFn ISJSON JSON_VALUE JSON_QUERY JSON_MODIFY

"
" Mathematical Functions:
"
syn keyword tsqlMathFn
\ ABS ACOS ASIN ATAN ATN2 CEILING COS COT DEGREES EXP FLOOR LOG LOG10 PI POWER
\ RADIANS RAND ROUND SIGN SIN SQRT SQUARE TAN

"
" Logical Functions:
"
syn keyword tsqlLogicFn CHOOSE IIF

"
" Metadata Functions:
"
syn keyword tsqlMetaFn
\ APP_NAME APPLOCK_MODE APPLOCK_TEST ASSEMBLYPROPERTY COL_LENGTH COL_NAME
\ COLUMNPROPERTY DATABASEPROPERTYEX DB_ID DB_NAME FILE_ID FILE_IDEX FILE_NAME
\ FILEGROUP_ID FILEGROUP_NAME FILEGROUPPROPERTY FILEPROPERTY FILEPROPERTYEX
\ FULLTEXTCATALOGPROPERTY FULLTEXTSERVICEPROPERTY INDEX_COL INDEXKEY_PROPERTY
\ INDEXPROPERTY OBJECT_DEFINITION OBJECT_ID OBJECT_NAME OBJECT_SCHEMA_NAME
\ OBJECTPROPERTY OBJECTPROPERTYEX ORIGINAL_DB_NAME PARSENAME SCHEMA_ID
\ SCHEMA_NAME SCOPE_IDENTITY SERVERPROPERTY STATS_DATE TYPE_ID TYPE_NAME
\ TYPEPROPERTY @@PROCID
"TODO
"syn match tsqlMetaFn "\(NEXT\s\+VALUE\s\+FOR\)"

"
" Ranking Functions:
"
syn keyword tsqlRankingFn DENSE_RANK NTILE RANK ROW_NUMBER

"
" Replication Functions:
"
syn keyword tsqlReplicationFn PUBLISHINGSERVERNAME

"
" Rowset Functions:
"
syn keyword tsqlRowsetFn OPENDATASOURCE OPENJSON OPENQUERY OPENROWSET OPENXML

"
" Security Functions:
"
syn keyword tsqlSecFn
\ CERTENCODED CERTPRIVATEKEY CURRENT_USER DATABASE_PRINCIPAL_ID HAS_DBACCESS
\ HAS_PERMS_BY_NAME IS_MEMBER IS_ROLEMEMBER IS_SRVROLEMEMBER LOGINPROPERTY
\ ORIGINAL_LOGIN PERMISSIONS PWDENCRYPT PWDCOMPARE SESSION_USER SESSIONPROPERTY
\ SUSER_ID SUSER_NAME SUSER_SID SUSER_SNAME SYSTEM_USER USER USER_ID USER_NAME

"
" String Functions:
"
syn keyword tsqlStringFn
\ ASCII CHAR CHARINDEX CONCAT CONCAT_WS DIFFERENCE FORMAT LEN LOWER LTRIM
\ NCHAR PATINDEX QUOTENAME REPLACE REPLICATE REVERSE RTRIM SOUNDEX SPACE
\ STR STRING_AGG STRING_ESCAPE STRING_SPLIT STUFF SUBSTRING TRANSLATE TRIM
\ UNICODE UPPER
syn match tsqlStringFn "\<\(left\|right\)\(\_s*(\)\@="

"
" System Functions:
"
syn keyword tsqlSysFn
\ $PARTITION @@ERROR @@IDENTITY @@PACK_RECEIVED @@ROWCOUNT @@TRANCOUNT
\ BINARY_CHECKSUM CHECKSUM COMPRESS CONNECTIONPROPERTY CONTEXT_INFO
\ CURRENT_REQUEST_ID CURRENT_TRANSACTION_ID DECOMPRESS ERROR_LINE
\ ERROR_MESSAGE ERROR_NUMBER ERROR_PROCEDURE ERROR_SEVERITY ERROR_STATE
\ FORMATMESSAGE GET_FILESTREAM_TRANSACTION_CONTEXT GETANSINULL HOST_ID
\ HOST_NAME ISNULL ISNUMERIC MIN_ACTIVE_ROWVERSION NEWID NEWSEQUENTIALID
\ ROWCOUNT_BIG SESSION_CONTEXT XACT_STATE

"
" System Statistical Functions:
"
syn keyword tsqlSysStatFn
\ @@CONNECTIONS @@CPU_BUSY @@IDLE @@IO_BUSY @@PACK_SENT @@PACKET_ERRORS
\ @@TIMETICKS @@TOTAL_ERRORS @@TOTAL_READ @@TOTAL_WRITE

"
" Text And Image Functions:
"
syn keyword tsqlTxtImgFn TEXTPTR TEXTVALID

"
" Trigger Functions:
"
syn keyword tsqlTriggerFn COLUMNS_UPDATED EVENTDATA TRIGGER_NESTLEVEL
"syn match tsqlTriggerFn "UPDATE()"

"
" Comments:
"
syn region tsqlComment start="/\*" end="\*/"
syn match  tsqlComment "--.*$"

"
" Data Types:
"
" Exact numerics:
syn keyword tsqlDataType 
\ bigint numeric bit smallint decimal smallmoney int tinyint money
" Approximate numerics:
syn keyword tsqlDataType float real
" Date and time:
syn keyword tsqlDataType
\ date datetimeoffset datetime2 smalldatetime datetime time
" Character strings:
syn keyword tsqlDataType char varchar text
" Unicode character strings:
syn keyword tsqlDataType nchar nvarchar ntext
" Binary strings: 
syn keyword tsqlDataType binary varbinary image
" Other data types:
syn keyword tsqlDataType 
\ cursor rowversion hierarchyid uniqueidentifier sql_variant xml geometry
\ geography table

"
" Operators:
"
" Logical operators
syn keyword tsqlOperator ALL AND ANY BETWEEN EXISTS IN LIKE NOT OR SOME
" Set operators
syn keyword tsqlOperator UNION INTERSECT
" Arithmetic
"TODO syn match   tsqlOperator "\([+-*/%=<>!\^!~]\)"
" Bitwise
"TODO syn match   tsqlOperator "\(&\|&=\||\||=\|\^|\^=\|\~\)"
" Comparsion
"TODO syn match   tsqlOperator "\(=\|<\|>\|!<\|!=\|!>\)"

"
" Variables:
"
syn match tsqlVariable "@[$@_#[:alnum:]]\+"

"
" Numbers:
"
" Decimal and Money
syn match tsqlNumberDecimal "[[:alnum:]_$]\@<![-+]\=\$\=\.\=\d\+\.\="
" Hex
syn match tsqlNumberHex "\<0x\x\{1,8000\}\>"
" Float
syn match tsqlNumberFloat "[[:alnum:]_$]\@<![-+]\=\d\=\.\d\+[eE]\d\+"

"
" String:
"
syn region tsqlString start=+'+ skip=+'\zs'\|\\'+ end=+'+

"
" Special Characters:
"
syn match tsqlDelimiter "[,]"

"-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
hi def link tsqlReserved      Statement
hi def link tsqlSets          PreProc
hi def link tsqlAggregateFn   Function
hi def link tsqlAnalyticFn    Function
hi def link tsqlCollactionFn  Function
hi def link tsqlConfigFn      Function
hi def link tsqlConvFn        Function
hi def link tsqlCryptoFn      Function
hi def link tsqlCursorFn      Function
hi def link tsqlDataTypeFn    Function
hi def link tsqlDateTimeFn    Function
hi def link tsqlJsonFn        Function
hi def link tsqlMathFn        Function
hi def link tsqlLogicFn       Function
hi def link tsqlMetaFn        Function
hi def link tsqlRankingFn     Function
hi def link tsqlReplicationFn Function
hi def link tsqlRowsetFn      Function
hi def link tsqlSecFn         Function
hi def link tsqlStringFn      Function
hi def link tsqlSysFn         Function
hi def link tsqlSysStatFn     Function
hi def link tsqlTxtImgFn      Function
hi def link tsqlTriggerFn     Function
hi def link tsqlComment       Comment
hi def link tsqlDataType      Type
hi def link tsqlOperator      Operator
hi def link tsqlVariable      Identifier
hi def link tsqlNumberDecimal Number
hi def link tsqlNumberHex     Number
hi def link tsqlNumberFloat   Float
hi def link tsqlString        String
hi def link tsqlDelimiter     Specialchar

let b:current_syntax = "tsql"

