// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//utils.MyImage

package utils{
    import starling.display.Image;
    import starling.textures.Texture;

    public class MyImage extends Image {

        private var _type:uint;

        public function MyImage(texture:Texture){
            super(texture);
        }
        public function set type(val:uint):void{
            _type = val;
        }
        public function get type():uint{
            return (_type);
        }

    }
}//package utils

