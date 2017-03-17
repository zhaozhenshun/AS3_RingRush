// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.utils.ManifestInfo

package org.flashapi.hummingbird.utils{
    public class ManifestInfo {

        public var manifestVersion:String;
        public var name:String;
        public var specificationTitle:String;
        public var specificationVersion:String;
        public var specificationDate:Date;
        public var specificationVendor:String;
        public var implementationTitle:String;
        public var implementationVersion:String;
        public var implementationVendor:String;

        public function toString():String{
            return ((((((((((((((((((("[object ManifestInfo: manifestVersion=" + this.manifestVersion) + ", name=") + this.name) + ", specificationTitle=") + this.specificationTitle) + ", specificationVersion=") + this.specificationVersion) + ", specificationDate=") + this.specificationDate) + ", specificationVendor=") + this.specificationVendor) + ", implementationTitle=") + this.implementationTitle) + ", implementationVersion=") + this.implementationVersion) + ", implementationVendor=") + this.implementationVendor) + "]"));
        }

    }
}//package org.flashapi.hummingbird.utils

