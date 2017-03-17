// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//controllers.IViewsController

package controllers{
    import org.flashapi.hummingbird.controller.IController;

    public /*dynamic*/ interface IViewsController extends IController {

        function init():void;
        function setView(_arg_1:uint):void;
        function viewComplete(_arg_1:uint, _arg_2:Boolean):void;
        function setPopup(_arg_1:uint):void;
        function closePopup():void;
        function popupComplete(_arg_1:uint, _arg_2:Boolean):void;
        function openRespond():void;
        function closeRespond():void;

    }
}//package controllers

