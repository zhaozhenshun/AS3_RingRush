// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.core.HummingbirdEventDispatcher

package org.flashapi.hummingbird.core{
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    import org.flashapi.hummingbird.exceptions.SingletonException;

    public class HummingbirdEventDispatcher extends EventDispatcher implements IEventDispatcher {

        private static const INSTANCE:HummingbirdEventDispatcher = new (HummingbirdEventDispatcher)();

        public function HummingbirdEventDispatcher(){
            if (INSTANCE)
            {
                throw (new SingletonException("you must use the getInstance() method to access HummingbirdEventDispatcher instances"));
            };
            this.initObj();
        }
        public static function getInstance():HummingbirdEventDispatcher{
            return (HummingbirdEventDispatcher.INSTANCE);
        }

        private function initObj():void{
            HummingbirdBase.getLogger().config("Hummingbird event dispatcher created");
        }

    }
}//package org.flashapi.hummingbird.core

