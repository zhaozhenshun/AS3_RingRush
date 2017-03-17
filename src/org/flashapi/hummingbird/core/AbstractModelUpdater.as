// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.core.AbstractModelUpdater

package org.flashapi.hummingbird.core{
    import org.flashapi.hummingbird.events.DependencyEvent;

    public class AbstractModelUpdater extends LoggableObject {

        public function AbstractModelUpdater(){
            this.initObj();
        }
        public function finalize():void{
        }
        protected function onDependencyComplete():void{
        }
        private function initObj():void{
            this.addEventListener("dependencyComplete", this.dependencyCompleteHandler);
        }
        private function dependencyCompleteHandler(e:DependencyEvent):void{
            this.removeEventListener("dependencyComplete", this.dependencyCompleteHandler);
            this.onDependencyComplete();
        }

    }
}//package org.flashapi.hummingbird.core

