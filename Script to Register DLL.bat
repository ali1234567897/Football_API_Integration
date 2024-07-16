PATH "C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.8 Tools\"



del "C:\Users\SMART TECH\AppData\Local\Temp\Vsta\SSIS_ST160\VstapLt3XQRKIkm3ZmqMJ74XOw\packages\System.Data.SqlClient.4.8.6\lib\net461\System.Data.SqlClient.dll"
del "C:\Users\SMART TECH\AppData\Local\Temp\Vsta\SSIS_ST160\VstapLt3XQRKIkm3ZmqMJ74XOw\packages\System.Data.SqlClient.4.8.6\lib\net461\System.Data.SqlClient.dll"
del "C:\Users\SMART TECH\AppData\Local\Temp\Vsta\SSIS_ST160\VstapLt3XQRKIkm3ZmqMJ74XOw\packages\System.Data.SqlClient.4.8.6\lib\net461\System.Data.SqlClient.dll"
del "C:\Users\SMART TECH\AppData\Local\Temp\Vsta\SSIS_ST160\VstapLt3XQRKIkm3ZmqMJ74XOw\packages\System.Data.SqlClient.4.8.6\lib\net461\System.Data.SqlClient.dll"


copy "C:\ETL Packages\FootballData\DLL Re\System.Data.SqlClient.dll" "C:\Program Files (x86)\Microsoft SQL Server\110\DTS\Tasks" /Y
copy "C:\ETL Packages\FootballData\DLL Re\System.Data.SqlClient.dll" "C:\Program Files (x86)\Microsoft SQL Server\120\DTS\Tasks" /Y
copy "C:\ETL Packages\FootballData\DLL Re\System.Data.SqlClient.dll" "C:\Program Files (x86)\Microsoft SQL Server\130\DTS\Tasks" /Y
copy "C:\ETL Packages\FootballData\DLL Re\System.Data.SqlClient.dll" "C:\Program Files (x86)\Microsoft SQL Server\140\DTS\Tasks" /Y

gacutil -u System.Data.SqlClient.dll


gacutil -i "C:\ETL Packages\FootballData\DLL Re\System.Data.SqlClient.dll"




pause

