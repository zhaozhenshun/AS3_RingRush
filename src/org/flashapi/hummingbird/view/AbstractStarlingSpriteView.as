// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.view.AbstractStarlingSpriteView

package org.flashapi.hummingbird.view{
    import starling.display.Sprite;
    import org.flashapi.hummingbird.events.StarlingDependencyEvent;
    import starling.events.Event;

    public class AbstractStarlingSpriteView extends Sprite implements IStarlingView {

        public function AbstractStarlingSpriteView(){
            this.initObj();
        }
        public function finalize():void{
        }
        protected function onDependencyComplete():void{
        }
        protected function onAddedToStage():void{
        }
        private function initObj():void{
            this.addEventListener("dependencyComplete", this.dependencyCompleteHandler);
            this.addEventListener("addedToStage", this.addedToStageHandler);
        }
        private function dependencyCompleteHandler(e:StarlingDependencyEvent):void{
            this.removeEventListener("dependencyComplete", this.dependencyCompleteHandler);
            this.onDependencyComplete();
        }
        private function addedToStageHandler(e:Event):void{
            this.removeEventListener("addedToStage", this.addedToStageHandler);
            this.onAddedToStage();
        }

    }
}//package org.flashapi.hummingbird.view

