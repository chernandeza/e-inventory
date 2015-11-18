using System;
using System.Runtime.Serialization.Formatters.Binary;
using System.IO;

namespace e_InventoryCL
{
    public static class ObjSerializer
    {
        // Convert an object to a byte array
        public static byte[] ObjectToByteArray(Object obj)
        {
            try
            {
                if (obj == null)
                    return null;
                BinaryFormatter bf = new BinaryFormatter();
                MemoryStream ms = new MemoryStream();
                bf.Serialize(ms, obj);
                return ms.ToArray();
            }
            catch (Exception ex)
            {
                throw new SpecialException("ObjectToByteArray: " + ex.Message);
            }
        }
        // Convert a byte array to an Object
        public static Object ByteArrayToObject(byte[] arrBytes)
        {
            try
            {
                MemoryStream memStream = new MemoryStream();
                BinaryFormatter binForm = new BinaryFormatter();
                memStream.Write(arrBytes, 0, arrBytes.Length);
                //memStream.Flush();
                //memStream.Seek(0, SeekOrigin.Begin);
                memStream.Position = 0;
                Object obj = (Object)binForm.Deserialize(memStream);
                return obj;
            }
            catch (Exception ex)
            {
                throw new SpecialException("ByteArrayToObject: " + ex.Message);
            }
        }
    }
}