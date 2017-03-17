package utils{
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.media.SoundTransform;
    import flash.events.Event;
    import starling.core.Starling;

    public class SoundManager {

        private static var _instance:SoundManager;

        private var _isMuted:Boolean = false;
        public var sounds:Dictionary;
        public var currPlayingSounds:Dictionary;

        public function SoundManager(){
            sounds = new Dictionary();
            currPlayingSounds = new Dictionary();
        }
        public function dispose():void{
            sounds = null;
            currPlayingSounds = null;
        }
        public function addSound(id:String, sound:Sound):void{
            sounds[id] = sound;
        }
        public function removeSound(id:String):void{
            if (soundIsAdded(id))
            {
                delete sounds[id];
                if (soundIsPlaying(id))
                {
                    delete currPlayingSounds[id];
                };
            }
            else
            {
                throw (Error("The sound you are trying to remove is not in the sound manager"));
            };
        }
        public function soundIsAdded(id:String):Boolean{
            return (sounds[id]);
        }
        public function soundIsPlaying(id:String):Boolean{
            for (var _local_2:String in currPlayingSounds)
            {
                if (_local_2 == id)
                {
                    return (true);
                };
            };
            return (false);
        }
        public function playSound(id:String, volume:Number=1, repetitions:int=1, panning:Number=0):void{
            var _local_7 = null;
            var _local_8 = null;
            var _local_5:Number;
            var _local_6 = null;
            if (soundIsAdded(id))
            {
                _local_7 = sounds[id];
                _local_8 = new SoundChannel();
                _local_8 = _local_7.play(0, repetitions);
                if (!_local_8)
                {
                    return;
                };
                _local_8.addEventListener("soundComplete", removeSoundFromDictionary);
                _local_5 = ((_isMuted) ? 0 : volume);
                _local_6 = new SoundTransform(_local_5, panning);
                _local_8.soundTransform = _local_6;
                currPlayingSounds[id] = {
                    "channel":_local_8,
                    "sound":_local_7,
                    "volume":volume
                };
            }
            else
            {
                throw (Error((("The sound you are trying to play (" + id) + ") is not in the Sound Manager. Try adding it to the Sound Manager first.")));
            };
        }
        private function removeSoundFromDictionary(e:Event):void{
            for (var _local_2:String in currPlayingSounds)
            {
                if (currPlayingSounds[_local_2].channel == e.target)
                {
                    delete currPlayingSounds[_local_2];
                };
            };
            e.currentTarget.removeEventListener("soundComplete", removeSoundFromDictionary);
        }
        public function stopSound(id:String):void{
            if (soundIsPlaying(id))
            {
                SoundChannel(currPlayingSounds[id].channel).stop();
                delete currPlayingSounds[id];
            };
        }
        public function stopAllSounds():void{
            for (var _local_1:String in currPlayingSounds)
            {
                stopSound(_local_1);
            };
        }
        public function setVolume(id:String, volume:Number):void{
            var _local_3 = null;
            if (soundIsPlaying(id))
            {
                _local_3 = new SoundTransform(volume);
                SoundChannel(currPlayingSounds[id].channel).soundTransform = _local_3;
                currPlayingSounds[id].volume = volume;
            }
            else
            {
                throw (Error((("This sound (id = " + id) + " ) is not currently playing")));
            };
        }
        public function tweenVolume(id:String, volume:Number=0, tweenDuration:Number=2):void{
            id = id;
            volume = volume;
            tweenDuration = tweenDuration;
            if (soundIsPlaying(id))
            {
                var s:SoundTransform = new SoundTransform();
                var soundObject:Object = currPlayingSounds[id];
                var c:SoundChannel = currPlayingSounds[id].channel;
                Starling.juggler.tween(soundObject, tweenDuration, {
                    "volume":volume,
                    "onUpdate":function ():void{
                        if (!_isMuted)
                        {
                            s.volume = soundObject.volume;
                            c.soundTransform = s;
                        };
                    }
                });
            }
            else
            {
                throw (Error((("This sound (id = " + id) + " ) is not currently playing")));
            };
        }
        public function crossFade(fadeOutId:String, fadeInId:String, tweenDuration:Number=2, fadeInVolume:Number=1, fadeInRepetitions:int=1):void{
            if (!soundIsPlaying(fadeInId))
            {
                playSound(fadeInId, 0, fadeInRepetitions);
            };
            tweenVolume(fadeOutId, 0, tweenDuration);
            tweenVolume(fadeInId, fadeInVolume, tweenDuration);
            if (soundIsPlaying(fadeOutId))
            {
                Starling.juggler.delayCall(stopSound, tweenDuration, fadeOutId);
            };
        }
        public function setGlobalVolume(volume:Number):void{
            var _local_3 = null;
            for (var _local_2:String in currPlayingSounds)
            {
                _local_3 = new SoundTransform(volume);
                SoundChannel(currPlayingSounds[_local_2].channel).soundTransform = _local_3;
                currPlayingSounds[_local_2].volume = volume;
            };
        }
        public function muteAll(mute:Boolean=true):void{
            var _local_3 = null;
            if (mute != _isMuted)
            {
                for (var _local_2:String in currPlayingSounds)
                {
                    _local_3 = new SoundTransform(((mute) ? 0 : currPlayingSounds[_local_2].volume));
                    SoundChannel(currPlayingSounds[_local_2].channel).soundTransform = _local_3;
                };
                _isMuted = mute;
            };
        }
        public function getSoundChannel(id:String):SoundChannel{
            if (soundIsPlaying(id))
            {
                return (SoundChannel(currPlayingSounds[id].channel));
            };
            throw (Error("You are trying to get a non-existent soundChannel. Play the sound first in order to assign a channel."));
        }
        public function getSoundTransform(id:String):SoundTransform{
            if (soundIsPlaying(id))
            {
                return (SoundChannel(currPlayingSounds[id].channel).soundTransform);
            };
            throw (Error("You are trying to get a non-existent soundTransform. Play the sound first in order to assign a transform."));
        }
        public function getSoundVolume(id:String):Number{
            if (soundIsPlaying(id))
            {
                return (currPlayingSounds[id].volume);
            };
            throw (Error("You are trying to get a non-existent volume. Play the sound first in order to assign a volume."));
        }
        public function get isMuted():Boolean{
            return (_isMuted);
        }

    }
}//package utils

