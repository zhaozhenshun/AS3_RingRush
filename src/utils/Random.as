// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//utils.Random

package utils{
    import flash.geom.Point;

    public class Random {

        public static function getPoint(hMax:Number, vMax:Number):Point{
            return (new Point(getInteger(0, hMax), getInteger(0, vMax)));
        }
        public static function getInteger(min:*, max:*):Number{
            return ((min + Math.floor((Math.random() * ((max + 1) - min)))));
        }

    }
}//package utils

