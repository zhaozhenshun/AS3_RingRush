// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.factory.IFactory

package org.flashapi.hummingbird.factory{
    import org.flashapi.hummingbird.view.IView;

    public /*dynamic*/ interface IFactory {

        function createView(_arg_1:Class):IView;
        function doLookup(_arg_1:Object):void;

    }
}//package org.flashapi.hummingbird.factory

