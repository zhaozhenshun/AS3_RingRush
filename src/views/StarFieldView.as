// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//views.StarFieldView

package views{
	import models.AppModel;
    import org.flashapi.hummingbird.view.AbstractStarlingSpriteView;
    import models.IAppModel;
    import utils.ObjectPool;
    import constants.App;
    import utils.Random;
    import starling.animation.Tween;
    import starling.core.Starling;

    public class StarFieldView extends AbstractStarlingSpriteView implements IGameView {

        [Model(alias="AppModel")]
        public var appModel:IAppModel = AppModel.GetInstance();
        private var _objectPool:ObjectPool;

        public function StarFieldView(){
            this.touchable = false;
        }
        public function active(state:Boolean):void{
        }
        override protected function onAddedToStage():void{
            _objectPool = new ObjectPool(appModel.getAssets());
            this.drawScreen();
        }
        private function drawScreen():void{
            var _local_3 = null;
            var _local_1 = null;
            var _local_6 = null;
            var _local_5 = null;
            var _local_2:int;
            var _local_4:int = App.STAGE_WIDTH;
            var _local_7:int = App.STAGE_HEIGHT;
            _local_2 = 0;
            while (_local_2 < 30)
            {
                _local_3 = _objectPool.getImage(21);
                _local_3.blendMode = "normal";
                _local_3.pivotX = (_local_3.width * 0.5);
                _local_3.pivotY = (_local_3.height * 0.5);
                _local_1 = Random.getPoint(_local_4, (_local_7 + 250));
                _local_3.x = App.STAGE_XPOS;
                _local_3.y = 60;
                _local_3.alpha = 0;
                _local_3.scaleX = 0.1;
                _local_3.scaleY = 0.1;
                this.addChild(_local_3);
                _local_6 = new Tween(_local_3, 1);
                _local_6.delay = Random.getInteger(1, 10);
                _local_6.repeatCount = 0;
                _local_6.repeatDelay = Random.getInteger(1, 5);
                _local_6.reverse = true;
                _local_6.scaleTo(0.1);
                _local_5 = new Tween(_local_3, 0.5);
                _local_5.fadeTo(1);
                _local_5.scaleTo((Random.getInteger(1, 10) / 10));
                _local_5.moveTo(_local_1.x, _local_1.y);
                _local_5.nextTween = _local_6;
                _local_5.delay = (Random.getInteger(1, 3) / 10);
                Starling.juggler.add(_local_5);
                _local_2++;
            };
        }

    }
}//package views

