// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.utils.MetadataParser

package org.flashapi.hummingbird.utils{
    import __AS3__.vec.Vector;
    import org.flashapi.hummingbird.core.IApplicationContext;
    import org.flashapi.hummingbird.core.HummingbirdBase;
    import org.flashapi.hummingbird.exceptions.MetadataException;
    import org.flashapi.hummingbird.exceptions.InvalidTypeException;
    import flash.utils.Dictionary;
    import flash.utils.describeType;
    import flash.utils.getDefinitionByName;
    import org.flashapi.hummingbird.core.IMVCObject;
    import org.flashapi.hummingbird.core.MVCReference;
    import org.flashapi.hummingbird.view.IStarlingView;
    import org.flashapi.hummingbird.enum.InterfaceReferenceEnum;
    import org.flashapi.hummingbird.view.IView;
    import org.flashapi.hummingbird.events.DependencyEvent;
    import org.flashapi.hummingbird.controller.IController;
    import org.flashapi.hummingbird.orchestrator.IOrchestrator;
    import org.flashapi.hummingbird.model.IModel;
    import org.flashapi.hummingbird.service.IService;
    import org.flashapi.hummingbird.exceptions.NoSuchDefinitionException;
    import org.flashapi.hummingbird.enum.MetadataReferenceEnum;

    public class MetadataParser {

        private static var StarlingEventRef:Class;
        private static var _dependentObj:Vector.<Object>;
        private static var _singletonType:String;
        private static var _metadataRef:String;
        private static var _contextRef:IApplicationContext;

        public static function setStarlingEventRef(starlingEventRef:Class):void{
            HummingbirdBase.getLogger().config("Starling event reference added");
            MetadataParser.StarlingEventRef = starlingEventRef;
        }
        public static function parseMetadata(obj:Object, singletonInstances:Dictionary, singletonReferences:Dictionary):void{
            _dependentObj = new Vector.<Object>();
            try
            {
                if ((obj is IApplicationContext))
                {
                    MetadataParser._contextRef = (obj as IApplicationContext);
                }
                else
                {
                    if (MetadataParser._contextRef == null)
                    {
                        HummingbirdBase.getLogger().warn((("The object '" + obj) + "' is not of type IApplicationContext on MetadataParser.parseMetadata()"));
                    };
                };
                MetadataParser.parseSingletons(obj, singletonInstances, singletonReferences);
                while (_dependentObj.length > 0)
                {
                    MetadataParser.injectDependencies(_dependentObj.shift(), singletonInstances);
                };
                _contextRef = null;
                _dependentObj = null;
                _singletonType = null;
                _metadataRef = null;
            }
            catch(e:MetadataException)
            {
                //throw (e);
            }
            catch(e:InvalidTypeException)
            {
                //throw (e);
            }
            catch(e:ReferenceError)
            {
               // throw (new MetadataException(new MetadataErrorBuilder().message("type", "", " ").message(_singletonType, "'", "'").message("is not defined on", " ", " ").message(_metadataRef).dot().build()));
            }
            catch(e:Error)
            {
                //throw (e);
            };
        }
        private static function parseSingletons(obj:Object, singletonInstances:Dictionary, singletonReferences:Dictionary):void{
            var _local_5 = null;
            var _local_7 = null;
            var _local_8 = null;
            _dependentObj.push(obj);
            var _local_6:XML = describeType(obj);
            var _local_12:XMLList = _local_6..metadata;
            _metadataRef = "RegisterClass";
            var _local_9 = _local_12.(@name == _metadataRef);
            var _local_10:int = (_local_9.length() - 1);
            var _local_11:String = "type";
            var _local_4:Vector.<Object> = new Vector.<Object>();
            _local_4.push(obj);
            while (_local_10 >= 0)
            {
                _local_7 = _local_9[_local_10].arg;
                MetadataParser.checkArgumentsCount(_local_7.length(), 1);
                _local_5 = _local_7[0];
                MetadataParser.checkKeyArgument(String(_local_5.@key), _local_11);
                _singletonType = String(_local_5.@value);
                if (!singletonReferences[_singletonType])
                {
                    _local_8 = MetadataParser.createSingleton(_singletonType, singletonInstances, singletonReferences);
                    MetadataParser.parseSingletons(_local_8, singletonInstances, singletonReferences);
                };
                _local_10--;
            };
        }
        private static function createSingleton(_arg_1:String, _arg_2:Dictionary, _arg_3:Dictionary):Object{
            var _local_4 = null;
            var _local_5:Class = (getDefinitionByName(_arg_1) as Class);
            var _local_9:Object = new (_local_5)();
            var _local_6:XML = describeType(_local_9);
            var _local_11:XMLList = _local_6..metadata;
            _metadataRef = "Qualifier";
            var _local_10 = _local_11.(@name == _metadataRef);
            MetadataParser.checkMetadata(_metadataRef, _local_10.length(), _local_9);
            var _local_7:XMLList = _local_10.arg;
            MetadataParser.checkArgumentsCount(_local_7.length(), 1);
            _local_4 = _local_7[0];
            MetadataParser.checkKeyArgument(String(_local_4.@key), "alias");
            var _local_8:String = String(_local_4.@value);
            MetadataParser.checkAlias(_local_8, _local_9);
            _arg_2[_local_8] = MetadataParser.getMVCReference(_local_8, (_local_9 as IMVCObject), _arg_1);
            _arg_3[_arg_1] = _arg_1;
            return (_local_9);
        }
        private static function getMVCReference(alias:String, mvcObject:IMVCObject, typeDefinition:String):MVCReference{
            var _local_4:MVCReference = new MVCReference();
            _local_4.context = MetadataParser._contextRef;
            _local_4.alias = alias;
            _local_4.mvcObject = mvcObject;
            _local_4.typeDefinition = typeDefinition;
            return (_local_4);
        }
        private static function injectDependencies(obj:Object, singletonInstances:Dictionary):void{
            var _local_4 = null;
            var _local_3:XML = describeType(obj);
            if ((obj is IStarlingView))
            {
                _local_4 = InterfaceReferenceEnum.STARLING_VIEW.getInterfaceType();
                MetadataParser.injectInstances(obj, _local_3, singletonInstances, "Model");
                MetadataParser.injectInstances(obj, _local_3, singletonInstances, "Controller");
                MetadataParser.injectInstances(obj, _local_3, singletonInstances, "Orchestrator");
                MetadataParser.checkInvalidDependencies(obj, _local_3, "Service", _local_4);
                obj.dispatchEvent(new MetadataParser.StarlingEventRef(MetadataParser.StarlingEventRef.DEPENDENCY_COMPLETE));
            }
            else
            {
                if ((obj is IView))
                {
                    _local_4 = InterfaceReferenceEnum.VIEW.getInterfaceType();
                    MetadataParser.injectInstances(obj, _local_3, singletonInstances, "Model");
                    MetadataParser.injectInstances(obj, _local_3, singletonInstances, "Controller");
                    MetadataParser.injectInstances(obj, _local_3, singletonInstances, "Orchestrator");
                    MetadataParser.checkInvalidDependencies(obj, _local_3, "Service", _local_4);
                    obj.dispatchEvent(new DependencyEvent("dependencyComplete"));
                }
                else
                {
                    if ((obj is IApplicationContext))
                    {
                        _local_4 = InterfaceReferenceEnum.APPLICATION_CONTEXT.getInterfaceType();
                        MetadataParser.injectInstances(obj, _local_3, singletonInstances, "Model");
                        MetadataParser.injectInstances(obj, _local_3, singletonInstances, "Controller");
                        MetadataParser.injectInstances(obj, _local_3, singletonInstances, "Orchestrator");
                        MetadataParser.checkInvalidDependencies(obj, _local_3, "Service", _local_4);
                        obj.dispatchEvent(new DependencyEvent("dependencyComplete"));
                    }
                    else
                    {
                        if ((obj is IController))
                        {
                            _local_4 = InterfaceReferenceEnum.CONTROLLER.getInterfaceType();
                            MetadataParser.injectInstances(obj, _local_3, singletonInstances, "Model");
                            MetadataParser.injectInstances(obj, _local_3, singletonInstances, "Service");
                            MetadataParser.injectInstances(obj, _local_3, singletonInstances, "Orchestrator");
                            MetadataParser.checkInvalidDependencies(obj, _local_3, "Controller", _local_4);
                            obj.dispatchEvent(new DependencyEvent("dependencyComplete"));
                        }
                        else
                        {
                            if ((obj is IOrchestrator))
                            {
                                _local_4 = InterfaceReferenceEnum.ORCHESTRATOR.getInterfaceType();
                                MetadataParser.injectInstances(obj, _local_3, singletonInstances, "Model");
                                MetadataParser.checkInvalidDependencies(obj, _local_3, "Controller", _local_4);
                                MetadataParser.checkInvalidDependencies(obj, _local_3, "Service", _local_4);
                                MetadataParser.checkInvalidDependencies(obj, _local_3, "Orchestrator", _local_4);
                                obj.dispatchEvent(new DependencyEvent("dependencyComplete"));
                            }
                            else
                            {
                                if ((obj is IModel))
                                {
                                    _local_4 = InterfaceReferenceEnum.MODEL.getInterfaceType();
                                    MetadataParser.injectInstances(obj, _local_3, singletonInstances, "Service");
                                    MetadataParser.checkInvalidDependencies(obj, _local_3, "Model", _local_4);
                                    MetadataParser.checkInvalidDependencies(obj, _local_3, "Controller", _local_4);
                                    MetadataParser.checkInvalidDependencies(obj, _local_3, "Orchestrator", _local_4);
                                    obj.dispatchEvent(new DependencyEvent("dependencyComplete"));
                                }
                                else
                                {
                                    if ((obj is IService))
                                    {
                                        _local_4 = InterfaceReferenceEnum.SERVICE.getInterfaceType();
                                        MetadataParser.checkInvalidDependencies(obj, _local_3, "Model", _local_4);
                                        MetadataParser.checkInvalidDependencies(obj, _local_3, "Controller", _local_4);
                                        MetadataParser.checkInvalidDependencies(obj, _local_3, "Orchestrator", _local_4);
                                        MetadataParser.checkInvalidDependencies(obj, _local_3, "Service", _local_4);
                                    };
                                };
                            };
                        };
                    };
                };
            };
        }
        private static function injectInstances(obj:Object, reflection:XML, singletonInstances:Dictionary, metadataRef:String):void{
            var _local_5 = null;
            var _local_9 = null;
            var _local_11 = null;
            var _local_6 = null;
            var _local_8 = null;
            var _local_7 = null;
            var _local_12 = reflection..metadata.(@name == metadataRef);
            var _local_10:int = (_local_12.length() - 1);
            while (_local_10 >= 0)
            {
                _local_5 = _local_12[_local_10];
                _local_9 = _local_5.parent();
                _local_11 = _local_9.@name;
                _local_6 = _local_5.arg[0].@value;
                _local_8 = singletonInstances[_local_6];
                if (_local_8 != null)
                {
                    _local_7 = _local_8.mvcObject;
                    MetadataParser.checkInvalidMVCMetadata(metadataRef, _local_7, _local_6);
                    obj[_local_11] = _local_7;
                }
                else
                {
                    throw (new NoSuchDefinitionException(new MetadataErrorBuilder().message("the alias").message(_local_6, " '", "'").message(" has not been found").dot().build()));
                };
                _local_10--;
            };
        }
        private static function checkInvalidMVCMetadata(metadataRef:String, obj:Object, alias:String):void{
            var _local_4 = null;
            var _local_6:Boolean = true;
            var _local_5:Boolean = true;
            if (metadataRef == "Model")
            {
                _local_6 = (obj is IModel);
                _local_4 = "Model";
                _local_5 = MetadataParser.isValidMetadata(metadataRef, _local_4);
            }
            else
            {
                if (metadataRef == "Controller")
                {
                    _local_6 = (obj is IController);
                    _local_4 = "Controller";
                    _local_5 = MetadataParser.isValidMetadata(metadataRef, _local_4);
                }
                else
                {
                    if (metadataRef == "Orchestrator")
                    {
                        _local_6 = (obj is IOrchestrator);
                        _local_4 = "Orchestrator";
                        _local_5 = MetadataParser.isValidMetadata(metadataRef, _local_4);
                    }
                    else
                    {
                        if (metadataRef == "Service")
                        {
                            _local_6 = (obj is IService);
                            _local_4 = "Service";
                            _local_5 = MetadataParser.isValidMetadata(metadataRef, _local_4);
                        };
                    };
                };
            };
            if (_local_6 == false)
            {
                throw (new InvalidTypeException(new MetadataErrorBuilder().message("invalid interface declaration").message(alias, " on '", "'").dot().expected(MetadataParser.geInterfaceFromMetadata(_local_4), " ").dot().build()));
            };
            if (_local_5 == false)
            {
                throw (new MetadataException(new MetadataErrorBuilder().message("invalid metadata declaration").message(metadataRef, " '", "'").message(alias, " on '", "'").dot().expected(MetadataParser.getMetadataFromInterface(obj), " ").dot().build()));
            };
        }
        private static function isValidMetadata(metadataRef:String, expectedValue:String):Boolean{
            return ((metadataRef == expectedValue));
        }
        private static function geInterfaceFromMetadata(metadata:String):String{
            var _local_2 = null;
            if (metadata == MetadataReferenceEnum.CONTROLLER.metadataReference)
            {
                _local_2 = MetadataReferenceEnum.CONTROLLER.interfaceReference;
            }
            else
            {
                if (metadata == MetadataReferenceEnum.MODEL.metadataReference)
                {
                    _local_2 = MetadataReferenceEnum.MODEL.interfaceReference;
                }
                else
                {
                    if (metadata == MetadataReferenceEnum.CONTROLLER.metadataReference)
                    {
                        _local_2 = MetadataReferenceEnum.CONTROLLER.interfaceReference;
                    }
                    else
                    {
                        if (metadata == MetadataReferenceEnum.ORCHESTRATOR.metadataReference)
                        {
                            _local_2 = MetadataReferenceEnum.ORCHESTRATOR.interfaceReference;
                        }
                        else
                        {
                            if (metadata == MetadataReferenceEnum.SERVICE.metadataReference)
                            {
                                _local_2 = MetadataReferenceEnum.SERVICE.interfaceReference;
                            };
                        };
                    };
                };
            };
            return (_local_2);
        }
        private static function getMetadataFromInterface(obj:Object):String{
            var _local_4 = null;
            var _local_2:XML = describeType(obj);
            var _local_3:XMLList = _local_2..implementsInterface;
            if (_local_3.(@type == MetadataReferenceEnum.CONTROLLER.interfaceReference) != null)
            {
                _local_4 = MetadataReferenceEnum.CONTROLLER.metadataReference;
            }
            else
            {
                if (_local_3.(@type == MetadataReferenceEnum.MODEL.interfaceReference) != null)
                {
                    _local_4 = MetadataReferenceEnum.MODEL.metadataReference;
                }
                else
                {
                    if (_local_3.(@type == MetadataReferenceEnum.CONTROLLER.interfaceReference) != null)
                    {
                        _local_4 = MetadataReferenceEnum.CONTROLLER.metadataReference;
                    }
                    else
                    {
                        if (_local_3.(@type == MetadataReferenceEnum.ORCHESTRATOR.interfaceReference) != null)
                        {
                            _local_4 = MetadataReferenceEnum.ORCHESTRATOR.metadataReference;
                        }
                        else
                        {
                            if (_local_3.(@type == MetadataReferenceEnum.SERVICE.interfaceReference) != null)
                            {
                                _local_4 = MetadataReferenceEnum.SERVICE.metadataReference;
                            };
                        };
                    };
                };
            };
            return (_local_4);
        }
        private static function checkInvalidDependencies(_arg_1:Object, _arg_2:XML, _arg_3:String, _arg_4:String):void{
            var _local_6 = _arg_2..metadata.(@name == _arg_3);
            var _local_5:int = _local_6.length();
            if (_local_5 > 0)
            {
                throw (new MetadataException(new MetadataErrorBuilder().message("illegal dependency declaration on").message(_arg_1.toString(), " ", ":").message(_arg_3, " ").message("is not allowed in", " ", " ").message(_arg_4).message("objects", " ").dot().build()));
            };
        }
        private static function checkArgumentsCount(length:int, expectactedValue:int):void{
            if (length != expectactedValue)
            {
                throw (new MetadataException(new MetadataErrorBuilder().message("argument count mismatch on").message(_metadataRef, " ", " ").dot().expected(expectactedValue, " ").comma().got(length).dot().build()));
            };
        }
        private static function checkKeyArgument(argKey:String, expectactedValue:String):void{
            if (argKey != expectactedValue)
            {
                throw (new MetadataException(new MetadataErrorBuilder().message("invalid property on").message(_metadataRef, " ", " ").dot().expected(expectactedValue, " ").comma().got(argKey).dot().build()));
            };
        }
        private static function checkMetadata(metadata:String, length:int, obj:Object):void{
            if (length != 1)
            {
                throw (new MetadataException(new MetadataErrorBuilder().message(metadata, "'", "'").message("metadata not found on", " ", " ").message(obj.toString()).dot().build()));
            };
        }
        private static function checkAlias(alias:String, obj:Object):void{
            if (alias == "")
            {
                throw (new MetadataException(new MetadataErrorBuilder().message("undefined 'alias' value found on").message(obj.toString(), " ").dot().build()));
            };
        }

    }
}//package org.flashapi.hummingbird.utils

