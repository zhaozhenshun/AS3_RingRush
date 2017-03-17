// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.utils.MetadataReference

package org.flashapi.hummingbird.utils{
    public class MetadataReference {

        private var _interfaceReference:String;
        private var _metadataReference:String;

        public function MetadataReference(metadataReference:String, interfaceReference:String){
            this.initObj(metadataReference, interfaceReference);
        }
        public function get metadataReference():String{
            return (_metadataReference);
        }
        public function get interfaceReference():String{
            return (_interfaceReference);
        }
        private function initObj(metadataReference:String, interfaceReference:String):void{
            _metadataReference = metadataReference;
            _interfaceReference = interfaceReference;
        }

    }
}//package org.flashapi.hummingbird.utils

