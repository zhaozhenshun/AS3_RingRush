// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//controllers.ViewsController

package controllers{
	import models.AppModel;
    import org.flashapi.hummingbird.controller.AbstractController;
    import models.IAppModel;
    import service.IPurchaseService;
    import service.IGameService;
    import views.IGameView;
    import starling.animation.Tween;
    import views.StarFieldView;
    import org.flashapi.hummingbird.Hummingbird;
    import starling.core.Starling;
    import events.ModelEvent;
    import views.TitleView;
    import views.InGameView;
    import views.InfoPopup;
    import views.SettingsPopup;
    import views.PurchasePopup;
    import views.AdPopup;
    import views.RespondView;

    [Qualifier(alias="ViewsController")]
    public final class ViewsController extends AbstractController implements IViewsController {

        [Model(alias="AppModel")]
        public var model:IAppModel = AppModel.GetInstance();
        [Model(alias="PurchaseService")]
        public var purchaseService:IPurchaseService;
        [Model(alias="GameService")]
        public var gameService:IGameService;
        private var _currentView:IGameView;
        private var _lastView:IGameView;
        private var _titleView:IGameView;
        private var _inGameView:IGameView;
        private var _starField:IGameView;
        private var _starFieldTween:Tween;
        private var _currentPopup:IGameView;
        private var _lastPopup:IGameView;
        private var _infoPopup:IGameView;
        private var _settingsPopup:IGameView;
        private var _purchasePopup:IGameView;
        private var _adPopup:IGameView;
        private var _respondView:IGameView;
		
		private static var _instance:ViewsController;
		public function  ViewsController() {
			
		}
		public static function GetInstance():ViewsController {
			if (!_instance) _instance = new ViewsController();
			return _instance;
		}
        public function init():void{
            model.addEventListener("showPopup", setPopupHandler);
            //purchaseService.addEventListener("purchaseStart", openRespondHandler);
            //purchaseService.addEventListener("purchaseCancel", closeRespondHandler);
            _starField = this.createView(StarFieldView);
            _starFieldTween = new Tween(_starField, 1.5, "easeOut");
            Hummingbird.addToScene(_starField);
            _currentView = this.titleView();
            Hummingbird.addToScene(_currentView);
            _currentView.active(true);
        }
        private function starState(state:*):void{
            var _local_2:Number = ((state) ? -(250) : 0);
            Starling.juggler.remove(_starFieldTween);
            _starFieldTween.reset(_starField, 1.5, "easeOut");
            _starFieldTween.moveTo(0, _local_2);
            Starling.juggler.add(_starFieldTween);
        }
        public function setView(id:uint):void{
            if (_currentView)
            {
                _lastView = _currentView;
            };
            switch (id)
            {
                case 0:
                    _currentView = this.titleView();
                    starState(false);
                    break;
                case 1:
                    _currentView = this.inGameView();
                    starState(true);
                default:
            };
            if (_lastView)
            {
                _lastView.active(false);
            };
        }
        private function setPopupHandler(e:ModelEvent):void{
            setPopup(model.getPopupId());
        }
        public function setPopup(id:uint):void{
            this.closePopup();
            switch (id)
            {
                case 0:
                    _currentPopup = this.infoPopup();
                    break;
                case 1:
                    _currentPopup = this.settingsPopup();
                    break;
                case 2:
                    _currentPopup = this.purchasePopup();
                    break;
                case 3:
                    _currentPopup = this.adPopup();
                default:
            };
            Hummingbird.addToScene(_currentPopup);
            _currentPopup.active(true);
        }
        public function closePopup():void{
            if (_currentPopup != null)
            {
                _lastPopup = _currentPopup;
                _lastPopup.active(false);
                _currentPopup = null;
            };
        }
        public function popupComplete(id:uint, state:Boolean):void{
            if (!state)
            {
                Hummingbird.removeFromScene(_lastPopup);
                _lastPopup = null;
            };
        }
        public function viewComplete(id:uint, state:Boolean):void{
            switch (id)
            {
                case 0:
                    if (!state)
                    {
                        Hummingbird.removeFromScene(_titleView);
                        Hummingbird.addToSceneAt(_currentView, 0);
                        Hummingbird.addToSceneAt(_starField, 0);
                        _currentView.active(true);
                    };
                    return;
                case 1:
                    if (!state)
                    {
                        Hummingbird.removeFromScene(_inGameView);
                        Hummingbird.addToScene(_currentView);
                        Hummingbird.addToSceneAt(_starField, 0);
                        _currentView.active(true);
                    };
                default:
            };
        }
        private function titleView():IGameView{
            if (_titleView == null)
            {
                _titleView = this.createView(TitleView);
            };
            return (_titleView);
        }
        private function inGameView():IGameView{
            if (_inGameView == null)
            {
                _inGameView = this.createView(InGameView);
            };
            return (_inGameView);
        }
        private function infoPopup():IGameView{
            if (_infoPopup == null)
            {
                _infoPopup = this.createView(InfoPopup);
            };
            return (_infoPopup);
        }
        private function settingsPopup():IGameView{
            if (_settingsPopup == null)
            {
                _settingsPopup = this.createView(SettingsPopup);
            };
            return (_settingsPopup);
        }
        private function purchasePopup():IGameView{
            if (_purchasePopup == null)
            {
                _purchasePopup = this.createView(PurchasePopup);
            };
            return (_purchasePopup);
        }
        private function adPopup():IGameView{
            if (_adPopup == null)
            {
                _adPopup = this.createView(AdPopup);
            };
            return (_adPopup);
        }
        private function openRespondHandler(e:ModelEvent):void{
            openRespond();
        }
        private function closeRespondHandler(e:ModelEvent):void{
            closeRespond();
        }
        public function openRespond():void{
            respondView();
            _respondView.active(true);
            Hummingbird.addToScene(_respondView);
        }
        public function closeRespond():void{
            _respondView.active(false);
            Hummingbird.removeFromScene(_respondView);
        }
        private function respondView():IGameView{
            if (_respondView == null)
            {
                _respondView = this.createView(RespondView);
            };
            return (_respondView);
        }
        private function createView(ViewRef:Class):IGameView{
            return ((Hummingbird.getFactory().createView(ViewRef) as IGameView));
        }

    }
}//package controllers

