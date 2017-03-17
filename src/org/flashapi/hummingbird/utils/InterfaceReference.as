// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.utils.InterfaceReference

package org.flashapi.hummingbird.utils{
    public class InterfaceReference {

        private static const HUMMINGBIRD_PACKAGE:String = "org.flashapi.hummingbird.";
        private static const DOUBLE_SEMICOLON:String = "::";

        private var _interfaceType:String;
        private var _interfacePackage:String;

        public function InterfaceReference(interfaceType:String, interfacePackage:String){
            this.initObj(interfaceType, interfacePackage);
        }
        public function getInterfaceType():String{
            return (_interfaceType);
        }
        public function getInterfacePackage():String{
            return (_interfacePackage);
        }
        private function initObj(interfaceType:String, interfacePackage:String):void{
            _interfaceType = interfaceType;
            _interfacePackage = ((("org.flashapi.hummingbird." + interfacePackage) + "::") + interfaceType);
        }

    }
}//package org.flashapi.hummingbird.utils

