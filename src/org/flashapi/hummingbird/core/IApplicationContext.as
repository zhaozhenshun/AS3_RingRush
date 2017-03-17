// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.core.IApplicationContext

package org.flashapi.hummingbird.core{
    import flash.events.IEventDispatcher;

    public /*dynamic*/ interface IApplicationContext extends IEventDispatcher {

        function after():void;
        function before():void;
        function start():void;
        function remove():void;

    }
}//package org.flashapi.hummingbird.core

