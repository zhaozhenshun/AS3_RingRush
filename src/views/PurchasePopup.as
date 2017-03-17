// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//views.PurchasePopup

package views{
	import models.AppModel;
    import models.IAppModel;
    import service.ILanguageService;
    import service.IPurchaseService;
    import starling.display.Image;
    import starling.text.TextField;
    import ui.display.InfoButton;
    import starling.utils.AssetManager;
    import events.ModelEvent;
    import starling.events.Event;

    public class PurchasePopup extends PopupView {

        [Model(alias="AppModel")]
        public var appModel:IAppModel = AppModel.GetInstance();
        [Model(alias="LanguageService")]
        public var languageService:ILanguageService;
        [Model(alias="PurchaseService")]
        public var purchaseService:IPurchaseService;
        private var _hearts:Image;
        private var _figure:Image;
        protected var _info:TextField;
        protected var _purchaseBtn:InfoButton;
        private var _assets:AssetManager;

        public function PurchasePopup(){
            this._id = 2;
        }
        override public function active(state:Boolean):void{
            super.active(state);
        }
        override protected function addListener():void{
            super.addListener();
            purchaseService.addEventListener("purchaseSuported", suported);
            purchaseService.addEventListener("purchaseProductReady", productReady);
        }
        override protected function removeListener():void{
            super.removeListener();
            purchaseService.removeEventListener("purchaseSuported", suported);
            purchaseService.removeEventListener("purchaseProductReady", productReady);
        }
        override protected function onDependencyComplete():void{
            _assets = appModel.getAssets();
        }
        private function suported(e:ModelEvent):void{
            enablePurchaseButton();
        }
        private function productReady(e:ModelEvent):void{
            if (_purchaseBtn != null)
            {
                _purchaseBtn.label2 = purchaseService.getProductPrice();
            };
        }
        private function enablePurchaseButton():void{
            if (_purchaseBtn != null)
            {
                if (((purchaseService.supported()) && (purchaseService.getAdState())))
                {
                    _purchaseBtn.enabled = true;
                }
                else
                {
                    _purchaseBtn.enabled = false;
                };
            };
        }
        override protected function drawScreen():void{
            super.drawScreen();
            var _local_3:Number = (_stageWidth - (30 * 2));
            var _local_1:Number = ((_bg.height - 210) / 3);
            var _local_2 = 120;
            _hearts = new Image(_assets.getTexture("player_handsom_hearts"));
            _hearts.x = (_stageWidth * 0.5);
            _hearts.y = 310;
            _container.addChild(_hearts);
            _figure = new Image(_assets.getTexture("player_handsome"));
            _figure.x = ((_stageWidth * 0.5) - (_figure.width * 0.5));
            _figure.y = (320 + 30);
            _container.addChild(_figure);
            _info = new TextField((_local_3 - _local_2), (_local_1 * 2), languageService.translate("PURCHASE_INFO", "THANK YOU SO MUCH FOR YOUR SUPPORT!"), "Museo", 36, 1155310);
            _info.hAlign = "center";
            _info.vAlign = "center";
            _info.x = (30 + (_local_2 / 2));
            _info.y = (210 + 30);
            _container.addChild(_info);
            _purchaseBtn = new InfoButton(_local_3, _local_1, languageService.translate("SETTINGS_REMOVE", "REMOVE ADVERTISING"), purchaseService.getProductPrice(), "Verdana");
            _purchaseBtn.x = 30;
            _purchaseBtn.y = ((30 + _bg.height) - _purchaseBtn.height);
            _purchaseBtn.label1UpColor = 0xFFFFFF;
            _purchaseBtn.label1DownColor = 0xFFFFFF;
            _purchaseBtn.label2UpColor = 16692564;
            _purchaseBtn.label2DownColor = 16699476;
            _purchaseBtn.bgUpColor = 15030333;
            _purchaseBtn.bgDownColor = 13322030;
            _container.addChild(_purchaseBtn);
            enablePurchaseButton();
        }
        override protected function btnClicked(e:Event):void{
            super.btnClicked(e);
            if (e.target == _purchaseBtn)
            {
                viewsController.closePopup();
                purchaseService.purchase();
            };
        }

    }
}//package views

