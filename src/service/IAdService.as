// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//service.IAdService

package service{
    import org.flashapi.hummingbird.model.IModel;

    public /*dynamic*/ interface IAdService extends IModel {

        function state(_arg_1:Boolean):void;
        function showPendingInterstitial():Boolean;
        function supported():Boolean;

    }
}//package service

