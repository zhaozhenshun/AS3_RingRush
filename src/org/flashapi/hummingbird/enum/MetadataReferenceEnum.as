// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.enum.MetadataReferenceEnum

package org.flashapi.hummingbird.enum{
    import org.flashapi.hummingbird.utils.MetadataReference;

    public class MetadataReferenceEnum {

        public static const SERVICE:MetadataReference = new MetadataReference("Service", InterfaceReferenceEnum.SERVICE.getInterfacePackage());
        public static const MODEL:MetadataReference = new MetadataReference("Model", InterfaceReferenceEnum.MODEL.getInterfacePackage());
        public static const CONTROLLER:MetadataReference = new MetadataReference("Controller", InterfaceReferenceEnum.CONTROLLER.getInterfacePackage());
        public static const ORCHESTRATOR:MetadataReference = new MetadataReference("Orchestrator", InterfaceReferenceEnum.ORCHESTRATOR.getInterfacePackage());

    }
}//package org.flashapi.hummingbird.enum

