// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//utils.sqlite.SQLiteService

package utils.sqlite{
    import org.flashapi.hummingbird.service.AbstractService;
    import flash.filesystem.File;
    import flash.data.SQLConnection;
    import utils.Dictionary;
    import flash.data.SQLStatement;
    import flash.events.SQLErrorEvent;
    import utils.sqlite.event.SQLiteEvent;

    [Qualifier(alias="SQLiteService")]
    public final class SQLiteService extends AbstractService implements ISQLiteService {

        private var _db:File;
        private var _connection:SQLConnection;
        private var _dictionary:Dictionary;
        private var _index:int = 0;

        public function SQLiteService(){
            _dictionary = new Dictionary();
            _connection = new SQLConnection();
        }
        public function setDataBase(src:String):void{
            _db = File.applicationDirectory.resolvePath(src);
            if (_db.exists)
            {
                _connection.addEventListener("error", getError, false, 0, true);
                _connection.openAsync(_db);
            };
        }
        public function addSQLiteStatement(statement:SQLiteStatement):void{
            statement.statement = new SQLStatement();
            statement.statement.addEventListener("error", getError, false, 0, true);
            statement.statement.addEventListener("result", statement.getResult, false, 0, true);
            statement.addEventListener("dataReady", ready, false, 0, true);
            if (!_connection.connected)
            {
                _connection.addEventListener("open", statement.connectionReady, false, 0, true);
            }
            else
            {
                statement.statement.sqlConnection = _connection;
            };
            _dictionary.setValue(_index, statement);
            _index++;
        }
        public function getSQLiteStatement(uid:uint):SQLiteStatement{
            return (null);
        }
        protected function getError(e:SQLErrorEvent):void{
            trace(((("Message: " + e.error.message) + " Details: ") + e.error.details)); //not popped
        }
        private function ready(e:SQLiteEvent):void{
            var _local_3:uint = e.id;
            var _local_2:SQLiteStatement = _dictionary.getValue(_local_3);
            if (_local_2 != null)
            {
                _local_2.removeEventListener("dataReady", ready);
                _local_2.statement.removeEventListener("error", getError);
                _local_2.statement.removeEventListener("result", _local_2.getResult);
                _connection.removeEventListener("open", _local_2.connectionReady);
                _local_2.statement.sqlConnection = null;
                _dictionary.removeValue(_local_3);
            };
        }

    }
}//package utils.sqlite

