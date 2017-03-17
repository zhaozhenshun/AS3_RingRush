// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.enum.InterfaceReferenceEnum

package org.flashapi.hummingbird.enum{
    import org.flashapi.hummingbird.utils.InterfaceReference;

    public class InterfaceReferenceEnum {

        public static const SERVICE:InterfaceReference = new InterfaceReference("IService", "service");
        public static const MODEL:InterfaceReference = new InterfaceReference("IModel", "service");
        public static const CONTROLLER:InterfaceReference = new InterfaceReference("IController", "controller");
        public static const ORCHESTRATOR:InterfaceReference = new InterfaceReference("IOrchestrator", "orchestrator");
        public static const VIEW:InterfaceReference = new InterfaceReference("IView", "view");
        public static const STARLING_VIEW:InterfaceReference = new InterfaceReference("IStarlingView", "view");
        public static const APPLICATION_CONTEXT:InterfaceReference = new InterfaceReference("IApplicationContext", "core");

    }
}//package org.flashapi.hummingbird.enum

