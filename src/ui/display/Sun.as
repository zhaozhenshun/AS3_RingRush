// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//ui.display.Sun

package ui.display{
	import models.AppModel;
    import org.flashapi.hummingbird.view.AbstractStarlingSpriteView;
    import views.IGameView;
    import models.IAppModel;
    import starling.display.Sprite;
    import starling.display.MovieClip;
    import starling.display.Image;
    import starling.animation.Tween;
    import utils.ChangeColor;
    import starling.utils.AssetManager;
    import starling.core.Starling;
    import utils.Rotation;
    import events.ModelEvent;

    public class Sun extends AbstractStarlingSpriteView implements IGameView {

        [Model(alias="AppModel")]
        public var model:IAppModel = AppModel.GetInstance();
        private var _sunContainer:Sprite;
        private var _sun:MovieClip;
        private var _sunTransition:Image;
        private var _sunTransitionTween:Tween;
        private var _sunTween:Tween;
        private var _sunAura:Image;
        private var _sunAura2:Image;
        private var _sunExploded:Image;
        private var _sunAuraContainer:Sprite;
        private var _sunAuraTween:Tween;
        private var _sunExloded:Tween;
        private var _colorTween:Tween;
        private var _colorChange:ChangeColor;
        private var _alpha:Tween;
        private var _scale:Tween;
        private var _assets:AssetManager;

        public function Sun(){
            this.touchable = false;
			onDependencyComplete();
        }
        override protected function onDependencyComplete():void{
            _assets = model.getAssets();
        }
        public function active(state:Boolean):void{
            if (state)
            {
                model.addEventListener("stateChange", stateChange);
                Starling.current.stage.addEventListener("enterFrame", this.enterFrameHandler);
            }
            else
            {
                model.removeEventListener("stateChange", stateChange);
                Starling.current.stage.removeEventListener("enterFrame", this.enterFrameHandler);
            };
            if (state)
            {
                _sunContainer.scaleX = 1;
                _sunContainer.scaleY = 1;
                _sunContainer.alpha = 0;
                _sun.color = 0xFCFF00;
                _sunAuraContainer.scaleX = 1;
                _sunAuraContainer.scaleY = 1;
                _sunAuraContainer.alpha = 0;
            };
            var _local_2:Number = ((state) ? 0.6 : 2);
            var _local_3:int = ((state) ? 1 : 0);
            _sun.stop();
            tweenSun(0.5, _local_2, _local_3);
            _local_2 = ((state) ? 0.3 : 1);
            _local_3 = ((state) ? 1 : 0);
            tweenAura(0.5, _local_2, _local_3);
        }
        override protected function onAddedToStage():void{
            _sunTween = new Tween(_sunContainer, 0.5, "easeOut");
            _sunAuraTween = new Tween(_sunAuraContainer, 0.5, "easeOut");
            _sunTransitionTween = new Tween(_sunTransition, 0.5, "easeOut");
            _sunExloded = new Tween(_sunExloded, 0.3);
            _colorTween = new Tween(_colorTween, 0.5);
            this.drawScreen();
        }
        private function enterFrameHandler():void{
            _sunAura.rotation = (_sunAura.rotation + 0.005);
            _sunAura2.rotation = (_sunAura2.rotation - 0.001);
        }
        private function drawScreen():void{
            _sunAuraContainer = new Sprite();
            _sunAuraContainer.scaleX = 0.3;
            _sunAuraContainer.scaleY = 0.3;
            _sunAuraContainer.alpha = 0;
            _sunAuraContainer.touchable = false;
            this.addChild(_sunAuraContainer);
            _sunContainer = new Sprite();
            _sunContainer.scaleX = 1;
            _sunContainer.scaleY = 1;
            _sunContainer.alpha = 0;
            _sunContainer.touchable = false;
            this.addChild(_sunContainer);
            _sunExploded = new Image(_assets.getTexture("sun_exploded"));
            _sunExploded.pivotX = (_sunExploded.width * 0.5);
            _sunExploded.pivotY = (_sunExploded.height * 0.5);
            _sunExploded.visible = false;
            _sunExploded.alpha = 0;
            _sunExploded.scaleX = 0;
            _sunExploded.scaleY = 0;
            _sunExploded.touchable = false;
            this.addChild(_sunExploded);
            _sunAura = new Image(_assets.getTexture("sun_aura"));
            _sunAura.pivotX = (_sunAura.width * 0.5);
            _sunAura.pivotY = (_sunAura.height * 0.5);
            _sunAura.touchable = false;
            _sunAuraContainer.addChild(_sunAura);
            _sunAura2 = new Image(_assets.getTexture("sun_aura"));
            _sunAura2.pivotX = (_sunAura.width * 0.5);
            _sunAura2.pivotY = (_sunAura.height * 0.5);
            _sunAura2.scaleX = 0.85;
            _sunAura2.scaleY = 0.85;
            _sunAura2.alpha = 0.8;
            _sunAura2.color = 0xFFDE00;
            _sunAura2.touchable = false;
            _sunAuraContainer.addChild(_sunAura2);
            _sun = new MovieClip(_assets.getTextures("sun_face_"), 0.75);
            _sun.pivotX = (_sun.width * 0.5);
            _sun.pivotY = (_sun.height * 0.5);
            _sun.loop = false;
            _sun.touchable = false;
            _sunContainer.addChild(_sun);
            _sunTransition = new Image(_assets.getTexture("sun_transition"));
            _sunTransition.pivotX = (_sunTransition.width * 0.5);
            _sunTransition.pivotY = (_sunTransition.height * 0.5);
            _sunTransition.rotation = Rotation.radFromDeg(-30);
            _sunTransition.visible = false;
            _sunTransition.touchable = false;
            _sunContainer.addChild(_sunTransition);
            tweenTransition(0.4);
            _colorChange = new ChangeColor();
            _colorChange.setCallback(changeSunColor);
            _colorChange.setColors(0xFCFF00, 0xFF0000);
        }
        private function tweenColor(time:*):void{
            Starling.juggler.remove(_colorTween);
            _colorTween.reset(_colorChange, time);
            _colorTween.animate("currentProgress", 1);
            Starling.juggler.add(_colorTween);
        }
        private function changeSunColor():void{
            _sun.color = _colorChange.color;
        }
        private function changeExplodeColor():void{
            _sunExploded.color = _colorChange.color;
        }
        private function tweenSun(time:Number, scale:Number, fade:Number, delay:Number=0):void{
            Starling.juggler.remove(_sunTween);
            _sunTween.reset(_sunContainer, time);
            _sunTween.scaleTo(scale);
            _sunTween.fadeTo(fade);
            _sunTween.delay = delay;
            Starling.juggler.add(_sunTween);
        }
        private function tweenAura(time:Number, scale:Number, fade:Number, delay:Number=0, onComplete:Function=null):void{
            Starling.juggler.remove(_sunAuraTween);
            _sunAuraTween.reset(_sunAuraContainer, time);
            _sunAuraTween.scaleTo(scale);
            _sunAuraTween.fadeTo(fade);
            _sunAuraTween.delay = delay;
            if (onComplete != null)
            {
                _sunAuraTween.onComplete = onComplete;
            };
            Starling.juggler.add(_sunAuraTween);
        }
        private function tweenExploded(time:Number, scale:Number, fade:Number, onComplete:Function=null):void{
            Starling.juggler.remove(_sunExloded);
            _sunExloded.reset(_sunExploded, time);
            _sunExloded.scaleTo(scale);
            _sunExloded.fadeTo(fade);
            if (onComplete != null)
            {
                _sunExloded.onComplete = onComplete;
            };
            Starling.juggler.add(_sunExloded);
        }
        private function tweenTransition(time:Number):void{
            Starling.juggler.remove(_sunTransitionTween);
            _sunTransitionTween.reset(_sunTransition, time);
            _sunTransitionTween.animate("rotation", Rotation.radFromDeg(30));
            _sunTransitionTween.reverse = true;
            _sunTransitionTween.repeatCount = 0;
            Starling.juggler.add(_sunTransitionTween);
        }
        public function stateChange(e:ModelEvent):void{
            var _local_2:Number;
            var _local_3:Number;
            var _local_4:Number;
            _sunExploded.visible = false;
            _sunTransition.visible = false;
            switch (model.getState())
            {
                case 1:
                    removeTweens();
                    _sun.fps = 0.75;
                    resetExploded();
                    _colorChange.setCallback(changeSunColor);
                    _colorChange.setColors(0xFCFF00, 0xFF0000);
                    _sun.stop();
                    tweenSun(0.2, 0.6, 1);
                    tweenAura(0.2, 0.3, 1);
                    return;
                case 8:
                    removeTweens();
                    _sunExploded.visible = true;
                    _colorChange.setCallback(changeExplodeColor);
                    _colorChange.setColors(0xFF0000, 0xFCFF00);
                    tweenExploded(0.2, 1, 1, exploded);
                    tweenColor(0.2);
                    tweenSun(0.2, 0, 0);
                    tweenAura(0.4, 2, 1, 0.15, auraExploded);
                    return;
                case 3:
                    removeTweens();
                    return;
                case 5:
                    removeTweens();
                    reset(4);
                    tweenSun(4, 0.1, 1);
                    tweenAura(4, 0.3, 0);
                    tweenColor(4);
                    start();
                    return;
                case 4:
                    removeTweens();
                    _sunTransition.visible = true;
                    _sun.stop();
                    _colorChange.setCallback(changeSunColor);
                    _colorChange.setColors(_sun.color, 0xFCFF00);
                    tweenSun(0.4, 1, 1);
                    tweenAura(0.4, 1, 1);
                    tweenColor(0.4);
                    start();
                    return;
                case 9:
                    removeTweens();
                    tweenSun(0.3, 0, 0);
                    tweenAura(0.3, 0, 0);
                    start();
                    return;
                case 6:
                    removeTweens();
                    _local_2 = _sunTween.currentTime;
                    _local_3 = _sunTween.totalTime;
                    _local_4 = (_local_2 - 2);
                    if (_local_4 < 0)
                    {
                        _local_3 = ((_sunTween.totalTime - _local_2) + 2);
                        _local_4 = 0;
                    };
                    reset(_local_3);
                    tweenSun(_local_3, 0.1, 1);
                    tweenAura(_local_3, 0.3, 0);
                    tweenColor(_local_3);
                    start();
                    _sun.advanceTime(_local_4);
                    _sunTween.advanceTime(_local_4);
                    _sunAuraTween.advanceTime(_local_4);
                    _colorTween.advanceTime(_local_4);
                default:
            };
        }
        private function exploded():void{
            tweenExploded(0.1, 0, 0);
        }
        private function auraExploded():void{
            tweenAura(0.2, 1.3, 0);
        }
        private function removeTweens():void{
            Starling.juggler.remove(_colorTween);
            Starling.juggler.removeTweens(_sunAura);
            Starling.juggler.removeTweens(_sunExloded);
            Starling.juggler.removeTweens(_sun);
            _sun.pause();
        }
        private function reset(time:Number):void{
            _sun.stop();
            _sun.fps = (1 / (time / 3));
            _sun.color = 0xFCFF00;
            _sunContainer.scaleX = 0.6;
            _sunContainer.scaleY = 0.6;
            _sunContainer.alpha = 1;
            _sunAuraContainer.scaleX = 0.3;
            _sunAuraContainer.scaleY = 0.3;
            _sunAuraContainer.alpha = 1;
            resetExploded();
            _colorChange.setCallback(changeSunColor);
            _colorChange.setColors(0xFCFF00, 0xFF0000);
        }
        private function resetExploded():void{
            _sunExploded.alpha = 0;
            _sunExploded.scaleX = 0;
            _sunExploded.scaleY = 0;
        }
        private function start():void{
            _sun.play();
            Starling.juggler.add(_sun);
        }

    }
}//package ui.display

