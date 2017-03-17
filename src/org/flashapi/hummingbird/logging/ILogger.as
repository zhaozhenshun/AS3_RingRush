// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.logging.ILogger

package org.flashapi.hummingbird.logging{
    import flash.events.IEventDispatcher;

    public /*dynamic*/ interface ILogger extends IEventDispatcher {

        function config(_arg_1:String, ... _args):void;
        function fatal(_arg_1:String, ... _args):void;
        function info(_arg_1:String, ... _args):void;
        function warn(_arg_1:String, ... _args):void;
        function debug(_arg_1:String, ... _args):void;

    }
}//package org.flashapi.hummingbird.logging

