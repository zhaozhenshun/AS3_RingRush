// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//models.IAppModel

package models{
    import org.flashapi.hummingbird.model.IModel;
    import models.dto.LevelItem;
    import models.dto.RingItem;
    import ui.display.Player;
    import ui.display.Ring;
    import utils.Dictionary;
    import models.dto.ElementItem;
    import starling.utils.AssetManager;

    public /*dynamic*/ interface IAppModel extends IModel {

        function getElapsedTime():Number;
        function setElapsedTime(_arg_1:Number):void;
        function getState():uint;
        function setState(_arg_1:uint):void;
        function setIndex(_arg_1:uint):void;
        function getIndex():uint;
        function setLevel(_arg_1:LevelItem):void;
        function getLevel():LevelItem;
        function setCurrentRingItem(_arg_1:RingItem):void;
        function getCurrentRingItem():RingItem;
        function addPlayer(_arg_1:Player):void;
        function getPlayer():Player;
        function getPlayerState():uint;
        function setPlayerState(_arg_1:uint):void;
        function addRing(_arg_1:Ring):void;
        function getRings():Dictionary;
        function getRingByID(_arg_1:uint):Ring;
        function addRingItem(_arg_1:RingItem):void;
        function getRingItems():Dictionary;
        function getRingItemByID(_arg_1:uint):RingItem;
        function setCurrentElementItem(_arg_1:ElementItem):void;
        function getCurrentElementItem():ElementItem;
        function setAdIndex(_arg_1:uint):void;
        function getAdIndex():uint;
        function setPopupId(_arg_1:uint):void;
        function getPopupId():uint;
        function setAssets(_arg_1:AssetManager):void;
        function getAssets():AssetManager;

    }
}//package models

