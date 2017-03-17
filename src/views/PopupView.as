// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//views.PopupView

package views{
	import controllers.ViewsController;
    import org.flashapi.hummingbird.view.AbstractStarlingSpriteView;
    import service.ISoundService;
    import controllers.IViewsController;
    import starling.display.Quad;
    import utils.BasicButton;
    import starling.text.TextField;
    import starling.display.Sprite;
    import starling.animation.DelayedCall;
    import starling.animation.Tween;
    import starling.core.Starling;
    import constants.App;
    import starling.events.Event;

    public class PopupView extends AbstractStarlingSpriteView implements IGameView {

        [Model(alias="SoundService")]
        public var sound:ISoundService;
        [Controller(alias="ViewsController")]
        public var viewsController:IViewsController = ViewsController.GetInstance();
        protected var _id:uint = 0;
        protected var _bg:Quad;
        protected var _closeBtn:BasicButton;
        protected var _closeBtnText:TextField;
        protected var _container:Sprite;
        protected var _stageWidth:int;
        protected var _stageHeight:int;
        protected var _completeCall:DelayedCall;
        protected var _thisTween:Tween;
        protected var _state:Boolean = true;
        private var _xPos:int;
        private var _yPos:int;

        public function active(state:Boolean):void{
            this.touchable = state;
            _state = state;
            ((_state) ? addListener() : removeListener());
            if (state)
            {
                this.x = (_stageWidth + _xPos);
                this.scaleX = 0.2;
                this.scaleY = 0.2;
            };
            var _local_4:int = ((state) ? _xPos : -(_stageWidth));
            var _local_3:String = ((state) ? "easeOut" : "linear");
            var _local_2:Number = ((state) ? 1 : 0.2);
            Starling.juggler.remove(_thisTween);
            _thisTween.reset(this, 0.3, _local_3);
            _thisTween.scaleTo(_local_2);
            _thisTween.moveTo(_local_4, _yPos);
            Starling.juggler.add(_thisTween);
            _completeCall.reset(complete, 0.3);
            Starling.juggler.add(_completeCall);
        }
        protected function addListener():void{
            this.addEventListener("triggered", this.btnClicked);
        }
        protected function removeListener():void{
            this.removeEventListener("triggered", this.btnClicked);
        }
        protected function complete():void{
            viewsController.popupComplete(_id, _state);
        }
        override protected function onAddedToStage():void{
            this.drawScreen();
        }
        protected function drawScreen():void{
            _stageWidth = App.STAGE_WIDTH;
            _stageHeight = App.STAGE_HEIGHT;
            _xPos = App.STAGE_XPOS;
            _yPos = App.STAGE_YPOS;
            _thisTween = new Tween(this, 0.3);
            _completeCall = new DelayedCall(complete, 0.3);
            this.width = _stageWidth;
            this.height = _stageHeight;
            this.pivotX = _xPos;
            this.pivotY = _yPos;
            this.y = _yPos;
            _container = new Sprite();
            this.addChild(_container);
            _bg = new Quad((_stageWidth - (30 * 2)), (_stageHeight - (30 * 2)), 0xFFFFFF);
            _bg.x = 30;
            _bg.y = 30;
            _container.addChild(_bg);
            _closeBtnText = new TextField(74, 74, "X", "Museo", 48, 3357258);
            _closeBtnText.hAlign = "center";
            _closeBtnText.vAlign = "bottom";
            _closeBtn = new BasicButton();
            _closeBtn.content.addChild(_closeBtnText);
            _closeBtn.x = ((_stageWidth - 30) - _closeBtnText.width);
            _closeBtn.y = 30;
            this.addChild(_closeBtn);
        }
        protected function btnClicked(e:Event):void{
            sound.playSFX("sfx_menu");
            if (e.target == _closeBtn)
            {
                viewsController.closePopup();
            };
        }

    }
}//package views

