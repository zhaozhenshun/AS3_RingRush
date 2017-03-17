// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.exceptions.InvalidTypeException

package org.flashapi.hummingbird.exceptions{
    public class InvalidTypeException extends Error {

        public function InvalidTypeException(message:String=""){
            super(("InvalidTypeException: " + message));
        }
    }
}//package org.flashapi.hummingbird.exceptions

