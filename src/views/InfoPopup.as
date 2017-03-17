// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//views.InfoPopup

package views{
    import service.ILanguageService;
    import starling.text.TextField;
    import ui.display.InfoButton;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import starling.events.Event;

    public class InfoPopup extends PopupView {

        [Model(alias="LanguageService")]
        public var languageService:ILanguageService;
        private var _header:TextField;
        private var _gvand:InfoButton;
        private var _benni:InfoButton;
        private var _facebook:InfoButton;

        public function InfoPopup(){
            this._id = 0;
        }
        override protected function drawScreen():void{
            super.drawScreen();
            var _local_2:Number = (_stageWidth - (30 * 2));
            var _local_1:Number = ((_bg.height - 210) / 3);
            _header = new TextField(_local_2, 48, languageService.translate("INFO_LABEL", "MADE BY"), "Museo", 48, 11381932);
            _header.hAlign = "center";
            _header.vAlign = "center";
            _header.x = 30;
            _header.y = 120;
            _container.addChild(_header);
            _gvand = new InfoButton(_local_2, _local_1, "Gerbrand van Dantzig", "@the_gvand");
            _gvand.x = 30;
            _gvand.y = (210 + 30);
            _container.addChild(_gvand);
            _benni = new InfoButton(_local_2, _local_1, "Benjamin Schwarz", "@black_benni");
            _benni.x = 30;
            _benni.y = (_gvand.y + _gvand.height);
            _container.addChild(_benni);
            _facebook = new InfoButton(_local_2, _local_1, languageService.translate("INFO_HELLO", "SAY HELLO"), "fb.com/ringrushgame");
            _facebook.x = 30;
            _facebook.y = (_benni.y + _benni.height);
            _facebook.bgUpColor = 13685200;
            _facebook.bgDownColor = 0xC4C4C4;
            _container.addChild(_facebook);
        }
        override protected function btnClicked(e:Event):void{
            super.btnClicked(e);
            switch (e.target)
            {
                case _gvand:
                    (navigateToURL(new URLRequest("https://twitter.com/the_gvand"), "_blank"));
                    return;
                case _benni:
                    (navigateToURL(new URLRequest("https://twitter.com/black_benni"), "_blank"));
                    return;
                case _facebook:
                    (navigateToURL(new URLRequest("http://on.fb.me/1ojU9AA"), "_blank"));
                    return;
                default:
                    return;
            };
        }

    }
}//package views

