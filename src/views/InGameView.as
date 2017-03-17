// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//views.InGameView

package views{
	import controllers.AppController;
	import controllers.ViewsController;
	import models.AppModel;
    import org.flashapi.hummingbird.view.AbstractStarlingSpriteView;
    import models.IAppModel;
	import service.GameService;
    import service.ISoundService;
    import service.IGameService;
    import controllers.IAppController;
    import controllers.IViewsController;
    import controllers.ISocialController;
	import service.SoundService;
    import ui.display.Ring;
    import ui.display.Player;
    import ui.display.Sun;
    import starling.text.TextField;
    import starling.animation.Tween;
    import ui.display.Notice;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.display.Quad;
    import starling.display.QuadBatch;
    import starling.display.Button;
    import starling.animation.DelayedCall;
    import utils.Dictionary;
    import starling.utils.AssetManager;
    import starling.core.Starling;
    import events.ModelEvent;
    import constants.App;
    import org.flashapi.hummingbird.Hummingbird;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.Event;

    public class InGameView extends AbstractStarlingSpriteView implements IGameView {

        //[Model(alias="")]
        public var appModel:IAppModel = AppModel.GetInstance();
        //[Model(alias="")]
        public var sound:ISoundService = SoundService.GetInstance();
        //[Model(alias="")]
        public var gameService:IGameService =GameService.GetInstance();
        //[Controller(alias="")]
        public var appController:IAppController = AppController.GetInstance();
        //[Controller(alias="")]
        public var viewsController:IViewsController = ViewsController.GetInstance();
        //[Controller(alias="")]
        //public var socialController:ISocialController = new SocialController();
        private var _state:Boolean = true;
        private var _xPos:int;
        private var _yPos:int;
        private var _stageWidth:int;
        private var _stageHeight:int;
        private var _ring:Ring;
        private var _player:Player;
        private var _sun:Sun;
        private var _topLabel:TextField;
        private var _topText:String = "GAME OVER";
        private var _topValue:TextField;
        private var _scoreValue:TextField;
        private var _scoreValueTween:Tween;
        private var _centerLabel:TextField;
        private var _centerValue:TextField;
        private var _centerTween:Tween;
        private var _centerObject:Object;
        private var _highscore:Notice;
        private var _highscoreTween:Tween;
        private var _achievement:Notice;
        private var _achievementTween:Tween;
        private var _bottomLabel:TextField;
        private var _bottomValue:TextField;
        private var _earth:Image;
        private var _earthTween:Tween;
        private var _bgContainer:Sprite;
        private var _bgContainerTween:Tween;
        private var _bgRings:Image;
        private var _bgRingsTween:Tween;
        private var _bgRingsTitle:Image;
        private var _bgDeath:Quad;
        private var _bgBatch:QuadBatch;
        private var _bg:Sprite;
        private var _bgFaded:Quad;
        private var _retryBtn:Button;
        private var _closeBtn:Button;
        private var _facebookBtn:Button;
        private var _twitterBtn:Button;
        private var _timerDeath:DelayedCall;
        private var _radien:Dictionary;
        private var _gameOverContainer:Sprite;
        private var _gameOverContainerTween:Tween;
        private var _gamecenterBtn:Button;
        private var _achievementsContainer:Sprite;
        private var _tap:Image;
        private var _tapTween:Tween;
        private var _completeCall:DelayedCall;
        private var _cat:Image;
        private var _girlfriend:Image;
        private var _doctor:Image;
        private var _assets:AssetManager;
        private var _currentCount:int = 0;

        public function InGameView(){
            this.touchable = false;
            _radien = new Dictionary();
            _radien.setValue(2, 114);
            _radien.setValue(1, 192);
            _radien.setValue(0, 264);
        }
        override protected function onDependencyComplete():void{
            _assets = appModel.getAssets();
        }
        override protected function onAddedToStage():void{
            this.drawScreen();
        }
        private function touchListenerState(state:Boolean):void{
            if (state)
            {
                this.stage.addEventListener("touch", onTouch);
            }
            else
            {
                this.stage.removeEventListener("touch", onTouch);
            };
        }
        public function active(state:Boolean):void{
            _state = state;
            _sun.active(state);
            _player.active(state);
            ringState(state);
            earthState(state);
            var _local_3:uint = ((state) ? (_yPos + 300) : _stageHeight);
            var _local_2:int = ((state) ? 1 : 0);
            Starling.juggler.remove(_bgContainerTween);
            _bgContainerTween.reset(_bgContainer, 0.3);
            _bgContainerTween.moveTo(0, _local_3);
            Starling.juggler.add(_bgContainerTween);
            _bgRingsTitle.visible = state;
            bgRingsTween(1, _local_2, bgRingsComplete);
            gameOverState(false);
            gameBtnListener(false);
            if (state)
            {
                setTopValue("0");
                _topLabel.visible = true;
            };
            if (!state)
            {
                appModel.removeEventListener("stateChange", stateChange);
                touchListenerState(false);
            };
            _completeCall.reset(complete, 0.3);
            Starling.juggler.add(_completeCall);
        }
        private function complete():void{
            Starling.juggler.remove(_completeCall);
            viewsController.viewComplete(1, _state);
            if (_state)
            {
                appController.setState(1);
                appModel.addEventListener("stateChange", stateChange);
                touchListenerState(true);
            };
        }
        private function ringState(state:*):void{
            var _local_3:int;
            var _local_4:int;
            var _local_2 = null;
            if (appModel.getRings().length == 3)
            {
                _local_3 = 3;
                _local_4 = 0;
                while (_local_4 < _local_3)
                {
                    _local_2 = appModel.getRingByID(_local_4);
                    _local_2.active(state);
                    _local_4++;
                };
            };
        }
        private function bgRingsTween(time:Number, fade:Number, call:Function=null):void{
            Starling.juggler.remove(_bgRingsTween);
            _bgRingsTween.reset(_bgRings, time);
            _bgRingsTween.fadeTo(fade);
            if (call != null)
            {
                _bgRingsTween.onComplete = call;
            };
            Starling.juggler.add(_bgRingsTween);
        }
        private function bgRingsComplete():void{
            if (_state)
            {
                _bgRingsTitle.visible = false;
            };
        }
        private function stateChange(e:ModelEvent):void{
            _tap.visible = false;
            _bgDeath.visible = false;
			trace("appModel.getState():"+appModel.getState())
            switch (appModel.getState())
            {
                case 1:
                    _tap.visible = true;
                    _topLabel.visible = true;
                    bgRingsTween(0.2, 1);
                    gameBtnListener(false);
                    gameOverState(false);
                    setTopValue(gameService.getScore().toString());
                    return;
                case 3:
                    _topLabel.visible = false;
                    setTopValue("GAME OVER");
                    _bgDeath.visible = true;
                    Starling.juggler.add(_timerDeath);
                    return;
                case 8:
                    _topLabel.visible = false;
                    setTopValue("TIME UP");
                    _bgDeath.visible = true;
                    Starling.juggler.add(_timerDeath);
                    bgRingsTween(0.3, 0);
                    return;
                case 4:
                    scored();
                    return;
                case 9:
                    gameOverState(true);
                    return;
                case 10:
                    gameBtnListener(true);
                default:
            };
        }
        private function gameOverEnd():void{
            _timerDeath.reset(gameOverEnd, 0.1);
            _bgDeath.visible = false;
        }
        public function scored():void{
            _scoreValue.visible = true;
            _scoreValue.y = (_yPos - 84);
            _scoreValue.scaleX = 2;
            _scoreValue.scaleY = 2;
            _scoreValue.text = gameService.getScore().toString();
            _scoreValue.redraw();
            Starling.juggler.removeTweens(_scoreValue);
            _scoreValueTween.reset(_scoreValue, 0.6, "easeOut");
            _scoreValueTween.moveTo(_xPos, 42);
            _scoreValueTween.scaleTo(1);
            _scoreValueTween.onComplete = scoreReady;
            Starling.juggler.add(_scoreValueTween);
        }
        private function scoreReady():void{
            _scoreValue.visible = false;
            setTopValue(gameService.getScore().toString());
        }
        private function setTopValue(val:String):void{
            _topValue.text = val;
            _topValue.redraw();
        }
        private function centerScore():void{
            var _local_1:Number;
            var _local_2:int = gameService.getScore();
            if (_local_2 <= 1)
            {
                _centerValue.text = _local_2.toString();
                _centerValue.redraw();
                checkForRewards();
            }
            else
            {
                _currentCount = 0;
                _local_1 = (0.7 / _local_2);
                _centerObject.score = 0;
                Starling.juggler.removeTweens(_centerObject);
                _centerTween.reset(_centerObject, (_local_2 * _local_1));
                _centerTween.animate("score", _local_2);
                _centerTween.onUpdate = centerScoreUpdate;
                _centerTween.onComplete = checkForRewards;
                Starling.juggler.add(_centerTween);
            };
        }
        private function centerScoreUpdate():void{
            var _local_1:int = Math.round(_centerObject.score);
            if (_currentCount != _local_1)
            {
                sound.playSFX("sfx_counter");
            };
            _currentCount = _local_1;
            _centerValue.text = String(_local_1);
            _centerValue.redraw();
        }
        private function checkForRewards():void{
            var _local_1:Number;
            if (((gameService.newHighscore()) && ((gameService.getHighscore() > 0))))
            {
                _local_1 = 0;
                if (showAchievements())
                {
                    showNewAchievement();
                    _local_1 = 1.5;
                };
                sound.playSFX("sfx_highscore");
                showNewHighscore(_local_1);
            };
        }
        private function showNewAchievement():void{
            _achievement.visible = true;
            _achievement.alpha = 0;
            _achievement.scaleX = 2;
            _achievement.scaleY = 2;
            Starling.juggler.removeTweens(_achievement);
            _achievementTween.reset(_achievement, 0.3);
            _achievementTween.fadeTo(1);
            _achievementTween.scaleTo(1);
            Starling.juggler.add(_achievementTween);
        }
        private function hideAchievement():void{
            if (_achievement.visible)
            {
                Starling.juggler.removeTweens(_achievement);
                _achievementTween.reset(_achievement, 0.3);
                _achievementTween.fadeTo(0);
                _achievementTween.scaleTo(0);
                Starling.juggler.add(_achievementTween);
            };
        }
        private function showNewHighscore(delay:Number=0):void{
            _highscore.visible = true;
            _highscore.alpha = 0;
            _highscore.scaleX = 2;
            _highscore.scaleY = 2;
            Starling.juggler.removeTweens(_highscore);
            _highscoreTween.reset(_highscore, 0.3);
            _highscoreTween.onStart = hideAchievement;
            _highscoreTween.fadeTo(1);
            _highscoreTween.scaleTo(1);
            _highscoreTween.delay = delay;
            Starling.juggler.add(_highscoreTween);
        }
        public function gameOverState(state:Boolean):void{
            if (state)
            {
                _highscore.visible = false;
                _achievement.visible = false;
                centerScore();
            }
            else
            {
                Starling.juggler.removeTweens(_centerObject);
            };
            _bottomValue.text = gameService.getHighscore().toString();
            _bottomValue.redraw();
            var _local_3:int = ((state) ? 1 : 0);
            var _local_2:Number = ((state) ? 0.3 : 0.2);
            _gameOverContainer.touchable = state;
            if (state)
            {
                _gameOverContainer.visible = true;
                _gameOverContainer.alpha = 0;
            };
            Starling.juggler.removeTweens(_gameOverContainer);
            _gameOverContainerTween.reset(_gameOverContainer, _local_2);
            _gameOverContainerTween.fadeTo(_local_3);
            Starling.juggler.add(_gameOverContainerTween);
        }
        private function gameBtnListener(state:Boolean):void{
            this.touchable = state;
            if (state)
            {
                if (!this.hasEventListener("triggered"))
                {
                    this.addEventListener("triggered", this.btnClicked);
                };
            }
            else
            {
                if (this.hasEventListener("triggered"))
                {
                    this.removeEventListener("triggered", this.btnClicked);
                };
            };
        }
        private function showAchievements():Boolean{
            var _local_3 = null;
            var _local_4 = null;
            var _local_10 = null;
            var _local_6 = null;
            var _local_7 = null;
            var _local_1 = null;
            var _local_5 = null;
            var _local_11 = null;
            var _local_9 = null;
            var _local_8:Boolean;
            var _local_2:Dictionary = gameService.getAchievements();
            _bgContainer.unflatten();
            _local_4 = _local_2.getValue(0);
			_local_4.update = true;
            if (_local_4.update)
            {
                _local_3 = new Image(_assets.getTexture("planet_grey"));
                _local_3.name = "planet";
                _local_3.width = _stageWidth;
                _local_3.y = 65;
                _bgContainer.addChild(_local_3);
                _local_4.update = false;
                _local_8 = true;
            };
            _local_4 = _local_2.getValue(5);
            if (_local_4.update)
            {
                _local_10 = new Image(_assets.getTexture("planet_air"));
                _local_10.y = 35;
                _local_10.width = _stageWidth;
                _bgContainer.addChildAt(_local_10, 0);
                _local_4.update = false;
                _local_8 = true;
            };
            _local_4 = _local_2.getValue(10);
            if (_local_4.update)
            {
                _local_6 = new Image(_assets.getTexture("planet_cloud_1"));
                _local_7 = new Image(_assets.getTexture("planet_cloud_2"));
                _local_6.pivotX = (_local_6.width * 0.5);
                _local_6.pivotY = (_local_6.height * 0.5);
                _local_6.x = 60;
                _local_6.y = 35;
                _bgBatch.addImage(_local_6);
                _local_6.x = (_stageWidth - 60);
                _local_6.y = 35;
                _bgBatch.addImage(_local_6);
                _local_7.pivotX = (_local_7.width * 0.5);
                _local_7.pivotY = (_local_7.height * 0.5);
                _local_7.x = 170;
                _local_7.y = 38;
                _bgBatch.addImage(_local_7);
                _local_7.x = (_stageWidth - 170);
                _local_7.y = 38;
                _bgBatch.addImage(_local_7);
                _local_4.update = false;
                _local_8 = true;
            };
            _local_4 = _local_2.getValue(20);
            if (_local_4.update)
            {
                _local_1 = (_bgContainer.getChildByName("planet") as Image);
                if (_local_1 != null)
                {
                    _bgContainer.removeChild(_local_1);
                    _local_1.dispose();
                    _local_1 = null;
                };
                _local_3 = new Image(_assets.getTexture("planet_green"));
                _local_3.width = _stageWidth;
                _local_3.y = 65;
                _bgContainer.addChild(_local_3);
                _local_4.update = false;
                _local_8 = true;
            };
            _local_4 = _local_2.getValue(30);
            if (_local_4.update)
            {
                _bgContainer.addChild(_bgBatch);
                _local_5 = new Image(_assets.getTexture("planet_grass"));
                _local_5.pivotX = (_local_5.width * 0.5);
                _local_5.pivotY = _local_5.height;
                _local_5.x = 125;
                _local_5.y = 90;
                _bgBatch.addImage(_local_5);
                _local_5.x = 45;
                _local_5.y = 140;
                _bgBatch.addImage(_local_5);
                _local_5.x = 195;
                _local_5.y = 165;
                _bgBatch.addImage(_local_5);
                _local_5.x = 100;
                _local_5.y = 240;
                _bgBatch.addImage(_local_5);
                _local_5.x = 250;
                _local_5.y = 260;
                _bgBatch.addImage(_local_5);
                _local_5.x = (_stageWidth - 125);
                _local_5.y = 90;
                _bgBatch.addImage(_local_5);
                _local_5.x = (_stageWidth - 45);
                _local_5.y = 140;
                _bgBatch.addImage(_local_5);
                _local_5.x = (_stageWidth - 195);
                _local_5.y = 165;
                _bgBatch.addImage(_local_5);
                _local_5.x = (_stageWidth - 100);
                _local_5.y = 240;
                _bgBatch.addImage(_local_5);
                _local_5.x = (_stageWidth - 250);
                _local_5.y = 260;
                _bgBatch.addImage(_local_5);
                _local_4.update = false;
                _local_8 = true;
            };
            _local_4 = _local_2.getValue(40);
            if (_local_4.update)
            {
                _local_11 = new Image(_assets.getTexture("planet_flower"));
                _local_11.pivotX = (_local_11.width * 0.5);
                _local_11.pivotY = _local_11.height;
                _local_11.x = 170;
                _local_11.y = 110;
                _bgBatch.addImage(_local_11);
                _local_11.x = 35;
                _local_11.y = 165;
                _bgBatch.addImage(_local_11);
                _local_11.x = 130;
                _local_11.y = 0xFF;
                _bgBatch.addImage(_local_11);
                _local_11.x = (_stageWidth - 170);
                _local_11.y = 110;
                _bgBatch.addImage(_local_11);
                _local_11.x = (_stageWidth - 35);
                _local_11.y = 165;
                _bgBatch.addImage(_local_11);
                _local_11.x = (_stageWidth - 130);
                _local_11.y = 0xFF;
                _bgBatch.addImage(_local_11);
                _local_4.update = false;
                _local_8 = true;
            };
            _local_4 = _local_2.getValue(50);
            if (_local_4.update)
            {
                _local_9 = new Image(_assets.getTexture("planet_bush"));
                _local_9.pivotX = (_local_9.width * 0.5);
                _local_9.pivotY = _local_9.height;
                _local_9.x = 40;
                _local_9.y = 100;
                _bgBatch.addImage(_local_9);
                _local_9.x = 100;
                _local_9.y = 175;
                _bgBatch.addImage(_local_9);
                _local_9.x = 20;
                _local_9.y = 245;
                _bgBatch.addImage(_local_9);
                _local_9.x = (_stageWidth - 40);
                _local_9.y = 100;
                _bgBatch.addImage(_local_9);
                _local_9.x = (_stageWidth - 100);
                _local_9.y = 175;
                _bgBatch.addImage(_local_9);
                _local_9.x = (_stageWidth - 20);
                _local_9.y = 245;
                _bgBatch.addImage(_local_9);
                _local_4.update = false;
                _local_8 = true;
            };
            _local_4 = _local_2.getValue(75);
            if (_local_4.update)
            {
                _achievementsContainer.unflatten();
                _achievementsContainer.visible = true;
                _cat = new Image(_assets.getTexture("planet_cat"));
                _cat.pivotX = (_cat.width * 0.5);
                _cat.pivotY = (_cat.height * 0.5);
                _cat.x = 120;
                _cat.y = (_yPos + 300);
                _achievementsContainer.addChild(_cat);
                _achievementsContainer.flatten();
                _local_4.update = false;
                _local_8 = true;
            };
            _local_4 = _local_2.getValue(100);
            if (_local_4.update)
            {
                _achievementsContainer.unflatten();
                _achievementsContainer.visible = true;
                _girlfriend = new Image(_assets.getTexture("planet_girlfriend"));
                _girlfriend.pivotX = (_girlfriend.width * 0.5);
                _girlfriend.pivotY = (_girlfriend.height * 0.5);
                _girlfriend.x = 45;
                _girlfriend.y = (_yPos + 275);
                _achievementsContainer.addChild(_girlfriend);
                _achievementsContainer.flatten();
                _local_4.update = false;
                _local_8 = true;
            };
            _local_4 = _local_2.getValue(150);
            if (_local_4.update)
            {
                _achievementsContainer.unflatten();
                _achievementsContainer.visible = true;
                _doctor = new Image(_assets.getTexture("planet_doctor"));
                _doctor.pivotX = (_doctor.width * 0.5);
                _doctor.pivotY = (_doctor.height * 0.5);
                _doctor.x = (_xPos - 245);
                _doctor.y = (_yPos - 400);
                _achievementsContainer.addChild(_doctor);
                _achievementsContainer.flatten();
                _local_4.update = false;
                _local_8 = true;
            };
            _bgContainer.flatten();
            return (_local_8);
        }
        private function earthState(state:*):void{
            var _local_2:int = ((state) ? 1 : 0);
            Starling.juggler.removeTweens(_earthTween);
            _earthTween.reset(_earth, 0.3);
            _earthTween.fadeTo(_local_2);
            _earthTween.scaleTo(_local_2);
            Starling.juggler.add(_earthTween);
        }
        private function drawScreen():void{
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_1 = null;
            _centerObject = {};
            _centerObject.score = 0;
            _timerDeath = new DelayedCall(gameOverEnd, 0.1);
            _completeCall = new DelayedCall(complete, 0.8);
            _bgRingsTween = new Tween(_bgRings, 0.3);
            _scoreValueTween = new Tween(_scoreValue, 0.3);
            _gameOverContainerTween = new Tween(_gameOverContainer, 0.3);
            _centerTween = new Tween(_centerObject, 0.3);
            _highscoreTween = new Tween(_highscore, 0.3);
            _achievementTween = new Tween(_achievement, 0.3);
            _earthTween = new Tween(_earth, 0.3);
            _stageWidth = App.STAGE_WIDTH;
            _stageHeight = App.STAGE_HEIGHT;
            _xPos = App.STAGE_XPOS;
            _yPos = App.STAGE_YPOS;
            _gameOverContainer = new Sprite();
            _gameOverContainer.alpha = 0;
            _gameOverContainer.visible = false;
            _gameOverContainer.touchable = false;
            _bgFaded = new Quad(_stageWidth, _stageHeight, 3357258);
            _bgFaded.alpha = 0.7;
            _bgFaded.touchable = false;
            _gameOverContainer.addChild(_bgFaded);
            _bgRings = new Image(_assets.getTexture("game_bg_rings"));
            _bgRings.pivotX = (_bgRings.width * 0.5);
            _bgRings.pivotY = (_bgRings.height * 0.5);
            _bgRings.x = _xPos;
            _bgRings.y = _yPos;
            _bgRings.alpha = 0;
            _bgRings.touchable = false;
            this.addChild(_bgRings);
            _bgRingsTitle = new Image(_assets.getTexture("title_bg_rings"));
            _bgRingsTitle.pivotX = (_bgRingsTitle.width * 0.5);
            _bgRingsTitle.pivotY = (_bgRingsTitle.height * 0.5);
            _bgRingsTitle.x = _xPos;
            _bgRingsTitle.y = _yPos;
            _bgRingsTitle.touchable = false;
            this.addChild(_bgRingsTitle);
            _bgContainer = new Sprite();
            _bgContainer.y = _stageHeight;
            _bgContainer.touchable = false;
            this.addChild(_bgContainer);
            _bgBatch = new QuadBatch();
            _bgContainer.addChild(_bgBatch);
            _bgContainerTween = new Tween(_bgContainer, 0.3);
            _bgContainerTween.moveTo(_xPos, _stageHeight);
            _achievementsContainer = new Sprite();
            _achievementsContainer.visible = false;
            _achievementsContainer.touchable = false;
            this.addChild(_achievementsContainer);
            showAchievements();
            _earth = new Image(_assets.getTexture("earth"));
            _earth.pivotX = (_earth.width * 0.5);
            _earth.pivotY = (_earth.height * 0.5);
            _earth.x = (_stageWidth - 80);
            _earth.y = (_yPos + 284);
            _earth.scaleX = 0;
            _earth.scaleY = 0;
            _earth.alpha = 0;
            _earth.touchable = false;
            this.addChild(_earth);
            _topLabel = new TextField(_stageWidth, 36, "ROUND", "Museo", 24, 0xFFFFFF);
            _topLabel.hAlign = "center";
            _topLabel.vAlign = "bottom";
            _topLabel.border = false;
            _topLabel.y = 12;
            _topLabel.touchable = false;
            this.addChild(_topLabel);
            _centerLabel = new TextField(_stageWidth, 42, "SCORE", "Museo", 36, 0xFFFFFF);
            _centerLabel.hAlign = "center";
            _centerLabel.vAlign = "bottom";
            _centerLabel.border = false;
            _centerLabel.pivotY = (_centerLabel.height * 0.5);
            _centerLabel.y = (_yPos - 42);
            _centerLabel.touchable = false;
            _gameOverContainer.addChild(_centerLabel);
            _achievement = new Notice(300);
            _achievement.text = "NEW PLANET LIFE UNLOCKED!";
            _achievement.x = _xPos;
            _achievement.y = (_yPos - 65);
            _achievement.alpha = 0;
            _achievement.visible = false;
            _gameOverContainer.addChild(_achievement);
            _highscore = new Notice(200);
            _highscore.text = "NEW HIGHSCORE";
            _highscore.textColor = 0xFFFFFF;
            _highscore.bgColor = 15030333;
            _highscore.x = _xPos;
            _highscore.y = (_yPos - 65);
            _highscore.alpha = 0;
            _highscore.visible = false;
            _highscore.touchable = false;
            _gameOverContainer.addChild(_highscore);
            _centerValue = new TextField(_stageWidth, 100, "0", "Museo", 84, 0xFFFFFF);
            _centerValue.hAlign = "center";
            _centerValue.vAlign = "bottom";
            _centerValue.border = false;
            _centerValue.pivotY = (_centerValue.height * 0.5);
            _centerValue.y = (_yPos + 24);
            _highscore.touchable = false;
            _gameOverContainer.addChild(_centerValue);
            _bottomLabel = new TextField(120, 16, "HIGH-SCORE", "Museo", 16, 0xFFFFFF);
            _bottomLabel.hAlign = "center";
            _bottomLabel.vAlign = "center";
            _bottomLabel.border = false;
            _bottomLabel.pivotY = (_bottomLabel.height * 0.5);
            _bottomLabel.x = 60;
            _bottomLabel.y = (_stageHeight - 200);
            _bottomLabel.touchable = false;
            _gameOverContainer.addChild(_bottomLabel);
            _bottomValue = new TextField(120, 48, "0", "Museo", 48, 0xFFFFFF);
            _bottomValue.hAlign = "center";
            _bottomValue.vAlign = "center";
            _bottomValue.border = false;
            _bottomValue.pivotY = (_bottomValue.height * 0.5);
            _bottomValue.x = 60;
            _bottomValue.y = (_stageHeight - 165);
            _bottomValue.touchable = false;
            _gameOverContainer.addChild(_bottomValue);
            if (appModel.getRings().length == 0)
            {
                _local_2 = 3;
                _local_3 = _local_2;
                _local_4 = 0;
                while (_local_4 < _local_2)
                {
                    _local_1 = (Hummingbird.getFactory().createView(Ring) as Ring);
                    _local_1.id = _local_4;
                    _local_1.distanceId = _local_3;
                    _local_1.x = _xPos;
                    _local_1.y = _yPos;
                    _local_1.radius = _radien.getValue(_local_4);
                    _local_1.active(true);
                    this.addChild(_local_1);
                    appModel.addRing(_local_1);
                    _local_3 = (_local_3 - 1);
                    _local_4++;
                };
            };
            _tap = new Image(_assets.getTexture("tap"));
            _tap.pivotX = (_tap.width * 0.5);
            _tap.pivotY = 0;
            _tap.x = _xPos;
            _tap.y = (_yPos + 395);
            _tap.touchable = false;
            _tapTween = new Tween(_tap, 0.7);
            _tapTween.repeatCount = 0;
            _tapTween.reverse = true;
            _tapTween.moveTo(_xPos, (_yPos + 390));
            Starling.juggler.add(_tapTween);
            this.addChild(_tap);
            _player = (Hummingbird.getFactory().createView(Player) as Player);
            _player.x = _xPos;
            _player.y = _yPos;
            _player.orgY = _yPos;
            this.addChild(_player);
            appModel.addPlayer(_player);
            _sun = (Hummingbird.getFactory().createView(Sun) as Sun);
            _sun.x = _xPos;
            _sun.y = _yPos;
            this.addChild(_sun);
            _scoreValue = new TextField(_stageWidth, 84, "0", "Museo", 72, 0xFFFFFF);
            _scoreValue.hAlign = "center";
            _scoreValue.vAlign = "bottom";
            _scoreValue.pivotX = _xPos;
            _scoreValue.border = false;
            _scoreValue.x = _xPos;
            _scoreValue.y = (_yPos - 42);
            _scoreValue.visible = false;
            _scoreValue.touchable = false;
            this.addChild(_scoreValue);
            _bgDeath = new Quad(_stageWidth, _stageHeight, 0xFFFFFF);
            _bgDeath.visible = false;
            _bgDeath.touchable = false;
            this.addChild(_bgDeath);
            _retryBtn = new Button(_assets.getTexture("btn_retry"));
            _retryBtn.pivotX = (_retryBtn.width * 0.5);
            _retryBtn.pivotY = (_retryBtn.height * 0.5);
            _retryBtn.x = _xPos;
            _retryBtn.y = (_stageHeight - 100);
            _gameOverContainer.addChild(_retryBtn);
            _closeBtn = new Button(_assets.getTexture("btn_close"));
            _closeBtn.pivotX = (_closeBtn.width * 0.5);
            _closeBtn.pivotY = (_closeBtn.height * 0.5);
            _closeBtn.x = (_stageWidth - 100);
            _closeBtn.y = (_stageHeight - 100);
            _gameOverContainer.addChild(_closeBtn);
            _facebookBtn = new Button(_assets.getTexture("btn_facebook_up"));
            _facebookBtn.downState = _assets.getTexture("btn_facebook_down");
            _facebookBtn.pivotX = (_facebookBtn.width * 0.5);
            _facebookBtn.pivotY = (_facebookBtn.height * 0.5);
            _facebookBtn.x = 80;
            _facebookBtn.y = (_stageHeight - 100);
            _gameOverContainer.addChild(_facebookBtn);
            _twitterBtn = new Button(_assets.getTexture("btn_twitter_up"));
            _twitterBtn.downState = _assets.getTexture("btn_twitter_down");
            _twitterBtn.pivotX = (_twitterBtn.width * 0.5);
            _twitterBtn.pivotY = (_twitterBtn.height * 0.5);
            _twitterBtn.x = 160;
            _twitterBtn.y = (_stageHeight - 100);
            //_twitterBtn.enabled = socialController.hasTwitter();
            _gameOverContainer.addChild(_twitterBtn);
            _gamecenterBtn = new Button(_assets.getTexture("btn_leaderboard_up_android"));
            _gamecenterBtn.downState = _assets.getTexture("btn_leaderboard_down_android");
            _gamecenterBtn.pivotX = (_gamecenterBtn.width * 0.5);
            _gamecenterBtn.pivotY = (_gamecenterBtn.height * 0.5);
            _gamecenterBtn.x = _xPos;
            _gamecenterBtn.y = 160;
            _gamecenterBtn.scaleX = 0.8;
            _gamecenterBtn.scaleY = 0.8;
            _gamecenterBtn.enabled = gameService.supported();
            _gameOverContainer.addChild(_gamecenterBtn);
            this.addChild(_gameOverContainer);
            _topValue = new TextField(_stageWidth, 84, "0", "Museo", 72, 0xFFFFFF);
            _topValue.hAlign = "center";
            _topValue.vAlign = "bottom";
            _topValue.border = false;
            _topValue.y = 42;
            _topValue.touchable = false;
            this.addChild(_topValue);
        }
        private function onTouch(event:TouchEvent):void{
            var _local_2:Touch = event.getTouch(this.stage, "began");
            if (_local_2)
            {
                appController.tap();
            };
        }
        private function btnClicked(e:Event):void{
            sound.playSFX("sfx_menu");
            switch (e.target)
            {
                case _retryBtn:
                    appController.retry();
                    return;
                case _closeBtn:
                    gameService.setScore(0);
                    viewsController.setView(0);
                    return;
                case _facebookBtn:
                    //socialController.facebook();
                    return;
                case _twitterBtn:
                    //socialController.twitter();
                    return;
                case _gamecenterBtn:
                    gameService.clicked();
                    return;
                default:
                    return;
            };
        }

    }
}//package views

