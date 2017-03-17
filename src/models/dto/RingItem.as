// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//models.dto.RingItem

package models.dto{
    import __AS3__.vec.Vector;

    public class RingItem {

        public var id:uint;
        private var _speed:Number = 0;
        public var orgSpeed:Number;
        public var rotation:uint;
        public var radius:Number;
        public var color:Number;
        public var properties:String;
        public var elements:Vector.<ElementItem>;

        public function set speed(val:Number):void{
            if (val > 4)
            {
                val = 4;
            };
            if (val < -4)
            {
                val = -4;
            };
            _speed = val;
        }
        public function get speed():Number{
            return (_speed);
        }

    }
}//package models.dto

