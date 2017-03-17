// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//service.IPurchaseService

package service{
    import org.flashapi.hummingbird.model.IModel;

    public /*dynamic*/ interface IPurchaseService extends IModel {

        function init():void;
        function setAdState(_arg_1:Boolean):void;
        function getAdState():Boolean;
        function supported():Boolean;
        function getProductPrice():String;
        function getFailMessage():String;
        function purchase():void;
        function restore():void;
        function getMessage():String;

    }
}//package service

