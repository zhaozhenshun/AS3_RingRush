// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//service.ISoundService

package service{
    import org.flashapi.hummingbird.model.IModel;
    import starling.utils.AssetManager;

    public /*dynamic*/ interface ISoundService extends IModel {

        function init(_arg_1:AssetManager):void;
        function playSFX(_arg_1:String, _arg_2:int=1):void;
        function stopSFX(_arg_1:String):void;
        function addSFX(_arg_1:String):void;
        function setSFXState(_arg_1:Boolean):void;
        function getSFXState():Boolean;
        function setMusicState(_arg_1:Boolean):void;
        function getMusicState():Boolean;
        function checkMusicState(_arg_1:Boolean):void;

    }
}//package service

