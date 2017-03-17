// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.core.HummingbirdContainer

package org.flashapi.hummingbird.core{
    import org.flashapi.hummingbird.logging.ILogger;
    import flash.utils.Dictionary;
    import __AS3__.vec.Vector;
    import org.flashapi.hummingbird.exceptions.SingletonException;
    import org.flashapi.hummingbird.utils.MetadataParser;
    import flash.system.Capabilities;
    import org.flashapi.hummingbird.exceptions.NoSuchDefinitionException;

    public class HummingbirdContainer implements IHummingbirdContainer {

        private static const INSTANCE:IHummingbirdContainer = new (HummingbirdContainer)();

        private var _logger:ILogger;
        private var _applicationContext:IApplicationContext;
        private var _singletonInstances:Dictionary;
        private var _singletonReferences:Dictionary;
        private var _applicationContextReferences:Vector.<IApplicationContext>;
        private var _fpMajorVersion:int;

        public function HummingbirdContainer(){
            if (INSTANCE)
            {
                throw (new SingletonException("you must use the getInstance() method to access IHummingbirdContainer instances"));
            };
            this.initObj();
        }
        public static function getInstance():IHummingbirdContainer{
            return (HummingbirdContainer.INSTANCE);
        }

        public function setApplicationContext(applicationContext:IApplicationContext):void{
            this.initApplicationContext(applicationContext);
        }
        public function clearApplicationContext(applicationContext:IApplicationContext, disposeMvcObjects:Boolean=true):void{
            this.removeApplicationContext(applicationContext, disposeMvcObjects);
        }
        public function doLookup(obj:Object):void{
            _logger.info(("Lookup start on: " + obj));
            MetadataParser.parseMetadata(obj, _singletonInstances, _singletonReferences);
        }
        public function getMVCObject(alias:String):IMVCObject{
            var _local_2:MVCReference = this.getMVCReference(alias);
            return (_local_2.mvcObject);
        }
        public function removeMVCObject(alias:String):IMVCObject{
            var _local_2:MVCReference = this.getMVCReference(alias);
            var _local_3:IMVCObject = _local_2.mvcObject;
            _local_2 = null;
            delete _singletonInstances[alias];
            return (_local_3);
        }
        public function hasMVCObject(alias:String):Boolean{
            return (((_singletonInstances[alias]) ? true : false));
        }
        public function getFlashPlayerMajorVersion():int{
            return (_fpMajorVersion);
        }
        private function initObj():void{
            _logger = HummingbirdBase.getLogger();
            _logger.config("Hummingbird container created");
            _singletonReferences = new Dictionary();
            _singletonInstances = new Dictionary();
            _applicationContextReferences = new Vector.<IApplicationContext>();
            _fpMajorVersion = parseInt(Capabilities.version.substr(4, 2));
            _logger.config(("Current Flash Player version: " + _fpMajorVersion));
        }
        private function initApplicationContext(applicationContext:IApplicationContext):void{
            _logger.config(("Application context initialization on: " + applicationContext));
            _applicationContextReferences.push(applicationContext);
            _logger.config("Application context before()");
            applicationContext.before();
            this.doLookup(applicationContext);
            _logger.config("Application context start()");
            applicationContext.start();
            _logger.config("Application context after()");
            applicationContext.after();
            _logger.config("Application context initialization complete");
        }
        private function removeApplicationContext(applicationContext:IApplicationContext, disposeMvcObjects:Boolean):void{
            _logger.config(("Application context removal on: " + applicationContext));
            _applicationContextReferences.splice(_applicationContextReferences.indexOf(applicationContext), 1);
            if (disposeMvcObjects)
            {
                this.deleteMvcObjects(applicationContext);
            };
            _logger.config("Application context remove()");
            applicationContext.remove();
            _logger.config("Application context removal complete");
        }
        private function deleteMvcObjects(applicationContext:IApplicationContext):void{
            var _local_2 = null;
            var _local_4 = null;
            _logger.config(("Deleting MVC objects on: " + applicationContext));
            for each (var _local_3:MVCReference in _singletonInstances)
            {
                if (_local_3.context == applicationContext)
                {
                    delete _singletonReferences[_local_3.typeDefinition];
                    _local_4 = _local_3.mvcObject;
                    _local_4.finalize();
                    _local_4 = null;
                    _local_2 = _local_3.alias;
                    _local_3 = null;
                    delete _singletonInstances[_local_2];
                };
            };
        }
        private function getMVCReference(alias:String):MVCReference{
            var _local_2:MVCReference = _singletonInstances[alias];
            if (_local_2 == null)
            {
                _logger.warn("The MVC with the alias alias {0} does not exist!", alias);
                throw (new NoSuchDefinitionException((("the alias '" + alias) + "' is invalid. It must not be null or empty.")));
            };
            return (_local_2);
        }

    }
}//package org.flashapi.hummingbird.core

