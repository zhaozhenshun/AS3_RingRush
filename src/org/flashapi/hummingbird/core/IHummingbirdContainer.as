// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.core.IHummingbirdContainer

package org.flashapi.hummingbird.core{
    public /*dynamic*/ interface IHummingbirdContainer {

        function setApplicationContext(_arg_1:IApplicationContext):void;
        function clearApplicationContext(_arg_1:IApplicationContext, _arg_2:Boolean=true):void;
        function getMVCObject(_arg_1:String):IMVCObject;
        function getFlashPlayerMajorVersion():int;
        function removeMVCObject(_arg_1:String):IMVCObject;
        function hasMVCObject(_arg_1:String):Boolean;
        function doLookup(_arg_1:Object):void;

    }
}//package org.flashapi.hummingbird.core

