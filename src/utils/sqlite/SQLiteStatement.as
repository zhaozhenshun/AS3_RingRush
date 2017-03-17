// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//utils.sqlite.SQLiteStatement

package utils.sqlite{
    import flash.events.EventDispatcher;
    import flash.data.SQLStatement;
    import utils.sqlite.event.SQLiteEvent;
    import flash.events.SQLEvent;
    import flash.data.SQLConnection;

    public final class SQLiteStatement extends EventDispatcher {

        public var uid:uint;
        public var statement:SQLStatement;
        public var callback:Function;
        public var readyFunction:Function;
        private var _execute:Boolean;
        private var _query:String;
        private var _itemClass:Class;

        public function set itemClass(name:Class):void{
            _itemClass = name;
            if (statement != null)
            {
                statement.itemClass = _itemClass;
            };
        }
        public function set query(value:String):void{
            _query = value;
            if (statement != null)
            {
                statement.text = _query;
            };
        }
        public function getResult(e:SQLEvent):void{
            if (callback != null)
            {
                (callback(statement.getResult()));
            };
            this.dispatchEvent(new SQLiteEvent("dataReady", uid));
        }
        public function connectionReady(e:SQLEvent):void{
            statement.sqlConnection = (e.target as SQLConnection);
            if (_execute)
            {
                statement.execute();
                _execute = false;
            };
        }
        public function execute():void{
            if (statement != null)
            {
                statement.text = _query;
                if (_itemClass != null)
                {
                    statement.itemClass = _itemClass;
                };
                if (statement.sqlConnection != null)
                {
                    if (statement.sqlConnection.connected)
                    {
                        statement.execute();
                        _execute = false;
                    }
                    else
                    {
                        _execute = true;
                    };
                }
                else
                {
                    _execute = true;
                };
            };
        }

    }
}//package utils.sqlite

