**Football API Integration using SSIS Package with Script Task in C#**
Introduction
This guide provides a comprehensive walkthrough on integrating a Football API using SQL Server Integration Services (SSIS) and a Script Task written in C#. The integration involves fetching football data from the API and storing it in a SQL Server database for further analysis and reporting.

Prerequisites
Before you begin, ensure you have the following:

SQL Server and SQL Server Management Studio (SSMS) installed.
SQL Server Integration Services (SSIS) installed.
Access to a Football API (e.g., football-data.org, API-Football).
Visual Studio with SQL Server Data Tools (SSDT) installed.
Steps
1. Create a New SSIS Project
Open Visual Studio.
Select File > New > Project.
Under Business Intelligence, select Integration Services Project.
Name your project and click OK.
2. Set Up the Football API Connection
In Solution Explorer, right-click on the Connection Managers area and select New Connection.
Choose HTTP Connection Manager and click Add.
Configure the HTTP Connection Manager with the Football API endpoint and any required headers (e.g., API key).
3. Create a Control Flow with a Script Task
Drag a Script Task from the SSIS Toolbox to the Control Flow canvas.
Double-click the Script Task to open the Script Task Editor.
using System;
using System.Data.SqlClient;
using System.IO;
using System.Net;
using Microsoft.SqlServer.Dts.Runtime;
using Newtonsoft.Json.Linq;

public void Main()
{
    string apiUrl = "https://api.football-data.org/v2/matches";
    string apiKey = "YOUR_API_KEY";
    string connectionString = "Your SQL Server Connection String";
    
    try
    {
        // Fetch data from API
        HttpWebRequest request = (HttpWebRequest)WebRequest.Create(apiUrl);
        request.Headers["X-Auth-Token"] = apiKey;
        HttpWebResponse response = (HttpWebResponse)request.GetResponse();
        
        using (StreamReader reader = new StreamReader(response.GetResponseStream()))
        {
            string jsonResponse = reader.ReadToEnd();
            JArray matches = JArray.Parse(jsonResponse);
            
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                foreach (var match in matches)
                {
                    string insertQuery = "INSERT INTO FootballMatches (MatchID, HomeTeam, AwayTeam, HomeScore, AwayScore, MatchDate) VALUES (@MatchID, @HomeTeam, @AwayTeam, @HomeScore, @AwayScore, @MatchDate)";
                    
                    using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@MatchID", (int)match["id"]);
                        cmd.Parameters.AddWithValue("@HomeTeam", (string)match["homeTeam"]["name"]);
                        cmd.Parameters.AddWithValue("@AwayTeam", (string)match["awayTeam"]["name"]);
                        cmd.Parameters.AddWithValue("@HomeScore", (int)match["score"]["fullTime"]["homeTeam"]);
                        cmd.Parameters.AddWithValue("@AwayScore", (int)match["score"]["fullTime"]["awayTeam"]);
                        cmd.Parameters.AddWithValue("@MatchDate", (DateTime)match["utcDate"]);
                        
                        cmd.ExecuteNonQuery();
                    }
                }
            }
        }
        
        Dts.TaskResult = (int)ScriptResults.Success;
    }
    catch (Exception ex)
    {
        Dts.Events.FireError(0, "Script Task", ex.Message, string.Empty, 0);
        Dts.TaskResult = (int)ScriptResults.Failure;
    }
}

4. Configure the Script Task
In the Script Task Editor, click on Edit Script.
In the ScriptMain.cs file, write the C# code to fetch data from the Football API, parse the JSON response, and store the data into a SQL Server table.
Ensure you add necessary references and using directives for HTTP requests and JSON parsing.
Here is an example of what the C# code might look like:

6. Execute the Package
Save your SSIS package.
Right-click on the package in Solution Explorer and select Execute Package.
Verify that the data has been successfully loaded into the target table in SQL Server.
Scheduling the Package
To run the package on a schedule, you can deploy it to SQL Server and create a SQL Server Agent job:

Right-click on the SSIS project in Solution Explorer and select Deploy.
Follow the Deployment Wizard to deploy the package to SQL Server.
In SQL Server Management Studio, create a new SQL Server Agent job.
Add a new job step to execute the deployed SSIS package.
Configure the job schedule as needed.
Error Handling and Logging
To ensure robust error handling and logging:

Add Event Handlers in the SSIS package to capture and log errors.
Use Log Providers to store execution logs for auditing and troubleshooting purposes.
Conclusion
By following this guide, you should have a fully functional SSIS package that integrates with a Football API, extracts data using a Script Task in C#, and stores it in a SQL Server database. This setup enables you to perform further analysis and reporting on the football data.

For any questions or issues, refer to the SSIS documentation and the Football API documentation.
