using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace e_InventoryCL
{
    class SpecialException : Exception
    {
        private String _customMsg;

        public String CustomMessage
        {
            get { return _customMsg; }
            set { _customMsg = value; }
        }

        public SpecialException(String msg)
        {
            this.CustomMessage = msg + " " + base.Message;
        }
    }
}
