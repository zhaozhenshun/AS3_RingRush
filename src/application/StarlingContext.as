// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//application.StarlingContext

package application{
    import org.flashapi.hummingbird.core.AbstractApplicationContext;
    import models.IAppModel;
	import service.GameService;
    import service.IDatabaseService;
    import controllers.IAppController;
    import controllers.IViewsController;
    import service.IAdService;
    import service.ISoundService;
    import service.IGameService;
    import service.ILanguageService;
    import service.IPurchaseService;
    import starling.utils.AssetManager;
    import starling.core.Starling;
    import starling.display.Sprite;
    import starling.text.TextField;
    import controllers.AppController;
    import controllers.ViewsController;
    //import controllers.SocialController;
    import utils.sqlite.SQLiteService;
    import service.DatabaseService;
    //import service.AdService;
    import service.SoundService;
    import service.LanguageService;
    //import service.PurchaseServiceAndroid;
    import service.GameServiceAndroid;
    import service.NetStatusService;
    import models.AppModel;
    import org.flashapi.hummingbird.Hummingbird;
    import constants.App;
    import flash.filesystem.File;
    import flash.system.Capabilities;
    //import com.milkmangames.nativeextensions.RateBox;
    import flash.desktop.NativeApplication;
    import flash.events.Event;

    public class StarlingContext extends AbstractApplicationContext {

        [RegisterClass(type="controllers.AppController")]
        public var appControllerRef:Class;
        [RegisterClass(type="controllers.ViewsController")]
        public var viewsControllerRef:ViewsController;
        [RegisterClass(type="controllers.SocialController")]
        public var socialControllerRef:Class;
        [RegisterClass(type="utils.sqlite.SQLiteService")]
        public var sqliteServiceRef:Class;
        [RegisterClass(type="service.DatabaseService")]
        public var databaseServiceRef:Class;
        [RegisterClass(type="service.AdService")]
        public var adServiceRef:Class;
        [RegisterClass(type="service.SoundService")]
        public var soundServiceRef:Class;
        [RegisterClass(type="service.LanguageService")]
        public var languageServiceRef:Class;
        [RegisterClass(type="service.PurchaseServiceAndroid")]
        public var purchaseServiceRef:Class;
        [RegisterClass(type="service.GameServiceAndroid")]
        public var gameCenterServiceRef:Class;
        [RegisterClass(type="service.NetStatusService")]
        public var netStatusServiceRef:Class;
        [RegisterClass(type="models.AppModel")]
        public var appModelRef:Class;
        [Model(alias="AppModel")]
        public var appModel:IAppModel =AppModel.GetInstance();
        [Model(alias="DatabaseService")]
        public var db:IDatabaseService = DatabaseService.GetInstance();
        [Controller(alias="AppController")]
        public var appController:IAppController = AppController.GetInstance();
        [Controller(alias="ViewsController")]
        public var viewsController:IViewsController = ViewsController.GetInstance();
        [Model(alias="AdService")]
        public var adService:IAdService;
        [Model(alias="SoundService")]
        public var soundService:ISoundService = SoundService.GetInstance();
        [Model(alias="GameService")]
        public var gameService:IGameService = GameService.GetInstance();
        [Model(alias="LanguageService")]
        public var languageService:ILanguageService;
        [Model(alias="PurchaseService")]
        public var pruchaseService:IPurchaseService;
        private var _assets:AssetManager;
        private var _sounds:Array;
        private var _starling:Starling;
        private var _container:Sprite;
        private var _label:TextField;
        private var _value:TextField;

        public function StarlingContext(){
            appControllerRef = AppController;
            viewsControllerRef = new ViewsController();
            //socialControllerRef = SocialController;
            sqliteServiceRef = SQLiteService;
            databaseServiceRef = DatabaseService;
            //adServiceRef = AdService;
            soundServiceRef = SoundService;
            languageServiceRef = LanguageService;
            //purchaseServiceRef = PurchaseServiceAndroid;
            gameCenterServiceRef = GameServiceAndroid;
            netStatusServiceRef = NetStatusService;
            appModelRef = AppModel;
            super();
        }
        override public function start():void{
            var _local_4:int;
            _starling = Hummingbird.getStarling();
            _starling.stage.stageWidth = App.STAGE_ORGINAL_WIDTH;
            _starling.stage.stageHeight = App.STAGE_ORGINAL_HEIGHT;
            _starling.viewPort.x = 0;
            _starling.viewPort.y = 0;
            _starling.start();
            var _local_2:int = Hummingbird.getStage().fullScreenHeight;
            var _local_3:int = (Starling.contentScaleFactor * App.STAGE_ORGINAL_HEIGHT);
            if (_local_2 < _local_3)
            {
                App.STAGE_HEIGHT_OFFSET = ((_local_3 - _local_2) / Starling.contentScaleFactor);
            };
            App.STAGE_WIDTH = App.STAGE_ORGINAL_WIDTH;
            App.STAGE_HEIGHT = (App.STAGE_ORGINAL_HEIGHT - App.STAGE_HEIGHT_OFFSET);
            App.STAGE_XPOS = (App.STAGE_WIDTH * 0.5);
            App.STAGE_YPOS = (App.STAGE_HEIGHT * 0.5);
            _container = new Sprite();
            _starling.stage.addChild(_container);
            _label = new TextField(App.STAGE_WIDTH, App.STAGE_YPOS, "LOADING", "Museo", 36, 0xFFFFFF);
            _label.hAlign = "center";
            _label.vAlign = "bottom";
            _label.border = false;
            _container.addChild(_label);
            _value = new TextField(App.STAGE_WIDTH, App.STAGE_YPOS, "0%", "Museo", 72, 0xFFFFFF);
            _value.hAlign = "center";
            _value.vAlign = "top";
            _value.y = App.STAGE_YPOS;
            _value.border = false;
            _container.addChild(_value);
            _sounds = ["sfx_jump", "sfx_star_pickup", "sfx_menu", "sfx_explosion", "sfx_changedirection", "sfx_sun", "sfx_bounce", "sfx_smash", "sfx_spikes", "sfx_brick", "sfx_counter", "sfx_highscore"];
            var _local_1:File = File.applicationDirectory;
            _assets = new AssetManager();
			trace("____" + _local_1.resolvePath("assets/graphics/spritesheet_small.png"));
            _assets.enqueue(_local_1.resolvePath("assets/graphics/spritesheet_small.png"));
            _assets.enqueue(_local_1.resolvePath("assets/graphics/spritesheet_small.xml"));
            _assets.enqueue(_local_1.resolvePath("assets/sounds/music/music.mp3"));
            _local_4 = 0;
            while (_local_4 < _sounds.length)
            {
                _assets.enqueue(_local_1.resolvePath((("assets/sounds/sfx/" + _sounds[_local_4]) + ".mp3")));
                _local_4++;
            };
            _assets.loadQueue(loading);
        }
        private function loading(ratio:Number):void{
            _value.text = (Math.round((ratio * 100)) + "%");
            _value.redraw();
            if (ratio == 1)
            {
                ready();
            };
        }
        private function ready():void{
            var _local_2:int;
            while (_container.numChildren > 0)
            {
                _container.removeChildAt(0);
            };
            _starling.stage.removeChild(_container);
            _container = null;
            _label = null;
            _value = null;
            db.init();
            appModel.setAssets(_assets);
            //pruchaseService.init();
            var _local_1:Array = Capabilities.languages;
            //languageService.setLocale(_local_1[0].toString().toLowerCase());
            //if (RateBox.isSupported())
            //{
                //RateBox.create("878644127", languageService.translate("RATE_TITLE", "Please rate Ring Rush"), languageService.translate("RATE_MESSAGE", "If you like it, please rate it!"), languageService.translate("RATE_NOW_LABEL", "Rate Now"), languageService.translate("RATE_DECLINE_LABEL", "Ask Me Later"), languageService.translate("RATE_NOT_LABEL", "Don't ask again"), 0, 3, 0);
            //};
            gameService.init();
            //soundService.init(_assets);
            _local_2 = 0;
            while (_local_2 < _sounds.length)
            {
                //soundService.addSFX(_sounds[_local_2]);
                _local_2++;
            };
            appController.init();
            viewsController.init();
            NativeApplication.nativeApplication.addEventListener("deactivate", deactivateHandler, false, 0, true);
        }
        private function deactivateHandler(event:Event):void{
            if (soundService.getMusicState())
            {
                soundService.checkMusicState(false);
            };
            var _local_2:Starling = Hummingbird.getStarling();
            _local_2.stop();
            NativeApplication.nativeApplication.addEventListener("activate", activateHandler, false, 0, true);
        }
        private function activateHandler(event:Event):void{
            //if (RateBox.isSupported())
            //{
                //RateBox.rateBox.onLaunch();
            //};
            if (soundService.getMusicState())
            {
                soundService.checkMusicState(true);
            };
            NativeApplication.nativeApplication.removeEventListener("activate", activateHandler);
            var _local_2:Starling = Hummingbird.getStarling();
            _local_2.start();
        }

    }
}//package application

