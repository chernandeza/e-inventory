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
    class DataBaseManager : IDisposable
    {
        private SqlConnectionStringBuilder ConnectionStr;
        private SqlConnection DBConnection;
        private SqlCommand SQLcmdSP;
        private EventLogWriter evtWriter;
        

        public DataBaseManager()
        {
            ConnectionStr = new SqlConnectionStringBuilder();
            ConnectionStr.DataSource = ".\\SQLEXPRESS";
            ConnectionStr.InitialCatalog = "e-Inventory";
            ConnectionStr.UserID = "invUser";
            ConnectionStr.Password = "New123456+";
            DBConnection = new SqlConnection(ConnectionStr.ConnectionString);
            SQLcmdSP = new SqlCommand();
            evtWriter = new EventLogWriter("e-InventoryLibrary", "Application");            
        }

        /// <summary>
        /// Inserts a new user to the database
        /// </summary>
        /// <param name="newU">User's object containing data to be inserted</param>
        /// <returns>True if the insertion was successful</returns>
        public bool AddNewUser(User newU)
        {
            try
            {
                DBConnection.Open();
                SQLcmdSP = new SqlCommand("sp_AddNewUser", DBConnection);
                SQLcmdSP.CommandType = CommandType.StoredProcedure;
                SQLcmdSP.Parameters.Add(new SqlParameter("@userName", SqlDbType.NVarChar, 50));
                SQLcmdSP.Parameters.Add(new SqlParameter("@userEmail", SqlDbType.NVarChar, 100));
                SQLcmdSP.Parameters.Add(new SqlParameter("@userPasswd", SqlDbType.NVarChar, 250));
                SQLcmdSP.Parameters.Add(new SqlParameter("@userAlias", SqlDbType.NVarChar, -1));
                SQLcmdSP.Parameters.Add(new SqlParameter("@userRole", SqlDbType.Int));
                SQLcmdSP.Parameters.Add(new SqlParameter("@userCompany", SqlDbType.NVarChar, 100));
                SQLcmdSP.Parameters.Add(new SqlParameter("@inventoryName", SqlDbType.NVarChar, 100));
                SQLcmdSP.Parameters[0].Value = newU.Username;
                SQLcmdSP.Parameters[1].Value = newU.Email;
                SQLcmdSP.Parameters[2].Value = newU.Password;
                SQLcmdSP.Parameters[3].Value = newU.UserAlias;
                SQLcmdSP.Parameters[4].Value = newU.UserRole;
                SQLcmdSP.Parameters[5].Value = newU.Branch;
                SQLcmdSP.Parameters[6].Value = newU.DefaultInventory;

                int i = SQLcmdSP.ExecuteNonQuery();
                evtWriter.writeInfo("Provider" + newU.Email + "added to DB successfully");
                return true;
            }
            catch (Exception exc)
            {
                evtWriter.writeError("Error adding Provider " + newU.Email + " to DB" + Environment.NewLine + exc.Message);
                return false;
            }
            finally
            {
                SQLcmdSP.Dispose();
                DBConnection.Close();
            }
        }

        /// <summary>
        /// Adds a product to a user's inventory
        /// </summary>
        /// <param name="pD">Details about a product</param>
        /// <param name="uSi">User session information</param>
        /// <returns>True if the transaction is successful</returns>
        public bool AddProductToInventory(ProductDetails pD, UserSessionInfo uSi)
        {
            try
            {
                DBConnection.Open();
                SQLcmdSP = new SqlCommand("sp_AddProductToInventory", DBConnection);
                SQLcmdSP.CommandType = CommandType.StoredProcedure;
                SQLcmdSP.Parameters.Add(new SqlParameter("@inventoryID", SqlDbType.Int, 0));
                SQLcmdSP.Parameters.Add(new SqlParameter("@productID", SqlDbType.Int, 0));
                SQLcmdSP.Parameters.Add(new SqlParameter("@prodQuantity", SqlDbType.Int, 0));
                SQLcmdSP.Parameters.Add(new SqlParameter("@prodPrice", SqlDbType.Int, 0));
                SQLcmdSP.Parameters.Add(new SqlParameter("@providerID", SqlDbType.Int, 0));
                SQLcmdSP.Parameters[0].Value = uSi.InventoryID;
                SQLcmdSP.Parameters[1].Value = pD.ProductX.GTIN;
                SQLcmdSP.Parameters[2].Value = pD.Quantity;
                SQLcmdSP.Parameters[3].Value = pD.ProductPrice;
                SQLcmdSP.Parameters[4].Value = pD.ProviderID;
                int i = SQLcmdSP.ExecuteNonQuery();
                evtWriter.writeInfo("Product " + pD.ProductX.GTIN +  " successfully updated in DB");
                return true;
            }
            catch (Exception exc)
            {
                evtWriter.writeError("Error adding product " + pD.ProductX.GTIN + " to DB" + Environment.NewLine + exc.Message);
                return false;
            }
            finally
            {
                SQLcmdSP.Dispose();
                DBConnection.Close();
            }
        }

        /// <summary>
        /// Inserts a product in the catalog
        /// </summary>
        /// <param name="P">Product to insert</param>
        /// <returns>True if the transaction is successful</returns>
        public bool InsertNewProduct(Product P)
        {
            /*Ver. 1.0.01*/
            //At this time, all objects are inserted to the catalog without optional parameters
            try
            {
                DBConnection.Open();
                SQLcmdSP = new SqlCommand("sp_InsertNewProduct", DBConnection);
                SQLcmdSP.CommandType = CommandType.StoredProcedure;
                SQLcmdSP.Parameters.Add(new SqlParameter("@gtinNum", SqlDbType.Int, 0));
                SQLcmdSP.Parameters.Add(new SqlParameter("@prodDesc", SqlDbType.Int, 0));
                
                SQLcmdSP.Parameters[0].Value = P.GTIN;
                SQLcmdSP.Parameters[1].Value = P.Description;

                int i = SQLcmdSP.ExecuteNonQuery();
                evtWriter.writeInfo("Product " + P.GTIN + " successfully updated in DB");
                return true;
            }
            catch (Exception exc)
            {
                evtWriter.writeError("Error adding product " + P.GTIN + " to DB" + Environment.NewLine + exc.Message);
                return false;
            }
            finally
            {
                SQLcmdSP.Dispose();
                DBConnection.Close();
            }
        }

        /// <summary>
        /// Updates the available quantity of a product in an inventory
        /// </summary>
        /// <param name="pD">Product Details Object</param>
        /// <param name="uSi">User Session Info</param>
        /// <returns>True if transaction is successful</returns>
        public bool UpdateProductInventory(ProductDetails pD, UserSessionInfo uSi)
        {
            try
            {
                DBConnection.Open();
                SQLcmdSP = new SqlCommand("sp_UpdateProductInventory", DBConnection);
                SQLcmdSP.CommandType = CommandType.StoredProcedure;
                SQLcmdSP.Parameters.Add(new SqlParameter("@productID", SqlDbType.Int, 0));
                SQLcmdSP.Parameters.Add(new SqlParameter("@quantity", SqlDbType.Int, 0));
                SQLcmdSP.Parameters.Add(new SqlParameter("@prodInventory", SqlDbType.Int, 0));
                SQLcmdSP.Parameters[0].Value = pD.ProductX.GTIN;
                SQLcmdSP.Parameters[1].Value = pD.Quantity;
                SQLcmdSP.Parameters[2].Value = uSi.InventoryID;
                int i = SQLcmdSP.ExecuteNonQuery();
                evtWriter.writeInfo("Product " + pD.ProductX.GTIN + " successfully updated in DB");
                return true;
            }
            catch (Exception exc)
            {
                evtWriter.writeError("Error updating product " + pD.ProductX.GTIN + " to DB" + Environment.NewLine + exc.Message);
                return false;
            }
            finally
            {
                SQLcmdSP.Dispose();
                DBConnection.Close();
            }
        }

        /* - Obtener información de producto
         * - Obtener inventario de un usuario
         * - Generar lista inteligente
         */




        /*
        * Garbage Collection Dispose Methods implemented as Programming Best Practices.
        */
        protected virtual void Dispose(bool disposing)
        {
            if (disposing)
            {
                // dispose managed resources
                DBConnection.Close();
                SQLcmdSP.Dispose();
            }
            // free native resources
        }

        /// <summary>
        /// Disposes the DBConnector object
        /// </summary>  
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
    }
}
