using Godot;
using System;
using System.Data.SqlClient;

public partial class Main : Node
{
	Label chatOutput;
	
	private string connectionString;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		
		/* var builder = new SqlConnectionStringBuilder {
			["Initial Catalog"] = "GDDDatabase",
			["Data Source"] = "",
			["User ID"] = "",
			["Password"] = "",
		};

		connectionString = builder.ConnectionString;

		using (SqlConnection conn = new SqlConnection(connectionString)) {
			conn.Open();

			string insertCommand = @"
				INSERT INTO promptHistory (userId, promptText, createdAt, gptResponse)
				VALUES (@UserId, @PromptText, GETDATE(), @GptResponse);
			";

			using (SqlCommand cmd = new SqlCommand(insertCommand, conn)) {
				cmd.Parameters.AddWithValue("@UserId", 238);
				cmd.Parameters.AddWithValue("@PromptText", "vs");
				cmd.Parameters.AddWithValue("@GptResponse", "vs");

				cmd.ExecuteNonQuery();
			}
		}
		*/
		
		
	}
	

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}
}
