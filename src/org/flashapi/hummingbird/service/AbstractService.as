// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.service.AbstractService

package org.flashapi.hummingbird.service{
    import org.flashapi.hummingbird.core.LoggableObject;

    public class AbstractService extends LoggableObject implements IService {

        public function finalize():void{
        }
        protected function operationResult(responder:ServiceResponder, result:Object):void{
            responder.onResult(result);
        }
        protected function operationFault(responder:ServiceResponder, fault:Object):void{
            responder.onStatus(fault, this);
        }

    }
}//package org.flashapi.hummingbird.service

