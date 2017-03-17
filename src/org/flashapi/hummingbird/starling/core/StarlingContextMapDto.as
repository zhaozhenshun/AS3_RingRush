// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.starling.core.StarlingContextMapDto

package org.flashapi.hummingbird.starling.core{
    import org.flashapi.hummingbird.core.IFinalizable;
    import starling.core.Starling;
    import org.flashapi.hummingbird.core.IApplicationContext;
    import org.flashapi.hummingbird.utils.DtoUtil;

    public class StarlingContextMapDto implements IFinalizable {

        public var starling:Starling;
        public var context:IApplicationContext;

        public function finalize():void{
            this.starling = null;
            this.context = null;
        }
        public function toString():String{
            return (DtoUtil.formatToString(this, "StarlingContextMapDto", "starling", "context"));
        }

    }
}//package org.flashapi.hummingbird.starling.core

