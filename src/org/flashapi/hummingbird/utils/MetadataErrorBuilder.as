// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.utils.MetadataErrorBuilder

package org.flashapi.hummingbird.utils{
    import org.flashapi.hummingbird.core.HummingbirdBase;

    public class MetadataErrorBuilder {

        private var _message:String;

        public function MetadataErrorBuilder(){
            this.initObj();
        }
        public function build():String{
            HummingbirdBase.getLogger().warn("Invalid metadata found");
            return (_message);
        }
        public function expected(expected:*, before:String="", after:String=""):MetadataErrorBuilder{
            _message = (_message + ((((before + "Expected '") + expected) + "'") + after));
            return (this);
        }
        public function got(got:*, before:String="", after:String=""):MetadataErrorBuilder{
            _message = (_message + ((((before + "got '") + got) + "'") + after));
            return (this);
        }
        public function dot():MetadataErrorBuilder{
            _message = (_message + ".");
            return (this);
        }
        public function comma():MetadataErrorBuilder{
            _message = (_message + ",");
            return (this);
        }
        public function message(error:String, before:String="", after:String=""):MetadataErrorBuilder{
            _message = (_message + ((before + error) + after));
            return (this);
        }
        private function initObj():void{
            _message = "";
        }

    }
}//package org.flashapi.hummingbird.utils

