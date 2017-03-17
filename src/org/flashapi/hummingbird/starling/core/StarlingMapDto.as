// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.starling.core.StarlingMapDto

package org.flashapi.hummingbird.starling.core{
    import org.flashapi.hummingbird.core.IFinalizable;
    import org.flashapi.hummingbird.starling.StarlingID;
    import flash.display.Stage;
    import org.flashapi.hummingbird.utils.DtoUtil;

    public class StarlingMapDto implements IFinalizable {

        public var starlingID:StarlingID;
        public var stage:Stage;

        public function finalize():void{
            this.starlingID = null;
            this.stage = null;
        }
        public function toString():String{
            return (DtoUtil.formatToString(this, "StarlingMapDto", "starlingID", "stage"));
        }

    }
}//package org.flashapi.hummingbird.starling.core

