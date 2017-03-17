// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.starling.StarlingID

package org.flashapi.hummingbird.starling{
    import org.flashapi.hummingbird.core.IFinalizable;
    import __AS3__.vec.Vector;
    import starling.core.Starling;

    public class StarlingID implements IFinalizable {

        private static const CHARS_MAP:Vector.<uint> = new <uint>[48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 65, 66, 67, 68, 69, 70];
        private static const CHARS_MAP_SIZE:uint = 16;
        private static const SEPARATOR:uint = 45;
        private static const TEMPLATE:Vector.<uint> = new <uint>[8, 4, 4, 4, 12];
        private static const TEMPLATE_SIZE:uint = 4;

        private static var _pseudoGUIDRef:String = "";

        private var _starling:Starling;
        private var _pseudoGUID:String;

        public function StarlingID(starling:Starling){
            this.initObj(starling);
        }
        private static function generatePseudoGUID():String{
            var _local_4:int;
            var _local_3:int;
            var _local_2:Array = [];
            var _local_5:uint;
            while (_local_5 <= 4)
            {
                _local_4 = 0;
                while (_local_4 < StarlingID.TEMPLATE[_local_5])
                {
                    _local_3 = Math.floor((Math.random() * 16));
                    _local_2.push(StarlingID.CHARS_MAP[_local_3]);
                    _local_4++;
                };
                if (_local_5 < 4)
                {
                    _local_2.push(45);
                };
                _local_5++;
            };
            var _local_1:String = String.fromCharCode.apply(null, _local_2);
            if (StarlingID._pseudoGUIDRef.indexOf(_local_1) == -1)
            {
                StarlingID._pseudoGUIDRef = (StarlingID._pseudoGUIDRef + _local_1);
            }
            else
            {
                _local_1 = StarlingID.generatePseudoGUID();
            };
            return (_local_1);
        }

        public function getStarling():Starling{
            return (_starling);
        }
        public function getGUID():String{
            return (_pseudoGUID);
        }
        public function finalize():void{
            _starling = null;
            _pseudoGUID = null;
        }
        public function toString():String{
            return ((((("[object StarlingID: starling=" + _starling) + ", guid=") + _pseudoGUID) + "]"));
        }
        private function initObj(starling:Starling):void{
            _starling = starling;
            _pseudoGUID = StarlingID.generatePseudoGUID();
        }

    }
}//package org.flashapi.hummingbird.starling

