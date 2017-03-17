// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//utils.ImagePool

package utils{
    import starling.utils.AssetManager;

    public class ImagePool {

        private var _pool:Array;
        private var _counter:int = 0;
        private var _name:String;
        private var _type:uint;
        private var _assets:AssetManager;

        public function ImagePool(_arg_1:String, _arg_2:uint, _arg_3:*){
            _assets = _arg_3;
            _pool = [];
            _name = _arg_1;
            _type = _arg_2;
        }
        public function getImage():MyImage{
            if (_counter > 0)
            {
                return (_pool[--_counter]);
            };
            return (create());
        }
        public function returnImage(image:MyImage):void{
            _pool[_counter++] = image;
        }
        private function create():MyImage{
            return (new MyImage(_assets.getTexture(_name)));
        }

    }
}//package utils

