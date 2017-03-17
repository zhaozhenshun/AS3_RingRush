// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//utils.ObjectPool

package utils{
    import starling.utils.AssetManager;
    import constants.App;

    public class ObjectPool {

        private var _imagePool:Dictionary;
        private var _movieclipPool:Dictionary;
        private var _assets:AssetManager;

        public function ObjectPool(assets:AssetManager){
            _assets = assets;
            _imagePool = new Dictionary();
            _movieclipPool = new Dictionary();
        }
        private function getMovieclipPool(_arg_1:*):MovieclipPool{
            var _local_2 = null;
            var _local_3:MovieclipPool = _movieclipPool.getValue(_arg_1);
            if (_local_3 == null)
            {
                _local_2 = App.elementType(_arg_1);
                _local_3 = new MovieclipPool(_local_2.textureName, 3, _assets);
                _movieclipPool.setValue(_arg_1, _local_3);
            };
            return (_local_3);
        }
        public function getMovieclip(_arg_1:uint):MyMovieclip{
            return (getMovieclipPool(_arg_1).getMovieclip());
        }
        public function returnMovieclip(mc:MyMovieclip):void{
            getMovieclipPool(mc.type).returnMovieclip(mc);
        }
        private function getImagePool(_arg_1:*):ImagePool{
            var _local_2 = null;
            var _local_3:ImagePool = _imagePool.getValue(_arg_1);
            if (_local_3 == null)
            {
                _local_2 = App.elementType(_arg_1);
                _local_3 = new ImagePool(_local_2.textureName, _arg_1, _assets);
                _imagePool.setValue(_arg_1, _local_3);
            };
            return (_local_3);
        }
        public function getImage(_arg_1:uint):MyImage{
            return (getImagePool(_arg_1).getImage());
        }
        public function returnImage(image:MyImage):void{
            getImagePool(image.type).returnImage(image);
        }

    }
}//package utils

