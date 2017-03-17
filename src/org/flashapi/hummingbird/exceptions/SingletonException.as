// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.exceptions.SingletonException

package org.flashapi.hummingbird.exceptions{
    public class SingletonException extends Error {

        public function SingletonException(message:String=""){
            super(("SingletonException: " + message));
        }
    }
}//package org.flashapi.hummingbird.exceptions

