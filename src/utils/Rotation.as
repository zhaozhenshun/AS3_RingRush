// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//utils.Rotation

package utils{
    import starling.display.DisplayObjectContainer;

    public class Rotation {

        public static function degFromRot(number:Number):Number{
            return ((((number)>=180) ? number = (number - 360) : number = (number + 360)));
        }
        public static function rotFromDeg(number:Number):Number{
            return ((((number)>180) ? number = (number - 360) : number = (number + 360)));
        }
        public static function degFromRad(number:Number):Number{
            return (((180 / 3.14159265358979) * number));
        }
        public static function radFromDeg(number:Number):Number{
            return (((3.14159265358979 / 180) * number));
        }
        public static function rotFromRad(number:Number):Number{
            return (rotFromDeg(degFromRad(number)));
        }
        public static function radFromRot(number:Number):Number{
            return (radFromDeg(degFromRot(number)));
        }
        public static function degFromSprite(sprite:DisplayObjectContainer):Number{
            return (degFromRot(degFromRad(sprite.rotation)));
        }
        public static function distance(percentage:*, radius:*):Number{
            return (((circumference(radius) / 100) * percentage));
        }
        public static function circumference(radius:*):Number{
            return (((2 * 3.14159265358979) * radius));
        }

    }
}//package utils

