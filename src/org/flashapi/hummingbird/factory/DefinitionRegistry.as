// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.factory.DefinitionRegistry

package org.flashapi.hummingbird.factory{
    import org.flashapi.hummingbird.core.IMVCObject;
    import org.flashapi.hummingbird.model.IModel;
    import org.flashapi.hummingbird.enum.InterfaceReferenceEnum;
    import org.flashapi.hummingbird.controller.IController;
    import org.flashapi.hummingbird.service.IService;
    import org.flashapi.hummingbird.orchestrator.IOrchestrator;
    import org.flashapi.hummingbird.exceptions.InvalidTypeException;

    public class DefinitionRegistry implements IDefinitionRegistry {

        private var _iocRef:Object;

        public function DefinitionRegistry(iocRef:Class){
            this.initObj(iocRef);
        }
        public function getModel(alias:String):IModel{
            var _local_2:IMVCObject = _iocRef.getInstance().getMVCObject(alias);
            this.checkType(alias, _local_2, IModel, InterfaceReferenceEnum.MODEL.getInterfacePackage());
            return ((_local_2 as IModel));
        }
        public function getController(alias:String):IController{
            var _local_2:IMVCObject = _iocRef.getInstance().getMVCObject(alias);
            this.checkType(alias, _local_2, IController, InterfaceReferenceEnum.CONTROLLER.getInterfacePackage());
            return ((_local_2 as IController));
        }
        public function getService(alias:String):IService{
            var _local_2:IMVCObject = _iocRef.getInstance().getMVCObject(alias);
            this.checkType(alias, _local_2, IService, InterfaceReferenceEnum.SERVICE.getInterfacePackage());
            return ((_local_2 as IService));
        }
        public function getOrchestrator(alias:String):IOrchestrator{
            var _local_2:IMVCObject = _iocRef.getInstance().getMVCObject(alias);
            this.checkType(alias, _local_2, IOrchestrator, InterfaceReferenceEnum.CONTROLLER.getInterfacePackage());
            return ((_local_2 as IOrchestrator));
        }
        public function removeDefinition(alias:String):IMVCObject{
            return (_iocRef.getInstance().removeMVCObject(alias));
        }
        public function hasDefinition(alias:String):Boolean{
            return (_iocRef.getInstance().hasMVCObject(alias));
        }
        private function initObj(iocRef:Class):void{
            _iocRef = iocRef;
        }
        private function checkType(alias:String, obj:IMVCObject, expectedType:Class, expectedInterfaceRef:String):void{
            var _local_5 = null;
            if ((obj is expectedType) == false)
            {
                _local_5 = ((("Implicit coercion of a value for the alias " + alias) + " to a possibly unrelated type ") + expectedInterfaceRef);
                throw (new InvalidTypeException(_local_5));
            };
        }

    }
}//package org.flashapi.hummingbird.factory

