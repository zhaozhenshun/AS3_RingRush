// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//service.INetStatusService

package service{
    import org.flashapi.hummingbird.model.IModel;

    public /*dynamic*/ interface INetStatusService extends IModel {

        function start():void;
        function getState():Boolean;

    }
}//package service

