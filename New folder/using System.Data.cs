using System.Data.SqlClient;

namespace DaiLyXayDung.DAL
{
    public class DatabaseConnect
    {
        // Thay đổi ServerName và DatabaseName cho phù hợp với máy của bạn
        private static string connectionString = @"Data Source=localhost;Initial Catalog=QL_VLXD_ThanhCong;Integrated Security=True;";

        public static SqlConnection GetConnection()
        {
            return new SqlConnection(connectionString);
        }
    }
}