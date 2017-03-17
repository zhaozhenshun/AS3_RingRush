// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//views.AdPopup

package views{
	import controllers.AppController;
    import controllers.IAppController;
    import starling.events.Event;

    public class AdPopup extends PurchasePopup {

        [Controller(alias="AppController")]
        public var appController:IAppController = AppController.GetInstance();

        override protected function drawScreen():void{
            super.drawScreen();
            _info.text = languageService.translate("AD_INFO", "SUPPORT US AND REMOVE ADVERTISING!");
            _info.redraw();
        }
        override protected function btnClicked(e:Event):void{
            if (e.target == _purchaseBtn)
            {
                purchaseService.purchase();
            };
            viewsController.closePopup();
            appController.removeAd();
        }

    }
}//package views

