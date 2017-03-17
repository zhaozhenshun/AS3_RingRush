// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//utils.sqlite.event.SQLiteEvent

package utils.sqlite.event{
    import flash.events.Event;

    public class SQLiteEvent extends Event {

        public static const DATA_READY:String = "dataReady";

        private var _id:uint;

        public function SQLiteEvent(_arg_1:String, _arg_2:uint){
            super(_arg_1);
            _id = _arg_2;
        }
        public function get id():uint{
            return (_id);
        }
        override public function clone():Event{
            return (new SQLiteEvent(type, _id));
        }

    }
}//package utils.sqlite.event

