
package {
    import flash.display.Sprite;
    //import com.milkmangames.nativeextensions.android.AndroidIAB;
    //import com.milkmangames.nativeextensions.GoViral;
    //import com.milkmangames.nativeextensions.GoogleGames;
    import constants.App;
    import starling.utils.RectangleUtil;
    import flash.geom.Rectangle;
    import org.flashapi.hummingbird.starling.StarlingPropertiesBuilder;
    import org.flashapi.hummingbird.starling.StarlingProperties;
    import org.flashapi.hummingbird.Hummingbird;
    import application.StarlingContext;
    import flash.events.Event;
	[SWF(width = "640",height = "760", frameRate= "60")]
    public class RingRush extends Sprite {

        private static const Museo:Class = _SafeStr_1;

        public function RingRush(){
            //if (AndroidIAB.isSupported())
            //{
                //AndroidIAB.create();
            //};
            //if (GoViral.isSupported())
            //{
                //GoViral.create();
            //};
            //if (GoogleGames.isSupported())
            //{
                //GoogleGames.create();
            //};
            if (this.stage)
            {
                this.init(null);
            }
            else
            {
                this.addEventListener("addedToStage", this.init);
            };
        }
        private function init(e:Event):void{
            var _local_3:Number;
            if (e)
            {
                this.removeEventListener("addedToStage", this.init);
            };
            var _local_5:int = stage.stageWidth;
            var _local_6:int = stage.stageHeight;
            var _local_4 = 640;
            var _local_8 = 760;
            if (_local_6 > _local_5)
            {
                _local_3 = (_local_6 / _local_5);
            }
            else
            {
                _local_3 = (_local_5 / _local_6);
            };
            if (_local_3 < 1.4)
            {
                //_local_4 = 0x0300;
                //_local_8 = 0x0400;
            };
            App.STAGE_ORGINAL_WIDTH = _local_4;
            App.STAGE_ORGINAL_HEIGHT = _local_8;
            var _local_2:Rectangle = RectangleUtil.fit(new Rectangle(0, 0, _local_4, _local_8), new Rectangle(0, 0, 640, 720), "noBorder");
            var _local_7:StarlingProperties = new StarlingPropertiesBuilder().antiAliasing(0).handleLostContext(true).showStats(true).viewPort(_local_2).profile("baseline").build();
            Hummingbird.setApplicationContext(new StarlingContext(), this.stage, _local_7);
        }

    }
}//package 

// _SafeStr_1 = "museo-300-webfont_ttf$a688addf065e5d630f638355805987a8-366718468" (String#50)


