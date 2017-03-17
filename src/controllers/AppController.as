// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//controllers.AppController

package controllers{
	import models.AppModel;
    import org.flashapi.hummingbird.controller.AbstractController;
    import models.IAppModel;
	import service.DatabaseService;
	import service.GameService;
    import service.IDatabaseService;
    import service.IAdService;
    import service.IGameService;
    import service.ISoundService;
    import service.IPurchaseService;
	import service.SoundService;
    import starling.animation.DelayedCall;
    import __AS3__.vec.Vector;
    import starling.textures.TextureAtlas;
    import models.dto.RingItem;
    import models.dto.ElementItem;
    import flash.data.SQLResult;
    import models.dto.LevelItem;
    import starling.core.Starling;
    //import com.milkmangames.nativeextensions.RateBox;
    import events.ModelEvent;
    import ui.display.Ring;
    import ui.display.Player;
    import utils.Dictionary;

    [Qualifier(alias="AppController")]
    public final class AppController extends AbstractController implements IAppController {

        public var model:IAppModel =	AppModel.GetInstance();
        [Model(alias="")]
        public var db:IDatabaseService = DatabaseService.GetInstance();
        //[Model(alias="")]
        //public var ad:IAdService =new AdService();
        //[Model(alias="")]
        public var gameService:IGameService =GameService.GetInstance();
        //[Model(alias="")]
        public var sound:ISoundService = SoundService.GetInstance();
        //[Model(alias="")]
        //public var purchase:IPurchaseService = new PurchaseService();
        private var _timer:DelayedCall;
        private var _listen:Boolean = true;
        private var _morpNames:Vector.<String>;
        private var _showOwnAdIndex:uint = 0;
        private var _adScore:uint = 0;
		
		private static var _instance:AppController
		public static function GetInstance():AppController {
			if (!_instance) _instance = new AppController();
			return _instance;
		}
		
		
        public function init():void{
            _timer = new DelayedCall(timeUp, 4);
            model.setIndex(0);
			
            var _local_1:TextureAtlas = model.getAssets().getTextureAtlas("spritesheet_small");
            _morpNames = _local_1.getNames("element_morph_");
            db.query("SELECT * FROM rings", RingItem, ringsReady);
            //ad.addEventListener("adDone", adDone);
            //ad.addEventListener("adError", adError);
            gameService.addEventListener("gameServiceReady", postHighScore);
        }
        private function ringsReady(result:SQLResult):void{
            var _local_4 = null;
            var _local_7 = null;
            var _local_2:int;
            var _local_3 = null;
            var _local_8:int;
            var _local_6:int;
            var _local_5:int = result.data.length;
            _local_8 = 0;
            while (_local_8 < _local_5)
            {
                _local_4 = result.data[_local_8];
                _local_4.orgSpeed = _local_4.speed;
                if (((!((_local_4.properties == null))) && ((_local_4.properties is String))))
                {
                    _local_7 = _local_4.properties.split(",");
                    _local_2 = _local_7.length;
                    _local_4.elements = new Vector.<ElementItem>();
                    _local_6 = 0;
                    while (_local_6 < _local_2)
                    {
                        _local_3 = new ElementItem();
                        _local_3.id = _local_6;
                        _local_3.type = _local_7[_local_6];
                        _local_3.orgType = _local_7[_local_6];
                        _local_4.elements.push(_local_3);
                        _local_6++;
                    };
                };
                model.addRingItem(_local_4);
                _local_8++;
            };
        }
        public function getLevel():void{
            var _local_1:int;
            var _local_2:int;
            _local_1 = gameService.getScore();
            _local_2 = 0;
            if ((((_local_1 >= 0)) && ((_local_1 <= 6))))
            {
                _local_2 = 0;
            }
            else
            {
                if ((((_local_1 >= 7)) && ((_local_1 <= 15))))
                {
                    _local_2 = 1;
                }
                else
                {
                    if (_local_1 >= 16)
                    {
                        _local_2 = 2;
                    };
                };
            };
            db.query((("SELECT * FROM levels WHERE difficulty = " + _local_2) + " ORDER BY RANDOM() LIMIT 1;"), LevelItem, this.levelReady);
            return;
            db.query("SELECT * FROM levels WHERE id = 1", LevelItem, this.levelReady);
        }
        private function levelReady(result:SQLResult):void{
            var _local_8 = null;
            var _local_11 = null;
            var _local_10 = null;
            var _local_6:int;
            var _local_5:Boolean;
            var _local_2:int;
            var _local_4 = null;
            var _local_7 = null;
            var _local_3 = null;
            var _local_9:Number;
            var _local_12:int;
            if (result.data.length > 0)
            {
                _local_8 = model.getLevel();
                _local_11 = result.data[0];
                if (((!((_local_8 == null))) && (!(false))))
                {
                    if (_local_8.id == _local_11.id)
                    {
                        this.getLevel();
                        return;
                    };
                };
                if (_local_11.ringIDs != null)
                {
                    _local_10 = _local_11.ringIDs.split(",");
                    _local_6 = _local_10.length;
                    _local_5 = true;
                    _local_3 = model.getRingItems();
                    if (_local_6 == 3)
                    {
                        _local_12 = 0;
                        while (_local_12 < _local_6)
                        {
                            _local_2 = _local_10[_local_12];
                            _local_4 = model.getRingByID(_local_12);
                            _local_7 = _local_3.getValue(_local_2);
                            if (_local_7 != null)
                            {
                                _local_9 = (180 / _local_7.elements.length);
                                _local_7.radius = _local_4.radius;
                                _local_4.rid = _local_7.id;
                                _local_7.speed = _local_7.orgSpeed;
                                _local_4.speed = _local_7.speed;
                                resetRingElements(_local_7.elements);
                                _local_4.elements = _local_7.elements;
                                _local_4.create();
                            }
                            else
                            {
                                _local_5 = false;
                                break;
                            };
                            _local_12++;
                        };
                        if (_local_5)
                        {
                            model.setLevel(_local_11);
                        }
                        else
                        {
                            this.getLevel();
                            return;
                        };
                    }
                    else
                    {
                        this.getLevel();
                        return;
                    };
                }
                else
                {
                    this.getLevel();
                    return;
                };
            };
        }
        private function resetRingElements(items:Vector.<ElementItem>):void{
            var _local_2 = null;
            var _local_4:int;
            var _local_3:uint = items.length;
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_2 = items[_local_4];
                _local_2.type = _local_2.orgType;
                _local_4++;
            };
        }
        public function tap():void{
            if (_listen)
            {
                update();
            };
        }
        public function retry():void{
            _listen = true;
            gameService.setScore(0);
            update();
        }
        public function update():void{
            var _local_3:int;
            var _local_2 = null;
            var _local_4 = null;
            var _local_1 = null;
            _listen = false;
            if (model.getState() == 10)
            {
                playerState(6);
                this.setState(1);
            }
            else
            {
                _local_3 = model.getIndex();
                if (model.getState() == 1)
                {
                    this.setState(5);
                };
                if (_local_3 < 3)
                {
                    _local_2 = model.getRingByID(_local_3);
                    _local_4 = model.getRingItemByID(_local_2.rid);
                    model.setCurrentRingItem(_local_4);
                };
                sound.playSFX("sfx_jump");
                playerState(3);
                _local_1 = new DelayedCall(check, 0.13);
                Starling.juggler.add(_local_1);
            };
        }
        public function check():void{
            var _local_14:Number;
            var _local_7 = null;
            var _local_12:Number;
            var _local_17:Number;
            var _local_3 = null;
            var _local_16 = null;
            var _local_15:int;
            var _local_4:Number;
            var _local_18:Number;
            var _local_1:Number;
            var _local_8:Number;
            var _local_13:Number;
            var _local_2 = null;
            var _local_5 = null;
            var _local_10:Number;
            var _local_11:Number;
            var _local_9:int;
            if ((((model.getState() == 3)) || ((model.getState() == 8))))
            {
                return;
            };
            var _local_6:uint = model.getIndex();
            if (_local_6 < 3)
            {
                _local_7 = model.getPlayer();
                _local_3 = model.getRingByID(_local_6);
                _local_16 = model.getRingItemByID(_local_3.rid);
                _local_12 = _local_7.degree;
                _local_14 = _local_3.degree;
                _local_17 = (((_local_14)>_local_12) ? ((360 - _local_14) + _local_12) : (_local_12 - _local_14));
                if (_local_16.elements != null)
                {
                    _local_15 = _local_16.elements.length;
                    _local_4 = (360 / _local_15);
                    _local_18 = 0;
                    _local_1 = _local_4;
                    _local_8 = (_local_4 / 100);
                    _local_13 = (_local_8 * 30);
                    _local_9 = 0;
                    while (_local_9 < _local_15)
                    {
                        _local_2 = _local_16.elements[_local_9];
                        if ((((_local_17 >= _local_18)) && ((_local_17 <= _local_1))))
                        {
                            if ((((((_local_2.type == 0)) || ((_local_2.type == 5)))) || ((_local_2.type == 8))))
                            {
                                _local_10 = (_local_17 - _local_18);
                                if (_local_13 > _local_10)
                                {
                                    if (_local_9 > 0)
                                    {
                                        _local_5 = _local_16.elements[(_local_9 - 1)];
                                    }
                                    else
                                    {
                                        _local_5 = _local_16.elements[(_local_15 - 1)];
                                    };
                                };
                                _local_11 = (_local_1 - _local_17);
                                if (_local_13 > _local_11)
                                {
                                    if (_local_9 < (_local_15 - 1))
                                    {
                                        _local_5 = _local_16.elements[(_local_9 + 1)];
                                    }
                                    else
                                    {
                                        _local_5 = _local_16.elements[0];
                                    };
                                };
                                if (_local_5 != null)
                                {
                                    if (!(((_local_2.type == 5)) || ((((_local_2.type == 8)) && ((_local_5.type == 0))))))
                                    {
                                        _local_2 = _local_5;
                                    };
                                };
                            };
                            model.setCurrentElementItem(_local_2);
                            break;
                        };
                        _local_18 = _local_1;
                        _local_1 = (_local_1 + _local_4);
                        _local_9++;
                    };
                    react();
                };
            }
            else
            {
                if (_local_6 == 3)
                {
                    this.setState(4);
                };
            };
        }
        public function setState(state:uint):void{
            var _local_2:Number;
            var _local_5:int;
            var _local_3:Boolean;
            var _local_4:uint = gameService.getScore();
            switch (state)
            {
                case 5:
                    startTimer();
                    break;
                case 1:
                    playerState(6);
                    this.getLevel();
                    this.resetTimer(4, timeUp);
                    _listen = true;
                    break;
                case 7:
                    _listen = true;
                    break;
                case 6:
                    _local_2 = ((_timer.totalTime - _timer.currentTime) + 2);
                    resetTimer(_local_2, timeUp);
                    startTimer();
                    _listen = true;
                    break;
                case 4:
                    sound.playSFX("sfx_sun");
                    _listen = false;
                    gameService.setScore(++_local_4);
                    model.setIndex(0);
                    resetTimer(0.7, delayScored);
                    startTimer();
                    break;
                case 8:
                    sound.playSFX("sfx_explosion");
                    _listen = false;
                    playerState(5);
                    resetTimer(1.2, delayGameOver);
                    startTimer();
                    break;
                case 3:
                    _listen = false;
                    playerState(4);
                    resetTimer(0.3, delayGameOver);
                    startTimer();
                    break;
                case 9:
                    if (_local_4 >= 1)
                    {
                        if (gameService.newHighscore())
                        {
                            gameService.postScore(_local_4);
                        };
                    };
                    //if (((RateBox.isSupported()) && ((gameService.getScore() > 12))))
                    //{
                        //RateBox.rateBox.incrementEventCount();
                    //};
                    //if (purchase.getAdState())
                    //{
                        //_local_5 = model.getAdIndex();
                        //if ((((_local_5 == (3 - 1))) && ((_adScore >= 4))))
                        //{
                            //_adScore = 0;
                            //_local_3 = false;
                            //if (_showOwnAdIndex == 4)
                            //{
                                //_showOwnAdIndex = 0;
                            //}
                            //else
                            //{
                                //_local_3 = ad.showPendingInterstitial();
                            //};
                            //if (!_local_3)
                            //{
                                //model.setPopupId(3);
                            //};
                            //model.setAdIndex(0);
                            //_showOwnAdIndex++;
                        //}
                        //else
                        //{
                            //if (_local_5 < (3 - 1))
                            //{
                                //model.setAdIndex(++_local_5);
                            //};
                            //if (_local_4 > _adScore)
                            //{
                                //_adScore = _local_4;
                            //};
                            //startDelayReset();
                        //};
                    //}
                    //else
                    //{
                        startDelayReset();
                    //};
                    break;
                case 10:
                    model.setIndex(0);
                default:
            };
            this.model.setState(state);
        }
        private function startDelayReset():void{
            resetTimer(0.3, delayReset);
            startTimer();
        }
        public function removeAd():void{
            model.setAdIndex(0);
            delayReset();
        }
        private function adDone(e:ModelEvent):void{
            removeAd();
        }
        private function adError(e:ModelEvent):void{
            model.setAdIndex(0);
        }
        private function startTimer():void{
            Starling.juggler.add(_timer);
        }
        private function resetTimer(time:Number, call:Function):void{
            Starling.juggler.remove(_timer);
            if (_timer.isComplete)
            {
                _timer = null;
                _timer = new DelayedCall(call, time);
            }
            else
            {
                _timer.reset(call, time);
            };
        }
        private function timeUp():void{
            this.setState(8);
        }
        private function delayScored():void{
            this.setState(1);
        }
        private function delayReset():void{
            this.setState(10);
        }
        private function delayGameOver():void{
            this.setState(9);
        }
        private function playerState(state:*):void{
            model.setPlayerState(state);
        }
        public function react():void{
            var _local_8:int;
            var _local_3 = null;
            var _local_7:int;
            var _local_5:ElementItem = model.getCurrentElementItem();
            var _local_2:uint = model.getIndex();
            var _local_1:Ring = model.getRingByID(_local_2);
            var _local_6:RingItem = model.getCurrentRingItem();
            var _local_4 = 0;
            switch (_local_5.type)
            {
                case 0:
                    model.setIndex(++_local_2);
                    playerState(2);
                    this.setState(7);
                    return;
                case 1:
                    sound.playSFX("sfx_smash");
                    _local_1.animate(_local_5.id);
                    _local_5.type = 0;
                    if (_local_2 == 0)
                    {
                        model.setIndex(0);
                        playerState(1);
                        this.setState(7);
                    }
                    else
                    {
                        model.setIndex(--_local_2);
                        playerState(2);
                        update();
                    };
                    return;
                case 2:
                    sound.playSFX("sfx_bounce");
                    _local_1.animate(_local_5.id);
                    if (_local_2 == 0)
                    {
                        model.setIndex(0);
                        playerState(1);
                        this.setState(7);
                    }
                    else
                    {
                        model.setIndex(--_local_2);
                        playerState(2);
                        update();
                    };
                    return;
                case 5:
                    sound.playSFX("sfx_star_pickup");
                    _local_5.type = 0;
                    _local_1.moveToCenter(_local_5.id);
                    model.setIndex(++_local_2);
                    playerState(2);
                    this.setState(6);
                    return;
                case 8:
                    sound.playSFX("sfx_changedirection");
                    _local_5.type = 0;
                    _local_1.remove(_local_5.id);
                    playerState(2);
                    this.setState(7);
                    model.setIndex(++_local_2);
                    this.reverseRingSpeeds();
                    return;
                case 11:
                    sound.playSFX("sfx_spikes");
                    this.setState(3);
                    return;
                case 12:
                    sound.playSFX("sfx_brick");
                    if (_local_2 == 0)
                    {
                        model.setIndex(0);
                        playerState(1);
                        this.setState(7);
                    }
                    else
                    {
                        model.setIndex(--_local_2);
                        playerState(2);
                        update();
                    };
                    return;
                case 9:
                    sound.playSFX("sfx_changedirection");
                    if (_local_6.speed > 0)
                    {
                        _local_6.speed = (_local_6.speed + 1);
                    }
                    else
                    {
                        if (_local_6.speed < 0)
                        {
                            _local_6.speed = (_local_6.speed - 1);
                        };
                    };
                    _local_1.speed = _local_6.speed;
                    _local_1.remove(_local_5.id);
                    _local_5.type = 0;
                    playerState(2);
                    this.setState(7);
                    model.setIndex(++_local_2);
                    return;
                case 10:
                    sound.playSFX("sfx_changedirection");
                    if (_local_6.speed > 0)
                    {
                        _local_4 = (_local_6.speed - 1);
                        if (_local_4 < 0.25)
                        {
                            _local_4 = 0.25;
                        };
                    }
                    else
                    {
                        if (_local_6.speed < 0)
                        {
                            _local_4 = (_local_6.speed + 1);
                            if (_local_4 > -0.25)
                            {
                                _local_4 = -0.25;
                            };
                        };
                    };
                    _local_6.speed = _local_4;
                    _local_1.speed = _local_6.speed;
                    _local_1.remove(_local_5.id);
                    _local_5.type = 0;
                    playerState(2);
                    this.setState(7);
                    model.setIndex(++_local_2);
                    return;
                case 13:
                    _local_8 = _local_1.getMorphIndex(_local_5.id);
                    _local_3 = /element_morph_/;
                    _local_7 = int(String(_morpNames[_local_8]).replace(_local_3, ""));
                    _local_5.type = _local_7;
                    _local_1.setNewItem(_local_5);
                    react();
                default:
            };
        }
        private function reverseRingSpeeds():void{
            var _local_1:int;
            var _local_2 = null;
            var _local_7 = null;
            var _local_9:int;
            var _local_5:Player = model.getPlayer();
            _local_5.speed = (_local_5.speed * -1);
            var _local_4:LevelItem = model.getLevel();
            var _local_8:Array = _local_4.ringIDs.split(",");
            var _local_3:Dictionary = model.getRingItems();
            var _local_6:uint = 3;
            _local_9 = 0;
            while (_local_9 < _local_6)
            {
                _local_1 = _local_8[_local_9];
                _local_7 = _local_3.getValue(_local_1);
                _local_2 = model.getRingByID(_local_9);
                _local_2.speed = (_local_2.speed * -1);
                _local_7.speed = _local_2.speed;
                _local_9++;
            };
        }
        private function postHighScore(e:ModelEvent):void{
            var _local_2:int = gameService.getHighscore();
            if (_local_2 >= 1)
            {
                gameService.checkForAchievements();
                gameService.postScore(_local_2);
            };
        }

    }
}//package controllers

