// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.utils.ManifestReference

package org.flashapi.hummingbird.utils{
    public class ManifestReference {

        private var _manifestReference:String;
        private var _manifestInfoProperty:String;

        public function ManifestReference(manifestReference:String, manifestInfoProperty:String){
            this.initObj(manifestReference, manifestInfoProperty);
        }
        public function get manifestReference():String{
            return (_manifestReference);
        }
        public function get manifestInfoProperty():String{
            return (_manifestInfoProperty);
        }
        private function initObj(manifestReference:String, manifestInfoProperty:String):void{
            _manifestReference = manifestReference;
            _manifestInfoProperty = manifestInfoProperty;
        }

    }
}//package org.flashapi.hummingbird.utils

