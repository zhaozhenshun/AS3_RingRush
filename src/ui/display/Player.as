// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//ui.display.Player

package ui.display{
	import models.AppModel;
    import org.flashapi.hummingbird.view.AbstractStarlingSpriteView;
    import views.IGameView;
    import models.IAppModel;
    import starling.display.Image;
    import starling.animation.Tween;
    import starling.display.Sprite;
    import starling.display.MovieClip;
    import starling.animation.DelayedCall;
    import starling.utils.AssetManager;
    import starling.core.Starling;
    import utils.Rotation;
    import models.dto.RingItem;
    import events.ModelEvent;

    public class Player extends AbstractStarlingSpriteView implements IGameView {

        [Model(alias="AppModel")]
        public var appModel:IAppModel = AppModel.GetInstance();
        private var _id:uint;
        private var _speed:Number = 0;
        private var _update:Number = 0;
        private var _radius:Number = 100;
        private var _image:Image;
        private var _move:Tween;
        private var _rotate:Tween;
        private var _trans:Number;
        private var _orgY:int;
        private var _container:Sprite;
        private var _death:Image;
        private var _onFloor:Image;
        private var _onFloorIdle:MovieClip;
        private var _onRing:Image;
        private var _jump:MovieClip;
        private var _reset:Boolean = false;
        private var _moveSpeed:Number;
        private var _idleDelayedCall:DelayedCall;
        private var _assets:AssetManager;

        public function Player(){
            this.touchable = false;
			onDependencyComplete();
        }
        override protected function onDependencyComplete():void{
            _assets = appModel.getAssets();
        }
        public function active(state:Boolean):void{
            if (state)
            {
                this.rotation = 0;
                _onRing.visible = false;
                _jump.visible = false;
                _death.visible = false;
                _onFloor.visible = true;
                _container.y = ((this.stage.stageHeight * 0.5) + 32);
                Starling.juggler.removeTweens(_move);
                _move.reset(_container, 0.3);
                _move.moveTo(0, 370);
                Starling.juggler.add(_move);
                appModel.addEventListener("playerStateChange", stateChange);
                Starling.current.stage.addEventListener("enterFrame", this.enterFrameHandler);
                appModel;
            }
            else
            {
                Starling.current.stage.removeEventListener("enterFrame", this.enterFrameHandler);
                appModel.removeEventListener("playerStateChange", stateChange);
            };
        }
        private function enterFrameHandler():void{
            this.rotation = (this.rotation + _update);
        }
        override protected function onAddedToStage():void{
            this.drawScreen();
        }
        private function drawScreen():void{
            _idleDelayedCall = new DelayedCall(idleAni, 5);
            _container = new Sprite();
            _container.y = ((this.stage.stageHeight * 0.5) + 32);
            _container.pivotX = 32;
            _container.pivotY = 42;
            this.addChild(_container);
            _move = new Tween(_container, 0.1);
            _onFloor = new Image(_assets.getTexture("player_on_floor"));
            _container.addChild(_onFloor);
            _onRing = new Image(_assets.getTexture("player_on_ring"));
            _onRing.visible = false;
            _container.addChild(_onRing);
            _death = new Image(_assets.getTexture("player_death"));
            _death.visible = false;
            _container.addChild(_death);
            _onFloorIdle = new MovieClip(_assets.getTextures("player_on_floor_idle_"), 10);
            _onFloorIdle.visible = false;
            _onFloorIdle.stop();
            _onFloorIdle.addEventListener("complete", idleAniComplete);
            Starling.juggler.add(_onFloorIdle);
            _container.addChild(_onFloorIdle);
            _jump = new MovieClip(_assets.getTextures("player_jump_"), 10);
            _jump.visible = false;
            _container.addChild(_jump);
        }
        public function set radius(val:int):void{
            _radius = val;
            if (_container != null)
            {
                Starling.juggler.removeTweens(_move);
                _move.reset(_container, _moveSpeed);
                _move.moveTo(0, _radius);
                Starling.juggler.add(_move);
            };
        }
        public function set orgY(val:int):void{
            _orgY = val;
        }
        public function get orgY():int{
            return (_orgY);
        }
        public function set speed(val:Number):void{
            _speed = val;
            _update = (val / 70);
        }
        public function get speed():Number{
            return (_speed);
        }
        public function set id(val:uint):void{
            _id = val;
        }
        public function get id():uint{
            return (_id);
        }
        public function get degree():Number{
            return (Rotation.degFromSprite(this));
        }
        public function stateChange(e:ModelEvent):void{
            var _local_2:RingItem = appModel.getCurrentRingItem();
            _onRing.visible = false;
            _onFloor.visible = false;
            _jump.visible = false;
            _death.visible = false;
            stopIdle();
            Starling.juggler.removeTweens(_jump);
            switch (appModel.getPlayerState())
            {
                case 3:
                    _moveSpeed = 0.15;
                    if (appModel.getIndex() == 3)
                    {
                        radius = 8;
                    }
                    else
                    {
                        radius = (_local_2.radius + 32);
                    };
                    _jump.visible = true;
                    Starling.juggler.add(_jump);
                    return;
                case 2:
                    _moveSpeed = 0.05;
                    speed = 0;
                    speed = _local_2.speed;
                    radius = (_local_2.radius + 8);
                    _onRing.visible = true;
                    return;
                case 1:
                    _moveSpeed = 0.15;
                    Starling.juggler.removeTweens(_rotate);
                    radius = 370;
                    speed = 0;
                    _rotate = new Tween(this, 0.15);
                    _rotate.animate("rotation", Rotation.radFromDeg(0));
                    Starling.current.juggler.add(_rotate);
                    _onFloor.visible = true;
                    startIdle();
                    return;
                case 4:
                    _moveSpeed = 0.15;
                    _death.visible = true;
                    speed = 0;
                    radius = (_local_2.radius + 32);
                    return;
                case 5:
                    _moveSpeed = 0.7;
                    _death.visible = true;
                    speed = 0;
                    radius = (_local_2.radius + 520);
                    return;
                case 6:
                    _moveSpeed = 0.15;
                    speed = 0;
                    this.rotation = 0;
                    radius = 370;
                    _onFloor.visible = true;
                    startIdle();
                default:
            };
        }
        private function startIdle():void{
            if (!_onFloorIdle.hasEventListener("complete"))
            {
                _onFloorIdle.addEventListener("complete", idleAniComplete);
            };
            _idleDelayedCall.reset(idleAni, 5);
            Starling.juggler.add(_idleDelayedCall);
        }
        private function stopIdle():void{
            _onFloorIdle.removeEventListener("complete", idleAniComplete);
            _onFloorIdle.visible = false;
            _onFloorIdle.stop();
            Starling.juggler.remove(_idleDelayedCall);
        }
        private function idleAni():void{
            _onFloor.visible = false;
            _onFloorIdle.visible = true;
            _onFloorIdle.stop();
            _onFloorIdle.play();
        }
        private function idleAniComplete():void{
            _onFloorIdle.removeEventListener("complete", idleAniComplete);
            _onFloor.visible = true;
            stopIdle();
            startIdle();
        }

    }
}//package ui.display

