// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//utils.Dictionary

package utils{
    import flash.utils.Dictionary;

    public class Dictionary {

        private var d:flash.utils.Dictionary;
        private var _keys:Array;

        public function Dictionary(weakKeys:Boolean=false){
            d = new flash.utils.Dictionary(weakKeys);
            _keys = [];
        }
        public function get keys():Array{
            return (_keys.concat());
        }
        public function get length():int{
            return (_keys.length);
        }
        public function containsKey(key:*):Boolean{
            return (!((d[key] === undefined)));
        }
        public function setValue(key:*, value:*):void{
            if (value === undefined)
            {
                removeValue(key);
                return;
            };
            if (d[key] === undefined)
            {
                _keys.push(key);
            };
            d[key] = value;
        }
        public function getValue(key:*){
            return (d[key]);
        }
        public function removeValue(key:*):Boolean{
            var _local_2:int;
            if (d[key] !== undefined)
            {
                delete d[key];
                _local_2 = _keys.indexOf(key);
                if (_local_2 > -1)
                {
                    _keys.splice(_local_2, 1);
                };
                return (true);
            };
            return (false);
        }

    }
}//package utils

