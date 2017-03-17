// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//utils.MyMovieclip

package utils{
    import starling.display.MovieClip;
    import __AS3__.vec.Vector;
    import starling.textures.Texture;

    public class MyMovieclip extends MovieClip {

        private var _type:uint;

        public function MyMovieclip(textures:Vector.<Texture>, fps:Number=12){
            super(textures, fps);
        }
        public function set type(val:uint):void{
            _type = val;
        }
        public function get type():uint{
            return (_type);
        }

    }
}//package utils

