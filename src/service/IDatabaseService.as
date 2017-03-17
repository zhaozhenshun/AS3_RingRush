// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//service.IDatabaseService

package service{
    import org.flashapi.hummingbird.model.IModel;

    public /*dynamic*/ interface IDatabaseService extends IModel {

        function init():void;
        function query(_arg_1:String, _arg_2:Class, _arg_3:Function):void;

    }
}//package service

