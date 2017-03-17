// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.service.ServiceResponder

package org.flashapi.hummingbird.service{
    import org.flashapi.hummingbird.core.HummingbirdBase;

    public class ServiceResponder {

        private var _resultHandler:Function;
        private var _statusHandler:Function;

        public function ServiceResponder(result:Function, status:Function=null){
            this.initObj(result, status);
        }
        function onResult(result:Object):void{
            _resultHandler(result); //not popped
        }
        function onStatus(fault:Object, service:IService):void{
            if (_statusHandler != null)
            {
                (_statusHandler(fault));
            }
            else
            {
                HummingbirdBase.getLogger().warn(("No status function is defined for handling a service error on " + service));
            };
        }
        private function initObj(result:Function, status:Function=null):void{
            _resultHandler = result;
            _statusHandler = status;
        }

    }
}//package org.flashapi.hummingbird.service

