// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.events.StarlingDependencyEvent

package org.flashapi.hummingbird.events{
    import starling.events.Event;

    public class StarlingDependencyEvent extends Event {

        public static const DEPENDENCY_COMPLETE:String = "dependencyComplete";

        public function StarlingDependencyEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Object=null){
            super(_arg_1, _arg_2, _arg_3);
        }
    }
}//package org.flashapi.hummingbird.events

