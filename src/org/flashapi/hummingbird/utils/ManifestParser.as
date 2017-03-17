// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.utils.ManifestParser

package org.flashapi.hummingbird.utils{
    import org.flashapi.hummingbird.enum.ManifestReferenceEnum;

    public class ManifestParser {

        private static var _manifestLength:int;

        public static function parse(manifest:String):ManifestInfo{
            var _local_2:ManifestInfo = new ManifestInfo();
            ManifestParser._manifestLength = manifest.length;
            ManifestParser.setInfoProperty(manifest, _local_2, ManifestReferenceEnum.MANIFEST_VERSION);
            ManifestParser.setInfoProperty(manifest, _local_2, ManifestReferenceEnum.NAME);
            ManifestParser.setInfoProperty(manifest, _local_2, ManifestReferenceEnum.SPECIFICATION_TITLE);
            ManifestParser.setInfoProperty(manifest, _local_2, ManifestReferenceEnum.SPECIFICATION_VENDOR);
            ManifestParser.setVersionProperties(manifest, _local_2);
            ManifestParser.setInfoProperty(manifest, _local_2, ManifestReferenceEnum.IMPLEMENTATION_VENDOR);
            ManifestParser.setInfoProperty(manifest, _local_2, ManifestReferenceEnum.IMPLEMENTATION_TITLE);
            ManifestParser.setInfoProperty(manifest, _local_2, ManifestReferenceEnum.IMPLEMENTATION_VERSION);
            return (_local_2);
        }
        private static function setVersionProperties(manifest:String, inf:ManifestInfo):void{
            var _local_5:String = ManifestParser.getInfoProperty(manifest, ManifestReferenceEnum.SPECIFICATION_VERSION);
            var _local_3:Array = _local_5.split(" ");
            inf.specificationVersion = _local_3[0];
            var _local_4:String = _local_3[1];
            if (_local_3.length > 2)
            {
                _local_4 = (_local_4 + (" " + _local_3[2]));
            };
            inf.specificationDate = new Date(Date.parse(_local_4));
        }
        private static function setInfoProperty(manifest:String, inf:ManifestInfo, property:ManifestReference):void{
            inf[property.manifestInfoProperty] = ManifestParser.getInfoProperty(manifest, property);
        }
        private static function getInfoProperty(manifest:String, property:ManifestReference):String{
            var _local_7:String = (property.manifestReference + ":");
            var _local_3:int = (manifest.indexOf(_local_7) + _local_7.length);
            var _local_5:String = "";
            var _local_4:String = manifest.charAt(_local_3);
            var _local_6:int = manifest.length;
            while (((!((_local_4 == "\r"))) && ((_local_3 < ManifestParser._manifestLength))))
            {
                if (((!((_local_4 == " "))) || (!((_local_5 == "")))))
                {
                    _local_5 = (_local_5 + _local_4);
                };
                _local_4 = manifest.charAt(++_local_3);
            };
            return (_local_5);
        }

    }
}//package org.flashapi.hummingbird.utils

