// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//ui.display.Ring

package ui.display{
	import models.AppModel;
    import org.flashapi.hummingbird.view.AbstractStarlingSpriteView;
    import views.IGameView;
    import models.IAppModel;
    import __AS3__.vec.Vector;
    import models.dto.ElementItem;
    import starling.display.Sprite;
    import starling.animation.Tween;
    import utils.ObjectPool;
    import starling.core.Starling;
    import events.ModelEvent;
    import flash.geom.Point;
    import utils.MyMovieclip;
    import starling.display.DisplayObject;
    import utils.MyImage;
    import utils.Random;
    import constants.App;
    import utils.Rotation;

    public class Ring extends AbstractStarlingSpriteView implements IGameView {

        [Model(alias="AppModel")]
        public var appModel:IAppModel = AppModel.GetInstance() ;
        private var _id:uint;
        private var _distanceId:uint;
        private var _rid:uint;
        private var _speed:Number = 0;
        private var _update:Number = 0;
        private var _radius:Number = 100;
        private var _color:Number;
        private var _elements:Vector.<ElementItem>;
        private var segmentStart:Number;
        private var segmentEnd:Number;
        private var _container:Sprite;
        private var _containerTween:Tween;
        private var _pool:ObjectPool;
        private var _delay:Number;
        private var _itemWidth:Number;

        public function Ring(){
            _container = new Sprite();
            super();
            this.touchable = false;
            _containerTween = new Tween(_container, 0.3);
			onDependencyComplete();
        }
        override protected function onDependencyComplete():void{
            _pool = new ObjectPool(appModel.getAssets());
        }
        public function active(state:Boolean):void{
            if (state)
            {
                _container.alpha = 1;
                Starling.current.stage.addEventListener("enterFrame", this.enterFrameHandler);
                appModel.addEventListener("stateChange", stateChange);
            }
            else
            {
                Starling.current.stage.removeEventListener("enterFrame", this.enterFrameHandler);
                appModel.removeEventListener("stateChange", stateChange);
                tweenContainer(0.2, (_distanceId * 0.1), 0);
            };
        }
        private function tweenContainer(time:Number, delay:Number, fade:Number):void{
            Starling.juggler.remove(_containerTween);
            _containerTween.reset(_container, time);
            _containerTween.delay = delay;
            _containerTween.fadeTo(fade);
            _containerTween.onComplete = this.clearElements;
            Starling.juggler.add(_containerTween);
        }
        private function enterFrameHandler():void{
            this.rotation = (this.rotation + _update);
        }
        override protected function onAddedToStage():void{
            this.addChild(_container);
        }
        public function stateChange(e:ModelEvent):void{
            switch (appModel.getState())
            {
                case 4:
                    tweenContainer(0.2, (_distanceId * 0.1), 0);
                    return;
                case 3:
                    speed = 0;
                    return;
                case 8:
                    speed = 0;
                    explodeElements();
                default:
            };
        }
        private function addElement(element:ElementItem, width:Number, pos:Point, rotation:Number, fade:Boolean=true):void{
            var _local_9 = null;
            var _local_6 = null;
            var _local_8 = null;
            var _local_7 = null;
            if (element.display != 0)
            {
                if (element.display == 1)
                {
                    _local_9 = _pool.getImage(element.type);
                    _local_9.scaleX = 1;
                    _local_9.scaleY = 1;
                    _local_9.type = element.type;
                    _local_9.name = ("element_" + element.id);
                    _local_9.rotation = 0;
                    _local_9.width = width;
                    _local_9.pivotX = (_local_9.width * 0.5);
                    _local_9.pivotY = (_local_9.height * 0.5);
                    _local_9.x = pos.x;
                    _local_9.y = pos.y;
                    _local_9.rotation = rotation;
                    _local_9.touchable = false;
                    _container.addChildAt(_local_9, 0);
                    if (fade)
                    {
                        _local_6 = new Tween(_local_9, 0.2);
                        _local_9.alpha = 0;
                        _local_9.scaleX = 2;
                        _local_9.scaleY = 2;
                        _local_6.fadeTo(1);
                        _local_6.scaleTo(1);
                        _local_6.delay = _delay;
                        Starling.juggler.add(_local_6);
                    };
                }
                else
                {
                    if (element.display == 2)
                    {
                        _local_8 = _pool.getMovieclip(element.type);
                        _local_8.type = element.type;
                        _local_8.scaleX = 1;
                        _local_8.scaleY = 1;
                        _local_8.name = ("element_" + element.id);
                        _local_8.rotation = 0;
                        _local_8.width = width;
                        _local_8.pivotX = (width * 0.5);
                        _local_8.pivotY = (_local_8.height * 0.5);
                        _local_8.x = pos.x;
                        _local_8.y = pos.y;
                        _local_8.rotation = rotation;
                        _local_8.loop = false;
                        _local_8.stop();
                        _local_8.touchable = false;
                        if (element.type != 13)
                        {
                            _local_8.setFrameDuration(0, 0.05);
                            _local_8.setFrameDuration(1, 0.05);
                            _local_8.setFrameDuration(2, 0.05);
                        }
                        else
                        {
                            _local_8.loop = -1;
                            _local_8.fps = 1;
                            _local_8.play();
                        };
                        _container.addChildAt(_local_8, 0);
                        Starling.juggler.add(_local_8);
                        if (fade)
                        {
                            _local_7 = new Tween(_local_8, 0.2);
                            _local_8.alpha = 0;
                            _local_8.scaleX = 2;
                            _local_8.scaleY = 2;
                            _local_7.fadeTo(1);
                            _local_7.scaleTo(1);
                            _local_7.delay = _delay;
                            Starling.juggler.add(_local_7);
                        };
                    };
                };
            };
        }
        public function getMorphIndex(id:uint):uint {
            var _local_2:MyMovieclip = getMovieclipByID(id);
            if (_local_2 != null)
            {
                _local_2.pause();
                return (_local_2.currentFrame);
            };
            return (0);
        }
        public function setNewItem(element:ElementItem):void{
            var _local_4:DisplayObject = _container.getChildByName(("element_" + element.id));
            var _local_2:Point = new Point(_local_4.x, _local_4.y);
            var _local_3:Number = _local_4.rotation;
            remove(element.id);
            addElement(element, _itemWidth, _local_2, _local_3, false);
        }
        public function animate(id:uint):void{
            var _local_2:MyMovieclip = getMovieclipByID(id);
            if (_local_2 != null)
            {
                _local_2.stop();
                _local_2.play();
            };
            _local_2 = null;
        }
        public function remove(id:uint):void{
            var _local_4 = null;
            var _local_2 = null;
            var _local_3:DisplayObject = _container.getChildByName(("element_" + id));
            if ((_local_3 is MyImage))
            {
                _local_4 = (_local_3 as MyImage);
                _pool.returnImage(_local_4);
                _container.removeChild(_local_4);
            }
            else
            {
                if ((_local_3 is MyMovieclip))
                {
                    _local_2 = (_local_3 as MyMovieclip);
                    _pool.returnMovieclip(_local_2);
                    _container.removeChild(_local_2);
                };
            };
            _local_3 = null;
        }
        public function moveToCenter(id:uint):void{
            var _local_2 = null;
            var _local_3:MyImage = getImageByID(id);
            if (_local_3 != null)
            {
                _local_2 = new Tween(_local_3, 0.7);
                _local_2.moveTo(0, 0);
                _local_2.scaleTo(2);
                _local_2.fadeTo(0);
                Starling.juggler.add(_local_2);
            };
        }
        public function getImageByID(id:uint):MyImage{
            return ((_container.getChildByName(("element_" + id)) as MyImage));
        }
        public function getMovieclipByID(id:uint):MyMovieclip{
            return ((_container.getChildByName(("element_" + id)) as MyMovieclip));
        }
        private function explodeElements():void{
            var _local_11:Number;
            var _local_10 = null;
            var _local_1 = null;
            var _local_5:Number;
            var _local_3 = null;
            var _local_6 = null;
            var _local_2 = null;
            var _local_12 = null;
            var _local_4 = null;
            var _local_9:int;
            var _local_13:int = _elements.length;
            var _local_7:Number = (360 / _local_13);
            var _local_8 = 0;
            var _local_14:Number = (_distanceId * 0.15);
            _local_9 = 0;
            while (_local_9 < _local_13)
            {
                _local_1 = _elements[_local_9];
                _local_11 = (((_local_9 / _local_13) * 3.14159265358979) * 2);
                _local_5 = Random.getInteger(50, 400);
                _local_10 = Point.polar((_radius + _local_5), _local_11);
                _local_8 = (_local_8 + _local_7);
                if (_local_1.orgType != 0)
                {
                    if (_local_1.orgType != 13)
                    {
                        _local_3 = App.elementType(_local_1.orgType);
                    }
                    else
                    {
                        if (_local_1.type == 0)
                        {
                            _local_3 = App.elementType(_local_1.lastType);
                        }
                        else
                        {
                            _local_3 = App.elementType(_local_1.type);
                        };
                    };
                    if (_local_3.display == 1)
                    {
                        _local_6 = getImageByID(_local_1.id);
                        _local_2 = new Tween(_local_6, 0.7);
                        _local_2.moveTo(_local_10.x, _local_10.y);
                        _local_2.scaleTo(0);
                        _local_2.delay = _local_14;
                        Starling.juggler.add(_local_2);
                    }
                    else
                    {
                        if (_local_3.display == 2)
                        {
                            _local_12 = getMovieclipByID(_local_1.id);
                            _local_4 = new Tween(_local_12, 0.7);
                            _local_4.moveTo(_local_10.x, _local_10.y);
                            _local_4.delay = _local_14;
                            _local_4.scaleTo(0);
                            Starling.juggler.add(_local_4);
                        };
                    };
                };
                _local_9++;
            };
        }
        private function clearElements():void{
            var _local_3 = null;
            var _local_2 = null;
            var _local_1 = null;
            while (_container.numChildren > 0)
            {
                _local_3 = _container.getChildAt(0);
                if ((_local_3 is MyMovieclip))
                {
                    _local_1 = (_local_3 as MyMovieclip);
                    _local_1.stop();
                    Starling.juggler.remove(_local_1);
                    _pool.returnMovieclip(_local_1);
                }
                else
                {
                    if ((_local_3 is MyImage))
                    {
                        _local_2 = (_local_3 as MyImage);
                        _pool.returnImage(_local_2);
                    };
                };
                _container.removeChildAt(0);
            };
        }
        public function create():void{
            var _local_1:Number;
            var _local_8 = null;
            var _local_2 = null;
            var _local_3:Number;
            var _local_7:int;
            _container.alpha = 1;
            this.clearElements();
            var _local_4:int = _elements.length;
            var _local_6:Number = (360 / _local_4);
            var _local_5 = 0;
            _itemWidth = Math.round(((2 * _radius) * Math.sin(Rotation.radFromDeg((_local_6 / 2)))));
            _container.rotation = Rotation.radFromDeg((90 + (_local_6 / 2)));
            _delay = 0;
            _local_7 = 0;
            while (_local_7 < _local_4)
            {
                _local_1 = (((_local_7 / _local_4) * 3.14159265358979) * 2);
                _local_8 = Point.polar(_radius, _local_1);
                _local_2 = _elements[_local_7];
                _local_3 = (_local_1 - Rotation.radFromDeg(-90));
                addElement(_local_2, _itemWidth, _local_8, _local_3);
                _local_5 = (_local_5 + _local_6);
                if (_local_2.type != 0)
                {
                    _delay = (_delay + 0.02);
                };
                _local_7++;
            };
        }
        public function set distanceId(val:uint):void{
            _distanceId = val;
        }
        public function set radius(val:uint):void{
            _radius = val;
        }
        public function get radius():uint{
            return (_radius);
        }
        public function set speed(val:Number):void{
            _update = (val / 70);
            _speed = val;
        }
        public function get speed():Number{
            return (_speed);
        }
        public function set elements(elements:Vector.<ElementItem>):void{
            _elements = elements;
        }
        public function set id(id:uint):void{
            _id = id;
        }
        public function get id():uint{
            return (_id);
        }
        public function set rid(id:uint):void{
            _rid = id;
        }
        public function get rid():uint{
            return (_rid);
        }
        public function get degree():Number{
            return (Rotation.degFromSprite(this));
        }

    }
}//package ui.display

