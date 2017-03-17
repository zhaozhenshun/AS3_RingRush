// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.core.HummingbirdVersion

package org.flashapi.hummingbird.core{
    import org.flashapi.hummingbird.utils.ManifestInfo;
    import flash.utils.ByteArray;
    import org.flashapi.hummingbird.utils.ManifestParser;

    public class HummingbirdVersion {

        private static const MANIFEST:Class = _SafeStr_2;

        private var _manifestInf:ManifestInfo;

        public function HummingbirdVersion(){
            this.initObj();
        }
        public function getRelease():String{
            return (_manifestInf.specificationVersion);
        }
        public function getReleaseDate():Date{
            return (_manifestInf.specificationDate);
        }
        public function toString():String{
            return ((((("[object HummingbirdVersion: release=" + this.getRelease()) + ", date=") + this.getReleaseDate()) + "]"));
        }
        private function initObj():void{
            var _local_1:ByteArray = new MANIFEST();
            var _local_2:String = _local_1.readUTFBytes(_local_1.length);
            _manifestInf = ManifestParser.parse(_local_2);
        }

    }
}//package org.flashapi.hummingbird.core

// _SafeStr_2 = "MANIFEST_MF$32abaf4c601c30a43349f4f0ce76d907-588048686" (String#1801)


