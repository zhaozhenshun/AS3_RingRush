// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.utils.DtoUtil

package org.flashapi.hummingbird.utils{
    public class DtoUtil {

        public static function formatToString(dto:Object, className:String, ... _args):String{
            var _local_5 = null;
            var _local_4:String = (("[dto " + className) + ":");
            var _local_6:int = (_args.length - 1);
            while (_local_6 >= 0)
            {
                _local_5 = _args[_local_6];
                _local_4 = (_local_4 + (((" " + _local_5) + "=") + dto[_local_5]));
                if (_local_6 > 0)
                {
                    _local_4 = (_local_4 + ",");
                };
                _local_6--;
            };
            _local_4 = (_local_4 + "]");
            return (_local_4);
        }

    }
}//package org.flashapi.hummingbird.utils

