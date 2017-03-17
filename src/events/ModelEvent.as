// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//events.ModelEvent

package events{
    import flash.events.Event;

    public class ModelEvent extends Event {

        public static const STATE_CHANGE:String = "stateChange";
        public static const PLAYER_STATE_CHANGE:String = "playerStateChange";
        public static const SHOW_POPUP:String = "showPopup";
        public static const AD_DONE:String = "adDone";
        public static const AD_ERROR:String = "adError";
        public static const NET_STATE_CHANGED:String = "netStateChanged";
        public static const NEW_HIGHSCORE:String = "newHighscore";
        public static const GAMESERVICE_READY:String = "gameServiceReady";
        public static const PURCHASE_START:String = "purchaseStart";
        public static const PURCHASE_SUCCESS:String = "purchaseSuccess";
        public static const PURCHASE_CANCEL:String = "purchaseCancel";
        public static const PURCHASE_FAILED:String = "purchaseFailed";
        public static const PURCHASE_SUPORTED:String = "purchaseSuported";
        public static const PURCHASE_PRODUCT_READY:String = "purchaseProductReady";
        public static const RELEASE_DEBUG:String = "releaseDebug";

        public function ModelEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false){
            super(_arg_1, _arg_2, _arg_3);
        }
        override public function clone():Event{
            return (new ModelEvent(this.type, this.bubbles, this.cancelable));
        }
        override public function toString():String{
            return (this.formatToString("ModelEvent", "type", "bubbles", "cancelable"));
        }

    }
}//package events

