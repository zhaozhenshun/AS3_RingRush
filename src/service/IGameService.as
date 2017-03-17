// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//service.IGameService

package service{
    import org.flashapi.hummingbird.model.IModel;
    import utils.Dictionary;

    public /*dynamic*/ interface IGameService extends IModel {

        function init():void;
        function supported():Boolean;
        function clicked():void;
        function getScore():int;
        function setScore(_arg_1:int):void;
        function getHighscore():int;
        function newHighscore():Boolean;
        function setHighscore(_arg_1:int):void;
        function getMessage():String;
        function checkForAchievements():void;
        function getAchievements():Dictionary;
        function postScore(_arg_1:int):void;
        function postAchievements():void;

    }
}//package service

