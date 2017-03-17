// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//service.SoundService

package service{
    import org.flashapi.hummingbird.service.AbstractService;
    import starling.utils.AssetManager;
    import utils.SoundManager;
    import flash.net.SharedObject;

    [Qualifier(alias="SoundService")]
    public class SoundService extends AbstractService implements ISoundService {

        private var _assets:AssetManager;
        private var sfx:SoundManager;
        private var music:SoundManager;
        private var _sharedObject:SharedObject;

        public function SoundService(){
            _sharedObject = SharedObject.getLocal("ringrush");
        }
		private static var _instance:SoundService;
		public static function GetInstance():SoundService {
			if (!_instance) {
				_instance = new SoundService();
			}
			return _instance;
		}
        public function init(assets:AssetManager):void{
            _assets = assets;
            sfx = new SoundManager();
            music = new SoundManager();
            music.addSound("music", _assets.getSound("music"));
            checkMusicState(getMusicState());
        }
        public function addSFX(name:String):void{
            sfx.addSound(name, _assets.getSound(name));
        }
        public function playSFX(id:String, repeat:int=1):void{
            if (getSFXState())
            {
                //sfx.playSound(id, 1, repeat);
            };
        }
        public function stopSFX(id:String):void{
            sfx.stopSound(id);
        }
        public function setSFXState(state:Boolean):void{
            _sharedObject.data.sfx = state;
            _sharedObject.flush();
        }
        public function getSFXState():Boolean{
            if (_sharedObject.data.sfx == undefined)
            {
                setSFXState(true);
            };
            return (_sharedObject.data.sfx);
        }
        public function setMusicState(state:Boolean):void{
            checkMusicState(state);
            _sharedObject.data.music = state;
            _sharedObject.flush();
        }
        public function checkMusicState(state:Boolean):void{
            //music.stopSound("music");
            if (state)
            {
                //music.playSound("music", 1, 999);
            };
        }
        public function getMusicState():Boolean{
            if (_sharedObject.data.music == undefined)
            {
                setMusicState(true);
            };
            return (_sharedObject.data.music);
        }

    }
}//package service

