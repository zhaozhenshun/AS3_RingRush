// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.Hummingbird

package org.flashapi.hummingbird{
    import org.flashapi.hummingbird.core.HummingbirdBase;
    import flash.utils.Dictionary;
    import __AS3__.vec.Vector;
    import org.flashapi.hummingbird.starling.core.StarlingContextMapDto;
    import org.flashapi.hummingbird.logging.ILogger;
    import org.flashapi.hummingbird.core.IApplicationContext;
    import flash.display.Stage;
    import org.flashapi.hummingbird.starling.StarlingProperties;
    import org.flashapi.hummingbird.starling.StarlingID;
    import starling.display.DisplayObject;
    import org.flashapi.hummingbird.view.IView;
    import org.flashapi.hummingbird.factory.IFactory;
    import org.flashapi.hummingbird.factory.IDefinitionRegistry;
    import starling.core.Starling;
    import org.flashapi.hummingbird.core.HummingbirdVersion;
    import org.flashapi.hummingbird.core.HummingbirdEventDispatcher;
    import org.flashapi.hummingbird.utils.MetadataParser;
    import org.flashapi.hummingbird.events.StarlingDependencyEvent;
    import org.flashapi.hummingbird.view.RootDisplayObject;
    import org.flashapi.hummingbird.events.StarlingContextEvent;
    import starling.events.Event;
    import org.flashapi.hummingbird.starling.core.StarlingMapDto;
    import org.flashapi.hummingbird.exceptions.StarlingIDException;

    public class Hummingbird extends HummingbirdBase {

        private static var _starlingMap:Dictionary = new Dictionary();
        private static var _contextCollection:Vector.<StarlingContextMapDto> = new Vector.<StarlingContextMapDto>();
        private static var _initialStarlingGUID:String;

        public static function getLogger():ILogger{
            return (HummingbirdBase.getLogger());
        }
        public static function setApplicationContext(applicationContext:IApplicationContext, stage:Stage=null, properties:StarlingProperties=null):StarlingID{
            return (Hummingbird.initStarling(applicationContext, properties, stage));
        }
        public static function clearApplicationContext(applicationContext:IApplicationContext, disposeMvcObjects:Boolean=true):void{
            HummingbirdBase.clearApplicationContext(applicationContext, disposeMvcObjects);
        }
        public static function addToScene(view:IView, starlingID:StarlingID=null):void{
            Hummingbird.getRootClass(starlingID).addChild(DisplayObject(view));
        }
        public static function addToSceneAt(view:IView, index:Number=0, starlingID:StarlingID=null):void{
            Hummingbird.getRootClass(starlingID).addChildAt(DisplayObject(view), index);
        }
        public static function removeFromScene(view:IView, starlingID:StarlingID=null):void{
            Hummingbird.getRootClass(starlingID).removeChild(DisplayObject(view));
        }
        public static function sceneContains(view:IView, starlingID:StarlingID=null):Boolean{
            return (Hummingbird.getRootClass(starlingID).contains(DisplayObject(view)));
        }
        public static function clearScene(starlingID:StarlingID=null):void{
            Hummingbird.getRootClass(starlingID).removeChildren();
        }
        public static function getStage(starlingID:StarlingID=null):Stage{
            var _local_2:String = Hummingbird.getGUID(starlingID);
            return (Hummingbird.getStarlingMapDto(_local_2).stage);
        }
        public static function getFactory():IFactory{
            return (HummingbirdBase.getFactory());
        }
        public static function getDefinitionRegistry():IDefinitionRegistry{
            return (HummingbirdBase.getDefinitionRegistry());
        }
        public static function getStarling(starlingID:StarlingID=null):Starling{
            var _local_2:String = Hummingbird.getGUID(starlingID);
            return (Hummingbird.getStarlingID(_local_2).getStarling());
        }
        public static function removeStarling(starlingID:StarlingID):Starling{
            return (Hummingbird.deleteStarlingReference(starlingID));
        }
        public static function getVersion():HummingbirdVersion{
            return (HummingbirdBase.getVersion());
        }
        public static function getEventDispatcher():HummingbirdEventDispatcher{
            return (HummingbirdBase.getEventDispatcher());
        }
        private static function initStarling(applicationContext:IApplicationContext, properties:StarlingProperties, stage:Stage):StarlingID{
            var _local_7 = null;
            var _local_5 = null;
            var _local_8:Boolean;
            var _local_4 = null;
            var _local_6:ILogger = HummingbirdBase.getLogger();
            MetadataParser.setStarlingEventRef(StarlingDependencyEvent);
            if (stage != null)
            {
                _local_6.config("Starling framework initialization");
                _local_8 = (Hummingbird._initialStarlingGUID == null);
                if (properties)
                {
                    _local_6.config("Starling framework instanciation");
                    if (_local_8)
                    {
                        Starling.handleLostContext = properties.handleLostContext;
                        Starling.multitouchEnabled = properties.multitouchEnabled;
                    };
                    _local_5 = new Starling(RootDisplayObject, stage, properties.viewPort, properties.stage3D, properties.renderMode, properties.profile);
                    Hummingbird._contextCollection.push(Hummingbird.createStarlingContextMapDto(_local_5, applicationContext));
                    _local_6.config("Starling properties initialization");
                    _local_5.antiAliasing = properties.antiAliasing;
                    _local_5.enableErrorChecking = properties.enableErrorChecking;
                    _local_5.simulateMultitouch = properties.simulateMultitouch;
                    _local_5.shareContext = properties.shareContext;
                    _local_5.antiAliasing = properties.antiAliasing;
                    _local_5.showStats = properties.showStats;
                }
                else
                {
                    _local_6.config("Starling framework instanciation");
                    _local_5 = new Starling(RootDisplayObject, stage);
                    Hummingbird._contextCollection.push(Hummingbird.createStarlingContextMapDto(_local_5, applicationContext));
                };
                _local_5.addEventListener("rootCreated", Hummingbird.rootCreatedHandler);
                _local_7 = new StarlingID(_local_5);
                _local_4 = _local_7.getGUID();
                Hummingbird._starlingMap[_local_4] = Hummingbird.createStarlingMapDto(_local_7, stage);
                if (_local_8)
                {
                    Hummingbird._initialStarlingGUID = _local_4;
                };
            }
            else
            {
                if (Hummingbird._initialStarlingGUID != null)
                {
                    _local_7 = Hummingbird.getStarlingID(Hummingbird._initialStarlingGUID);
                    HummingbirdBase.setApplicationContext(applicationContext);
                }
                else
                {
                    _local_6.warn("Starling framework has not been instanciated");
                    Hummingbird._contextCollection.push(Hummingbird.createStarlingContextMapDto(null, applicationContext));
                };
            };
            return (_local_7);
        }
        private static function rootCreatedHandler(e:Event):void{
            var _local_2 = null;
            var _local_3 = null;
            HummingbirdBase.getLogger().config("Starling root object created");
            var _local_5:Starling = (e.target as Starling);
            _local_5.removeEventListener("rootCreated", Hummingbird.rootCreatedHandler);
            var _local_6:int;
            while (_local_6 <= (Hummingbird._contextCollection.length - 1))
            {
                _local_2 = Hummingbird._contextCollection[_local_6];
                _local_3 = _local_2.starling;
                if ((((_local_3 == null)) || ((_local_3 == _local_5))))
                {
                    HummingbirdBase.setApplicationContext(_local_2.context);
                    Hummingbird._contextCollection.splice(_local_6, 1);
                    _local_6--;
                    _local_2.finalize();
                    _local_2 = null;
                };
                _local_6++;
            };
            var _local_4:StarlingContextEvent = new StarlingContextEvent("rootCreationComplete");
            HummingbirdBase.getEventDispatcher().dispatchEvent(_local_4);
        }
        private static function createStarlingMapDto(starlingId:StarlingID, stage:Stage):StarlingMapDto{
            var _local_3:StarlingMapDto = new StarlingMapDto();
            _local_3.starlingID = starlingId;
            _local_3.stage = stage;
            return (_local_3);
        }
        private static function createStarlingContextMapDto(starling:Starling, context:IApplicationContext):StarlingContextMapDto{
            var _local_3:StarlingContextMapDto = new StarlingContextMapDto();
            _local_3.starling = starling;
            _local_3.context = context;
            return (_local_3);
        }
        private static function getStarlingID(guid:String):StarlingID{
            return (Hummingbird.getStarlingMapDto(guid).starlingID);
        }
        private static function getStarlingMapDto(guid:String):StarlingMapDto{
            var _local_2:StarlingMapDto = Hummingbird._starlingMap[guid];
            if (_local_2 == null)
            {
                throw (new StarlingIDException(("No StarlingID object registered with the GUID " + guid)));
            };
            return (_local_2);
        }
        private static function getRootClass(starlingId:StarlingID):RootDisplayObject{
            var _local_3:Starling = Hummingbird.getStarling(starlingId);
            return ((_local_3.root as RootDisplayObject));
        }
        private static function getGUID(starlingId:StarlingID):String{
            return ((((starlingId)==null) ? Hummingbird._initialStarlingGUID : starlingId.getGUID()));
        }
        private static function deleteStarlingReference(starlingID:StarlingID):Starling{
            var _local_2:String = starlingID.getGUID();
            var _local_4:StarlingMapDto = Hummingbird._starlingMap[_local_2];
            starlingID = _local_4.starlingID;
            var _local_3:Starling = starlingID.getStarling();
            starlingID.finalize();
            _local_4.finalize();
            delete _local_4[_local_2];
            starlingID = null;
            _local_4 = null;
            if (_local_2 == Hummingbird._initialStarlingGUID)
            {
                Hummingbird._initialStarlingGUID = null;
                HummingbirdBase.getLogger().warn("Initial Starling instance removed");
            };
            return (_local_3);
        }

    }
}//package org.flashapi.hummingbird

