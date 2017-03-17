// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//service.GameService

package service{
    import org.flashapi.hummingbird.service.AbstractService;
    import flash.net.SharedObject;
    import utils.Dictionary;
    import models.dto.AchievementItem;
    import flash.data.SQLResult;
    import events.ModelEvent;

    public class GameService extends AbstractService implements IGameService {

        [Service(alias="DatabaseService")]
        public var db:IDatabaseService = DatabaseService.GetInstance();
        protected var _sharedObject:SharedObject;
        protected var _achievements:Dictionary;
        private var _score:int = 0;
        private var _newHighscore:Boolean = false;
		private static var _instance:GameService;
		public static function GetInstance():GameService {
			
			if (_instance) {
				return _instance;
			}else {
				_instance = new  GameService();
			}
			return _instance;
		}
        public function GameService(){
            _sharedObject = SharedObject.getLocal("ringrush");
        }
        public function init():void{
            _achievements = new Dictionary();
            db.query("SELECT * FROM achievements", AchievementItem, achievementsReady);
        }
        protected function getServiceState():Boolean{
            if (_sharedObject.data.gameservice != undefined)
            {
                if (_sharedObject.data.gameservice)
                {
                    return (true);
                };
            };
            return (false);
        }
        protected function isAuthenticated():Boolean{
            return (false);
        }
        protected function check():Boolean{
            return (true);
        }
        private function achievementsReady(result:SQLResult):void{
            var _local_2 = null;
            var _local_4:int;
            var _local_3:int = result.data.length;
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_2 = result.data[_local_4];
                _achievements.setValue(_local_2.score, _local_2);
                _local_4++;
            };
            checkForAchievements();
        }
        public function checkForAchievements():void{
            var _local_4:int;
            var _local_1 = null;
            var _local_5:int;
            var _local_3:int;
            var _local_2 = null;
            var _local_6:int;
            if (_achievements != null)
            {
                _local_4 = getHighscore();
                _local_1 = _achievements.keys;
                _local_3 = _local_1.length;
                _local_6 = 0;
                while (_local_6 < _local_3)
                {
                    _local_5 = _local_1[_local_6];
                    _local_2 = _achievements.getValue(_local_5);
                    if ((((_local_4 >= _local_2.score)) && (!(_local_2.unlocked))))
                    {
                        _local_2.update = true;
                        _local_2.unlocked = true;
                    };
                    _local_6++;
                };
            };
        }
        public function getAchievements():Dictionary{
            return (_achievements);
        }
        public function postAchievements():void{
            if (getServiceState())
            {
                if (check())
                {
                    if (isAuthenticated())
                    {
                        postAchievementsHook();
                    };
                };
            };
        }
        protected function postAchievementsHook():void{
        }
        public function supported():Boolean{
            return (true);
        }
        public function clicked():void{
        }
        public function postScore(score:int):void{
            if (getServiceState())
            {
                if (check())
                {
                    if (isAuthenticated())
                    {
                        postScoreHook(score);
                    };
                };
            };
        }
        protected function postScoreHook(score:int):void{
        }
        public function getScore():int{
            return (_score);
        }
        public function setScore(score:int):void{
            _score = score;
            _newHighscore = false;
            setHighscore(_score);
        }
        public function getHighscore():int {
            if (_sharedObject.data.score == undefined)
            {
                setHighscore(0);
            };
            return (_sharedObject.data.score);
        }
        public function newHighscore():Boolean{
            return (_newHighscore);
        }
        public function setHighscore(score:int):void{
            if ((((_sharedObject.data.score < score)) || ((_sharedObject.data.score == undefined))))
            {
                _newHighscore = true;
                _sharedObject.data.score = score;
                _sharedObject.flush();
                checkForAchievements();
            };
        }
        protected function dispatchModelEvent(eventType:String):void{
            this.dispatchEvent(new ModelEvent(eventType));
        }
        public function getMessage():String{
            return ("");
        }

    }
}//package service

