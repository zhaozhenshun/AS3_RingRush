// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.factory.Factory

package org.flashapi.hummingbird.factory{
    import org.flashapi.hummingbird.view.IView;

    public class Factory implements IFactory {

        private var _iocRef:Object;

        public function Factory(iocRef:Class){
            this.initObj(iocRef);
        }
        public function createView(ClassRef:Class):IView{
            var _local_2:IView = new (ClassRef)();
            _iocRef.getInstance().doLookup(_local_2);
            return (_local_2);
        }
        public function doLookup(obj:Object):void{
            _iocRef.getInstance().doLookup(obj);
        }
        private function initObj(iocRef:Class):void{
            _iocRef = iocRef;
        }

    }
}//package org.flashapi.hummingbird.factory

