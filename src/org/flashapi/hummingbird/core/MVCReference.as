// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.core.MVCReference

package org.flashapi.hummingbird.core{
    import org.flashapi.hummingbird.utils.DtoUtil;

    public class MVCReference {

        public var context:IApplicationContext;
        public var alias:String;
        public var mvcObject:IMVCObject;
        public var typeDefinition:String;

        public function toString():String{
            return (DtoUtil.formatToString(this, "MVCReference", "alias", "context", "mvcObject", "typeDefinition"));
        }

    }
}//package org.flashapi.hummingbird.core

