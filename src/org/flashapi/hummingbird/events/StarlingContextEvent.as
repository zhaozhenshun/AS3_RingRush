// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.events.StarlingContextEvent

package org.flashapi.hummingbird.events{
    import flash.events.Event;

    public class StarlingContextEvent extends Event {

        public static const ROOT_CREATION_COMPLETE:String = "rootCreationComplete";

        public function StarlingContextEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Object=null){
            super(_arg_1, _arg_2, _arg_3);
        }
        override public function clone():Event{
            return (new StarlingContextEvent(this.type, this.bubbles, this.cancelable));
        }
        override public function toString():String{
            return (this.formatToString("StarlingContextEvent", "type", "bubbles", "cancelable"));
        }

    }
}//package org.flashapi.hummingbird.events

