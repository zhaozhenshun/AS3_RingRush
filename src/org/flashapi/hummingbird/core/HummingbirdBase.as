// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.core.HummingbirdBase

package org.flashapi.hummingbird.core{
    import org.flashapi.hummingbird.logging.ILogger;
    import org.flashapi.hummingbird.logging.Logger;
    import flash.display.Stage;
    import org.flashapi.hummingbird.factory.IFactory;
    import org.flashapi.hummingbird.factory.IDefinitionRegistry;
    import org.flashapi.hummingbird.factory.Factory;
    import org.flashapi.hummingbird.factory.DefinitionRegistry;

    public class HummingbirdBase {

        private static const LOGGER:ILogger = Logger.getInstance();
        private static const VERSION:HummingbirdVersion = new HummingbirdVersion();

        private static var _stage:Stage;
        private static var _factory:IFactory;
        private static var _definitionRegistry:IDefinitionRegistry;

        {
            HummingbirdBase.LOGGER.info(VERSION.toString());
        }
        public static function getLogger():ILogger{
            return (HummingbirdBase.LOGGER);
        }
        protected static function setApplicationContext(applicationContext:IApplicationContext):void{
            HummingbirdContainer.getInstance().setApplicationContext(applicationContext);
        }
        protected static function clearApplicationContext(applicationContext:IApplicationContext, disposeMvcObjects:Boolean=true):void{
            HummingbirdContainer.getInstance().clearApplicationContext(applicationContext, disposeMvcObjects);
        }
        protected static function getStage():Stage{
            return (HummingbirdBase._stage);
        }
        protected static function setStage(stage:Stage):void{
            if (stage != null)
            {
                HummingbirdBase.LOGGER.config("Stage component added");
                HummingbirdBase._stage = stage;
            };
        }
        protected static function getFactory():IFactory{
            if (_factory == null)
            {
                HummingbirdBase.LOGGER.config("Factory initialization");
                _factory = new Factory(HummingbirdContainer);
            };
            return (_factory);
        }
        protected static function getDefinitionRegistry():IDefinitionRegistry{
            if (_definitionRegistry == null)
            {
                HummingbirdBase.LOGGER.config("Definition registry initialization");
                _definitionRegistry = new DefinitionRegistry(HummingbirdContainer);
            };
            return (_definitionRegistry);
        }
        protected static function getVersion():HummingbirdVersion{
            return (HummingbirdBase.VERSION);
        }
        protected static function checkStage():void{
            if (HummingbirdBase._stage == null)
            {
                HummingbirdBase.LOGGER.warn("No instance of Stage is registered");
            };
        }
        protected static function getEventDispatcher():HummingbirdEventDispatcher{
            return (HummingbirdEventDispatcher.getInstance());
        }

    }
}//package org.flashapi.hummingbird.core

