using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;


namespace e_InventoryCL
{
    class DataBaseManager
    {
        private SqlConnectionStringBuilder ConnectionStr;
        private SqlConnection DBConnection;
        //private SqlCommand SQLcmdSP;
        private EventLogWriter evtWriter;
        

        public DataBaseManager()
        {
            ConnectionStr = new SqlConnectionStringBuilder();
            ConnectionStr.DataSource = ".\\SQLEXPRESS";
            ConnectionStr.InitialCatalog = "e-Inventory";
            ConnectionStr.UserID = "dbmaster";
            ConnectionStr.Password = "New123456+";
            DBConnection = new SqlConnection(ConnectionStr.ConnectionString);
            evtWriter = new EventLogWriter("e-InventoryLibrary", "Application");  
        }
    }
}
