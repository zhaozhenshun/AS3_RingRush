// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//models.AppModel

package models{
    import org.flashapi.hummingbird.model.AbstractModel;
    import models.dto.LevelItem;
    import utils.Dictionary;
    import models.dto.RingItem;
    import ui.display.Player;
    import models.dto.PlayerItem;
    import flash.net.SharedObject;
    import models.dto.ElementItem;
    import starling.utils.AssetManager;
    import ui.display.Ring;
    import events.ModelEvent;

    [Qualifier(alias="AppModel")]
    public class AppModel extends AbstractModel implements IAppModel {

        private var _state:uint;
        private var _score:int = 0;
        private var _newHighscore:Boolean = false;
        private var _elapsedTime:Number;
        private var _level:LevelItem = null;
        private var _rings:Dictionary;
        private var _ringItems:Dictionary;
        private var _ringCount:uint;
        private var _index:uint = 0;
        private var _ringIndex:uint = 0;
        private var _adIndex:uint = 0;
        private var _currentRing:RingItem;
        private var _player:Player;
        private var _playerItem:PlayerItem;
        private var _playerState:uint;
        private var _sharedObject:SharedObject;
        private var _currentElement:ElementItem;
        private var _adState:Boolean = true;
        private var _locale:String;
        private var _popupId:uint;
        private var _assets:AssetManager;

        public function AppModel(){
            _rings = new Dictionary();
            _ringItems = new Dictionary();
            super();
            _sharedObject = SharedObject.getLocal("ringrush");
        }
		private static var _instance:AppModel;
		public static function GetInstance():AppModel {
			
			if (_instance) {
				return _instance;
			}else {
				_instance = new  AppModel();
			}
			return _instance;
		}
        public function setLevel(level:LevelItem):void{
            _level = level;
        }
        public function getLevel():LevelItem{
            return (_level);
        }
        public function addRing(ring:Ring):void{
            if (ring.hasOwnProperty("id"))
            {
                _rings.setValue(ring.id, ring);
            };
        }
        public function getRings():Dictionary{
            return (_rings);
        }
        public function getRingByID(id:uint):Ring{
            return (_rings.getValue(id));
        }
        public function setIndex(val:uint):void{
            _index = val;
        }
        public function getIndex():uint{
            return (_index);
        }
        public function addRingItem(item:RingItem):void{
            if (item.hasOwnProperty("id"))
            {
                _ringItems.setValue(item.id, item);
            };
        }
        public function getRingItemByID(id:uint):RingItem{
            return (_ringItems.getValue(id));
        }
        public function getRingItems():Dictionary{
            return (_ringItems);
        }
        public function setCurrentRingItem(item:RingItem):void{
            _currentRing = item;
        }
        public function getCurrentRingItem():RingItem{
            return (_currentRing);
        }
        public function getElementByID(id:uint):ElementItem{
            return (_ringItems.getValue(id));
        }
        public function setCurrentElementItem(item:ElementItem):void{
            _currentElement = item;
        }
        public function getCurrentElementItem():ElementItem{
            return (_currentElement);
        }
        public function addPlayer(player:Player):void{
            _player = player;
        }
        public function getPlayer():Player{
            return (_player);
        }
        public function getState():uint{
            return (_state);
        }
        public function setState(state:uint):void{
            _state = state;
            this.dispatchModelEvent("stateChange");
        }
        public function getPlayerState():uint{
            return (_playerState);
        }
        public function setPlayerState(state:uint):void{
            _playerState = state;
            this.dispatchModelEvent("playerStateChange");
        }
        public function getElapsedTime():Number{
            return (_elapsedTime);
        }
        public function setElapsedTime(elapsedTime:Number):void{
            _elapsedTime = elapsedTime;
        }
        public function setAdIndex(val:uint):void{
            _adIndex = val;
        }
        public function getAdIndex():uint{
            return (_adIndex);
        }
        public function setPopupId(id:uint):void{
            _popupId = id;
            this.dispatchModelEvent("showPopup");
        }
        public function getPopupId():uint{
            return (_popupId);
        }
        private function dispatchModelEvent(eventType:String):void{
            this.dispatchEvent(new ModelEvent(eventType));
        }
        public function setAssets(assets:AssetManager):void{
            _assets = assets;
			
        }
        public function getAssets():AssetManager{
            return (_assets);
        }

    }
}//package models

