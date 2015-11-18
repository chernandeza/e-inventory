using System;
using System.Diagnostics;

namespace e_InventoryCL
{
    #region Clase EventLogWriter
    /// <summary>
    /// Esta clase permite escribir eventos en la bitácora de Windows, en caso de que se desee
    /// realizar una información más clara al usuario de los eventos del software o para informar de
    /// errores o eventos inesperados en la aplicación.
    /// </summary>
    public class EventLogWriter
    {
        #region Atributos de la clase

        private String _source;
        private String _log;
        private String _event;

        #endregion

        #region Métodos de la clase
        private EventLogWriter()
        {
            _source = "";
            _log = "";
            _event = "";
        }

        public EventLogWriter(String Aplicacion, String Bitacora)
        {
            Source = Aplicacion;
            Log = Bitacora;
            Event = "";
        }

        /// <summary>
        /// Name of the application that sends the Event.
        /// </summary>
        public String Source
        {
            get { return _source; }
            set { _source = value; }
        }

        /// <summary>
        /// Name of the log where the class will write the log entry.
        /// </summary>
        public String Log
        {
            get { return _log; }
            set { _log = value; }
        }

        /// <summary>
        /// String of the event going to be written down to the specified log.
        /// </summary>
        public String Event
        {
            get { return _event; }
            set { _event = value; }
        }

        /// <summary>
        /// Writes a Warning Event
        /// </summary>
        /// <param name="Evento">Event description</param>
        public void writeWarning(String Evento)
        {
            if (!EventLog.SourceExists(Source))
                EventLog.CreateEventSource(Source, Log);

            EventLog.WriteEntry(Source, Evento,
            EventLogEntryType.Warning, 13830);
        }

        /// <summary>
        /// Writes an Error Event
        /// </summary>
        /// <param name="Evento">Event description</param>
        public void writeError(String Evento)
        {
            if (!EventLog.SourceExists(Source))
                EventLog.CreateEventSource(Source, Log);

            EventLog.WriteEntry(Source, Evento,
            EventLogEntryType.Error, 13830);
        }

        /// <summary>
        /// Writes an Information Event
        /// </summary>
        /// <param name="Evento">Event Description</param>
        public void writeInfo(String Evento)
        {
            if (!EventLog.SourceExists(Source))
                EventLog.CreateEventSource(Source, Log);

            EventLog.WriteEntry(Source, Evento,
            EventLogEntryType.Information, 13830);
        }
        #endregion
    }
    #endregion
}
