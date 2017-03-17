// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//utils.BasicButton

package utils{
    import starling.display.DisplayObjectContainer;
    import starling.display.Sprite;
    import flash.ui.Mouse;
    import starling.events.Touch;
    import starling.events.TouchEvent;

    public class BasicButton extends DisplayObjectContainer {

        private static const MAX_DRAG_DIST:Number = 50;

        public var content:Sprite;
        private var mScaleWhenDown:Number;
        private var mAlphaWhenDisabled:Number;
        private var mEnabled:Boolean;
        private var mIsDown:Boolean;
        private var mUseHandCursor:Boolean;

        public function BasicButton(){
            mAlphaWhenDisabled = 0.5;
            mEnabled = true;
            mIsDown = false;
            mUseHandCursor = true;
            content = new Sprite();
            addChild(content);
            addEventListener("touch", onTouch);
        }
        protected function up():void{
            mIsDown = false;
        }
        protected function down():void{
            mIsDown = true;
        }
        private function onTouch(event:TouchEvent):void{
            var _local_3 = null;
            Mouse.cursor = ((((((mUseHandCursor) && (mEnabled))) && (event.interactsWith(this)))) ? "button" : "auto");
            var _local_2:Touch = event.getTouch(this);
            if (((!(mEnabled)) || ((_local_2 == null))))
            {
                return;
            };
            if ((((_local_2.phase == "began")) && (!(mIsDown))))
            {
                down();
            }
            else
            {
                if ((((_local_2.phase == "moved")) && (mIsDown)))
                {
                    _local_3 = getBounds(stage);
                    if ((((((((_local_2.globalX < (_local_3.x - 50))) || ((_local_2.globalY < (_local_3.y - 50))))) || ((_local_2.globalX > ((_local_3.x + _local_3.width) + 50))))) || ((_local_2.globalY > ((_local_3.y + _local_3.height) + 50)))))
                    {
                        up();
                    };
                }
                else
                {
                    if ((((_local_2.phase == "ended")) && (mIsDown)))
                    {
                        up();
                        dispatchEventWith("triggered", true);
                    };
                };
            };
        }
        public function get scaleWhenDown():Number{
            return (mScaleWhenDown);
        }
        public function set scaleWhenDown(value:Number):void{
            mScaleWhenDown = value;
        }
        public function get alphaWhenDisabled():Number{
            return (mAlphaWhenDisabled);
        }
        public function set alphaWhenDisabled(value:Number):void{
            mAlphaWhenDisabled = value;
        }
        public function get enabled():Boolean{
            return (mEnabled);
        }
        public function set enabled(value:Boolean):void{
            if (mEnabled != value)
            {
                mEnabled = value;
                content.alpha = ((value) ? 1 : mAlphaWhenDisabled);
                up();
            };
        }
        override public function get useHandCursor():Boolean{
            return (mUseHandCursor);
        }
        override public function set useHandCursor(value:Boolean):void{
            mUseHandCursor = value;
        }

    }
}//package utils

