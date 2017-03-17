// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//views.TitleView

package views{
	import controllers.ViewsController;
	import models.AppModel;
    import org.flashapi.hummingbird.view.AbstractStarlingSpriteView;
    import models.IAppModel;
	import service.GameService;
    import service.IGameService;
    import service.ISoundService;
    import controllers.IViewsController;
	import service.SoundService;
    import starling.display.Button;
    import starling.animation.Tween;
    import starling.text.TextField;
    import starling.display.Sprite;
    import starling.display.Image;
    import starling.display.MovieClip;
    import starling.animation.DelayedCall;
    import starling.utils.AssetManager;
    import starling.core.Starling;
    import constants.App;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;

    public class TitleView extends AbstractStarlingSpriteView implements IGameView {

        //[Model(alias="")]
        public var appModel:IAppModel = AppModel.GetInstance();
        //[Model(alias="")]
        public var gameService:IGameService = GameService.GetInstance();
        //[Model(alias="")]
        public var sound:ISoundService = SoundService.GetInstance();
        //[Controller(alias="")]
        public var viewsController:IViewsController = ViewsController.GetInstance();
        private var _state:Boolean = true;
        private var _xPos:int;
        private var _yPos:int;
        private var _stageWidth:int;
        private var _stageHeight:int;
        private var _infoBtn:Button;
        private var _infoBtnTween:Tween;
        private var _gamecenterBtn:Button;
        private var _gamecenterBtnTween:Tween;
        private var _settingsBtn:Button;
        private var _settingsBtnTween:Tween;
        private var _topLabel:TextField;
        private var _topValue:TextField;
        private var _startLabel:TextField;
        private var _versionLabel:TextField;
        private var _playerContainer:Sprite;
        private var _playerTween:Tween;
        private var _playerState:Boolean = true;
        private var _body:Image;
        private var _face:MovieClip;
        private var _faceDelayedCall:DelayedCall;
        private var _completeCall:DelayedCall;
        private var _leftArm:MovieClip;
        private var _rightArm:MovieClip;
        private var _bgRings:Image;
        private var _bgRingsTween:Tween;
        private var _assets:AssetManager;

        private function complete():void{
            Starling.juggler.remove(_completeCall);
            viewsController.viewComplete(0, _state);
            if (_state)
            {
                playerTween(1, 20, 1, 0, 0);
            };
        }
        override protected function onDependencyComplete():void{
            _assets = appModel.getAssets();
        }
        override protected function onAddedToStage():void{
            this.drawScreen();
        }
        private function playerTween(time:Number, yPos:int, scale:Number, delay:Number=0, repeat:int=1):void{
            Starling.juggler.remove(_playerTween);
            var _local_6:String = (((repeat)==0) ? "linear" : "easeOut");
            _playerTween.reset(_playerContainer, time, _local_6);
            _playerTween.moveTo(_xPos, yPos);
            _playerTween.scaleTo(scale);
            _playerTween.delay = delay;
            _playerTween.repeatCount = repeat;
            _playerTween.reverse = (repeat == 0);
            Starling.juggler.add(_playerTween);
        }
        public function active(state:Boolean):void{
            var _local_4:int;
            var _local_2:Number;
            var _local_3:Number;
            var _local_5:Number;
            _state = state;
            this.touchable = state;
            if (_state)
            {
                this.addEventListener("triggered", this.btnClicked);
                this.stage.addEventListener("touch", onTouch);
            }
            else
            {
                this.removeEventListener("triggered", this.btnClicked);
                this.stage.removeEventListener("touch", onTouch);
            };
            if (_state)
            {
                if (_topValue != null)
                {
                    _topValue.text = String(gameService.getHighscore());
                    _topValue.redraw();
                };
            };
            ((state) ? startFace() : stopFace());
            _local_5 = ((state) ? 0.3 : 0);
            _local_4 = ((state) ? 0 : _stageHeight);
            _local_2 = ((state) ? 1 : 0.5);
            playerTween(0.5, _local_4, _local_2, _local_5, 1);
            _local_3 = ((state) ? 1 : 0);
            _local_2 = ((state) ? 1 : 0.5);
            Starling.juggler.remove(_infoBtnTween);
            _infoBtnTween.reset(_infoBtn, 0.3, "easeOut");
            _infoBtnTween.delay = 0.1;
            _infoBtnTween.scaleTo(_local_2);
            _infoBtnTween.fadeTo(_local_3);
            Starling.juggler.add(_infoBtnTween);
            Starling.juggler.remove(_gamecenterBtnTween);
            _gamecenterBtnTween.reset(_gamecenterBtn, 0.3, "easeOut");
            _gamecenterBtnTween.delay = 0.15;
            _gamecenterBtnTween.scaleTo(_local_2);
            _gamecenterBtnTween.fadeTo(_local_3);
            Starling.juggler.add(_gamecenterBtnTween);
            Starling.juggler.remove(_settingsBtnTween);
            _settingsBtnTween.reset(_settingsBtn, 0.3, "easeOut");
            _settingsBtnTween.delay = 0.2;
            _settingsBtnTween.scaleTo(_local_2);
            _settingsBtnTween.fadeTo(_local_3);
            Starling.juggler.add(_settingsBtnTween);
            Starling.juggler.remove(_bgRingsTween);
            _local_5 = ((state) ? 0 : 0.3);
            _local_4 = ((state) ? 60 : _yPos);
            _bgRingsTween.reset(_bgRings, 0.5, "easeOut");
            _bgRingsTween.moveTo(_xPos, _local_4);
            _bgRingsTween.delay = _local_5;
            Starling.juggler.add(_bgRingsTween);
            _versionLabel.visible = state;
            if (state)
            {
                Starling.juggler.add(_leftArm);
                Starling.juggler.add(_rightArm);
            }
            else
            {
                Starling.juggler.remove(_leftArm);
                Starling.juggler.remove(_rightArm);
            };
            _completeCall.reset(complete, 0.8);
            Starling.juggler.add(_completeCall);
        }
        private function drawScreen():void{
            _stageWidth = App.STAGE_WIDTH;
            _stageHeight = App.STAGE_HEIGHT;
            _xPos = App.STAGE_XPOS;
            _yPos = App.STAGE_YPOS;
            _playerContainer = new Sprite();
            _playerContainer.pivotX = (_stageWidth * 0.5);
            _playerContainer.x = _xPos;
            _playerContainer.y = _stageHeight;
            this.addChild(_playerContainer);
            _bgRings = new Image(_assets.getTexture("title_bg_rings"));
            _bgRings.pivotX = (_bgRings.width * 0.5);
            _bgRings.pivotY = (_bgRings.height * 0.5);
            _bgRings.x = _xPos;
            _bgRings.y = -(_bgRings.height);
            _bgRings.touchable = false;
            this.addChild(_bgRings);
            _leftArm = new MovieClip(_assets.getTextures("title_arm_"), 10);
            _leftArm.pivotX = _leftArm.width;
            _leftArm.pivotY = _leftArm.height;
            _leftArm.x = (_xPos - 170);
            _leftArm.y = (_stageHeight - 110);
            _playerContainer.addChild(_leftArm);
            Starling.juggler.add(_leftArm);
            _rightArm = new MovieClip(_assets.getTextures("title_arm_"), 10);
            _rightArm.pivotX = _rightArm.width;
            _rightArm.pivotY = _rightArm.height;
            _rightArm.x = (_xPos + 170);
            _rightArm.y = (_stageHeight - 110);
            _rightArm.scaleX = -1;
            _playerContainer.addChild(_rightArm);
            Starling.juggler.add(_rightArm);
            _body = new Image(_assets.getTexture("title_bg_body"));
            _body.pivotX = (_body.width * 0.5);
            _body.x = _xPos;
            _body.y = ((_stageHeight - _body.height) + 150);
            _playerContainer.addChild(_body);
            _face = new MovieClip(_assets.getTextures("title_face_"), 2);
            _face.pivotX = (_face.width * 0.5);
            _face.pivotY = (_face.height * 0.5);
            _face.loop = false;
            _face.stop();
            _face.x = _xPos;
            _face.y = (_stageHeight - 380);
            _playerContainer.addChild(_face);
            Starling.juggler.add(_face);
            _topLabel = new TextField(_stageWidth, 36, "BEST SCORE", "Museo", 24, 0xFFFFFF);
            _topLabel.hAlign = "center";
            _topLabel.vAlign = "bottom";
            _topLabel.border = false;
            _topLabel.y = 12;
            _topLabel.touchable = false;
            this.addChild(_topLabel);
            _topValue = new TextField(_stageWidth, 84, String(gameService.getHighscore()), "Museo", 72, 0xFFFFFF);
            _topValue.hAlign = "center";
            _topValue.vAlign = "bottom";
            _topValue.border = false;
            _topValue.y = 42;
            _topValue.touchable = false;
            this.addChild(_topValue);
            _startLabel = new TextField(_stageWidth, 84, "START", "Museo", 72, 0xFFFFFF);
            _startLabel.hAlign = "center";
            _startLabel.vAlign = "bottom";
            _startLabel.border = false;
            _startLabel.y = (_stageHeight - 150);
            _playerContainer.addChild(_startLabel);
            _versionLabel = new TextField(100, 36, "v 1.0", "Museo", 24, 0xFFFFFF);
            _versionLabel.hAlign = "center";
            _versionLabel.vAlign = "bottom";
            _versionLabel.border = false;
            _versionLabel.x = 10;
            _versionLabel.y = (_stageHeight - 62);
            _versionLabel.touchable = false;
            this.addChild(_versionLabel);
            _infoBtn = new Button(_assets.getTexture("btn_info_up"));
            _infoBtn.downState = _assets.getTexture("btn_info_down");
            _infoBtn.pivotX = (_infoBtn.width * 0.5);
            _infoBtn.pivotY = (_infoBtn.height * 0.5);
            _infoBtn.x = (_xPos - 130);
            _infoBtn.y = 195;
            _infoBtn.scaleX = 0.5;
            _infoBtn.scaleY = 0.5;
            _infoBtn.alpha = 0;
            this.addChild(_infoBtn);
            _gamecenterBtn = new Button(_assets.getTexture("btn_leaderboard_up_android"));
            _gamecenterBtn.downState = _assets.getTexture("btn_leaderboard_down_android");
            _gamecenterBtn.pivotX = (_gamecenterBtn.width * 0.5);
            _gamecenterBtn.pivotY = (_gamecenterBtn.height * 0.5);
            _gamecenterBtn.x = _xPos;
            _gamecenterBtn.y = 250;
            _gamecenterBtn.scaleX = 0.5;
            _gamecenterBtn.scaleY = 0.5;
            _gamecenterBtn.alpha = 0;
            _gamecenterBtn.enabled = gameService.supported();
            this.addChild(_gamecenterBtn);
            _settingsBtn = new Button(_assets.getTexture("btn_settings_up"));
            _settingsBtn.downState = _assets.getTexture("btn_settings_down");
            _settingsBtn.pivotX = (_settingsBtn.width * 0.5);
            _settingsBtn.pivotY = (_settingsBtn.height * 0.5);
            _settingsBtn.x = (_xPos + 130);
            _settingsBtn.y = 195;
            _settingsBtn.scaleX = 0.5;
            _settingsBtn.scaleY = 0.5;
            _settingsBtn.alpha = 0;
            this.addChild(_settingsBtn);
            _playerTween = new Tween(_playerContainer, 0.3);
            _bgRingsTween = new Tween(_bgRings, 0.3);
            _faceDelayedCall = new DelayedCall(faceAni, 3);
            _completeCall = new DelayedCall(complete, 0.8);
            _infoBtnTween = new Tween(_infoBtn, 0.3);
            _gamecenterBtnTween = new Tween(_gamecenterBtn, 0.3);
            _settingsBtnTween = new Tween(_settingsBtn, 0.3);
        }
        private function startFace():void{
            if (!_face.hasEventListener("complete"))
            {
                _face.addEventListener("complete", faceAniComplete);
            };
            _faceDelayedCall.reset(faceAni, 3);
            Starling.juggler.add(_faceDelayedCall);
        }
        private function stopFace():void{
            _face.removeEventListener("complete", faceAniComplete);
            _face.stop();
            Starling.juggler.remove(_faceDelayedCall);
        }
        private function faceAni():void{
            _face.stop();
            _face.play();
        }
        private function faceAniComplete():void{
            _face.removeEventListener("complete", faceAniComplete);
            stopFace();
            startFace();
        }
        private function btnClicked(e:Event):void{
            sound.playSFX("sfx_menu");
            switch (e.target)
            {
                case _infoBtn:
                    viewsController.setPopup(0);
                    return;
                case _settingsBtn:
                    viewsController.setPopup(1);
                    return;
                case _gamecenterBtn:
                    gameService.clicked();
                    return;
                default:
                    return;
            };
        }
        private function onTouch(event:TouchEvent):void{
            var _local_2:Touch = event.getTouch(_playerContainer, "ended");
            if (_local_2)
            {
                sound.playSFX("sfx_menu");
                viewsController.setView(1);
            };
        }

    }
}//package views

