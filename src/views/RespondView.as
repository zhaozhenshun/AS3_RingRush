// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//views.RespondView

package views{
	import controllers.ViewsController;
    import org.flashapi.hummingbird.view.AbstractStarlingSpriteView;
    import service.ISoundService;
    import service.IPurchaseService;
    import controllers.IViewsController;
    import service.ILanguageService;
    import utils.BasicButton;
    import starling.text.TextField;
    import starling.display.Quad;
    import events.ModelEvent;
    import constants.App;
    import starling.events.Event;

    public class RespondView extends AbstractStarlingSpriteView implements IGameView {

        [Model(alias="SoundService")]
        public var sound:ISoundService;
        [Model(alias="PurchaseService")]
        public var purchaseService:IPurchaseService;
        [Controller(alias="ViewsController")]
        public var viewsController:IViewsController = ViewsController.GetInstance();
        [Model(alias="LanguageService")]
        public var languageService:ILanguageService;
        private var _xPos:int;
        private var _yPos:int;
        protected var _stageWidth:int;
        protected var _stageHeight:int;
        protected var _closeBtn:BasicButton;
        protected var _closeBtnText:TextField;
        private var _statusLabel:TextField;
        private var _bgFaded:Quad;

        public function active(state:Boolean):void{
            this.touchable = state;
            ((state) ? addListener() : removeListener());
            if (_closeBtn != null)
            {
                _closeBtn.visible = false;
            };
            if (_statusLabel != null)
            {
                _statusLabel.text = languageService.translate("PURCHASE_PROCESSING", "PLEASE WAIT. PROCESSING ...");
                _statusLabel.redraw();
            };
        }
        protected function addListener():void{
            this.addEventListener("triggered", this.btnClicked);
            purchaseService.addEventListener("purchaseSuccess", onSuccess);
            purchaseService.addEventListener("purchaseFailed", onFailed);
        }
        protected function removeListener():void{
            this.removeEventListener("triggered", this.btnClicked);
            purchaseService.removeEventListener("purchaseSuccess", onSuccess);
            purchaseService.removeEventListener("purchaseFailed", onFailed);
        }
        override protected function onAddedToStage():void{
            this.drawScreen();
        }
        private function onSuccess(e:ModelEvent):void{
            _statusLabel.text = languageService.translate("PURCHASE_SUCCESS", "SUCCESS! THANK YOU! ADVERTISEMENT REMOVED.");
            _statusLabel.redraw();
            _closeBtn.visible = true;
        }
        private function onFailed(e:ModelEvent):void{
            var _local_2:String = ((languageService.translate("PURCHASE_FAIL", "SORRY! SOMETHING WENT WRONG, PLEASE TRY AGAIN LATER.") + " - ") + purchaseService.getFailMessage());
            _statusLabel.text = _local_2;
            _statusLabel.redraw();
            _closeBtn.visible = true;
        }
        protected function drawScreen():void{
            _stageWidth = App.STAGE_WIDTH;
            _stageHeight = App.STAGE_HEIGHT;
            _xPos = App.STAGE_XPOS;
            _yPos = App.STAGE_YPOS;
            _bgFaded = new Quad(_stageWidth, _stageHeight, 3357258);
            _bgFaded.alpha = 0.95;
            this.addChild(_bgFaded);
            _statusLabel = new TextField((_stageWidth - (30 * 2)), _stageHeight, languageService.translate("PURCHASE_PROCESSING", "PLEASE WAIT. PROCESSING ..."), "Museo", 36, 0xFFFFFF);
            _statusLabel.x = 30;
            _statusLabel.hAlign = "center";
            _statusLabel.vAlign = "center";
            _statusLabel.border = false;
            this.addChild(_statusLabel);
            _closeBtnText = new TextField(74, 74, "X", "Museo", 48, 0xFFFFFF);
            _closeBtnText.hAlign = "center";
            _closeBtnText.vAlign = "bottom";
            _closeBtn = new BasicButton();
            _closeBtn.content.addChild(_closeBtnText);
            _closeBtn.x = ((_stageWidth - 30) - _closeBtnText.width);
            _closeBtn.y = 30;
            _closeBtn.visible = false;
            this.addChild(_closeBtn);
        }
        protected function btnClicked(e:Event):void{
            sound.playSFX("sfx_menu");
            if (e.target == _closeBtn)
            {
                viewsController.closeRespond();
            };
        }

    }
}//package views

