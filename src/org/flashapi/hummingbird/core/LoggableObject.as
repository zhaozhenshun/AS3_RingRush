// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.core.LoggableObject

package org.flashapi.hummingbird.core{
    import flash.events.EventDispatcher;
    import org.flashapi.hummingbird.logging.ILogger;

    public class LoggableObject extends EventDispatcher {

        protected function getLogger():ILogger{
            return (HummingbirdBase.getLogger());
        }

    }
}//package org.flashapi.hummingbird.core

