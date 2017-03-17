// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//views.SettingsPopup

package views{
    import service.ILanguageService;
    import service.IPurchaseService;
    import starling.text.TextField;
    import ui.display.SimpleButton;
    import ui.display.ToggleButton;
    import starling.events.Event;

    public class SettingsPopup extends PopupView {

        [Model(alias="LanguageService")]
        public var languageService:ILanguageService;
        [Model(alias="PurchaseService")]
        public var purchaseService:IPurchaseService;
        private var _header:TextField;
        private var _purchaseBtn:SimpleButton;
        private var _restoreBtn:SimpleButton;
        private var _musicBtn:ToggleButton;
        private var _sfxBtn:ToggleButton;

        public function SettingsPopup(){
            this._id = 0;
        }
        override public function active(state:Boolean):void{
            super.active(state);
            if (state)
            {
                if (!purchaseService.getAdState())
                {
                    if (_purchaseBtn != null)
                    {
                        _purchaseBtn.label = languageService.translate("SETTINGS_IS_REMOVED", "ADVERTISING IS REMOVED");
                        _purchaseBtn.enabled = false;
                    };
                    if (_restoreBtn != null)
                    {
                        _restoreBtn.enabled = false;
                    };
                };
            };
        }
        override protected function drawScreen():void{
            super.drawScreen();
            _header = new TextField(_stageWidth, 48, languageService.translate("SETTINGS_LABEL", "SETTINGS"), "Museo", 48, 11381932);
            _header.hAlign = "center";
            _header.vAlign = "center";
            _header.y = 120;
            _container.addChild(_header);
            var _local_4:Number = (_stageWidth - (30 * 2));
            var _local_1:Number = ((_bg.height - 210) / 3);
            var _local_3:String = languageService.translate("SETTINGS_REMOVE", "REMOVE ADVERTISING");
            if (!purchaseService.getAdState())
            {
                _local_3 = languageService.translate("SETTINGS_IS_REMOVED", "ADVERTISING IS REMOVED");
            };
            if (!purchaseService.supported())
            {
                _local_3 = languageService.translate("SETTINGS_NOT_SUPPORTED", "IN APP PURCHASE IS NOT SUPPORTED");
            };
            _purchaseBtn = new SimpleButton(_local_4, _local_1, _local_3);
            _purchaseBtn.x = 30;
            _purchaseBtn.y = (210 + 30);
            _purchaseBtn.bgUpColor = 1155310;
            _purchaseBtn.bgDownColor = 952274;
            _purchaseBtn.labelUpColor = 0xFFFFFF;
            _purchaseBtn.labelDownColor = 0xFFFFFF;
            if (((purchaseService.supported()) && (purchaseService.getAdState())))
            {
                _purchaseBtn.enabled = true;
            }
            else
            {
                _purchaseBtn.enabled = false;
            };
            _container.addChild(_purchaseBtn);
            _restoreBtn = new SimpleButton(_local_4, _local_1, languageService.translate("SETTINGS_RESTORE", "RESTORE PURCHASES"));
            _restoreBtn.x = 30;
            _restoreBtn.y = (_purchaseBtn.y + _purchaseBtn.height);
            if (((purchaseService.supported()) && (purchaseService.getAdState())))
            {
                _restoreBtn.enabled = true;
            }
            else
            {
                _restoreBtn.enabled = false;
            };
            _restoreBtn.visible = false;
            _container.addChild(_restoreBtn);
            var _local_2:int = (_bg.width / 2);
            _musicBtn = new ToggleButton(languageService.translate("SETTINGS_MUSIC", "MUSIC"), _local_2, _local_1);
            _musicBtn.x = 30;
            _musicBtn.y = (_restoreBtn.y + _restoreBtn.height);
            _musicBtn.active(sound.getMusicState());
            _container.addChild(_musicBtn);
            _sfxBtn = new ToggleButton(languageService.translate("SETTINGS_SOUND", "SOUND"), _local_2, _local_1);
            _sfxBtn.x = (_local_2 + 30);
            _sfxBtn.y = (_restoreBtn.y + _restoreBtn.height);
            _sfxBtn.active(sound.getSFXState());
            _container.addChild(_sfxBtn);
        }
        override protected function btnClicked(e:Event):void{
            var _local_2:Boolean;
            super.btnClicked(e);
            switch (e.target)
            {
                case _purchaseBtn:
                    viewsController.setPopup(2);
                    return;
                case _restoreBtn:
                    viewsController.closePopup();
                    purchaseService.restore();
                    return;
                case _musicBtn:
                    _local_2 = sound.getMusicState();
                    _local_2 = !(_local_2);
                    sound.setMusicState(_local_2);
                    _musicBtn.active(_local_2);
                    return;
                case _sfxBtn:
                    _local_2 = sound.getSFXState();
                    _local_2 = !(_local_2);
                    sound.setSFXState(_local_2);
                    _sfxBtn.active(_local_2);
                    return;
                default:
                    return;
            };
        }

    }
}//package views

