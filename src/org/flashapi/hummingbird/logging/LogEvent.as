// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.logging.LogEvent

package org.flashapi.hummingbird.logging{
    import flash.events.Event;

    public class LogEvent extends Event {

        public static const LOG:String = "log";

        public var level:uint;
        public var message:String;

        public function LogEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false){
            super(_arg_1, _arg_2, _arg_3);
        }
        override public function clone():Event{
            var _local_1:LogEvent = new LogEvent(this.type, this.bubbles, this.cancelable);
            _local_1.level = this.level;
            _local_1.message = this.message;
            return (_local_1);
        }
        override public function toString():String{
            return (this.formatToString("LogEvent", "type", "bubbles", "cancelable", "level", "message"));
        }

    }
}//package org.flashapi.hummingbird.logging

