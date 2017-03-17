// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.factory.IDefinitionRegistry

package org.flashapi.hummingbird.factory{
    import org.flashapi.hummingbird.model.IModel;
    import org.flashapi.hummingbird.controller.IController;
    import org.flashapi.hummingbird.service.IService;
    import org.flashapi.hummingbird.orchestrator.IOrchestrator;
    import org.flashapi.hummingbird.core.IMVCObject;

    public /*dynamic*/ interface IDefinitionRegistry {

        function getModel(_arg_1:String):IModel;
        function getController(_arg_1:String):IController;
        function getService(_arg_1:String):IService;
        function getOrchestrator(_arg_1:String):IOrchestrator;
        function removeDefinition(_arg_1:String):IMVCObject;
        function hasDefinition(_arg_1:String):Boolean;

    }
}//package org.flashapi.hummingbird.factory

