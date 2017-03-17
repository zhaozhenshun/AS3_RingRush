// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//utils.MovieclipPool

package utils{
    import starling.utils.AssetManager;

    public class MovieclipPool {

        private var _pool:Array;
        private var _counter:int = 0;
        private var _name:String;
        private var _fps:uint;
        private var _assets:AssetManager;

        public function MovieclipPool(name:String, fps:uint, assets:AssetManager){
            _assets = assets;
            _pool = [];
            _name = name;
            _fps = fps;
        }
        public function getMovieclip():MyMovieclip{
            if (_counter > 0)
            {
                return (_pool[--_counter]);
            };
            return (create());
        }
        public function returnMovieclip(mc:MyMovieclip):void{
            _pool[_counter++] = mc;
        }
        private function create():MyMovieclip{
            return (new MyMovieclip(_assets.getTextures(_name), _fps));
        }

    }
}//package utils

