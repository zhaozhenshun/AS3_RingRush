// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.events.DependencyEvent

package org.flashapi.hummingbird.events{
    import flash.events.Event;

    public class DependencyEvent extends Event {

        public static const DEPENDENCY_COMPLETE:String = "dependencyComplete";

        public function DependencyEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false){
            super(_arg_1, _arg_2, _arg_3);
        }
        override public function clone():Event{
            return (new DependencyEvent(this.type, this.bubbles, this.cancelable));
        }
        override public function toString():String{
            return (this.formatToString("DependencyEvent", "type", "bubbles", "cancelable"));
        }

    }
}//package org.flashapi.hummingbird.events

