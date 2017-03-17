// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//service.ILanguageService

package service{
    import org.flashapi.hummingbird.model.IModel;

    public /*dynamic*/ interface ILanguageService extends IModel {

        function setLocale(_arg_1:String):void;
        function getLocale():String;
        function translate(_arg_1:String, _arg_2:String):String;

    }
}//package service

