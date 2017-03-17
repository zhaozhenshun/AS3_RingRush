// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.starling.StarlingPropertiesBuilder

package org.flashapi.hummingbird.starling{
    import flash.geom.Rectangle;
    import flash.display.Stage3D;

    public class StarlingPropertiesBuilder {

        private var _antiAliasing:int;
        private var _showStats:Boolean;
        private var _viewPort:Rectangle;
        private var _stage3D:Stage3D;
        private var _renderMode:String;
        private var _profile:String;
        private var _enableErrorChecking:Boolean;
        private var _handleLostContext:Boolean;
        private var _multitouchEnabled:Boolean;
        private var _simulateMultitouch:Boolean;
        private var _shareContext:Boolean;

        public function build():StarlingProperties{
            var _local_1:StarlingProperties = new StarlingProperties();
            this.setValue(_local_1, "antiAliasing", _antiAliasing);
            this.setValue(_local_1, "showStats", _showStats);
            this.setValue(_local_1, "viewPort", _viewPort);
            this.setValue(_local_1, "stage3D", _stage3D);
            this.setValue(_local_1, "renderMode", _renderMode);
            this.setValue(_local_1, "profile", _profile);
            this.setValue(_local_1, "enableErrorChecking", _enableErrorChecking);
            this.setValue(_local_1, "handleLostContext", _handleLostContext);
            this.setValue(_local_1, "multitouchEnabled", _multitouchEnabled);
            this.setValue(_local_1, "simulateMultitouch", _simulateMultitouch);
            this.setValue(_local_1, "shareContext", _shareContext);
            return (_local_1);
        }
        public function antiAliasing(value:int):StarlingPropertiesBuilder{
            _antiAliasing = value;
            return (this);
        }
        public function showStats(value:Boolean):StarlingPropertiesBuilder{
            _showStats = value;
            return (this);
        }
        public function viewPort(value:Rectangle):StarlingPropertiesBuilder{
            _viewPort = value;
            return (this);
        }
        public function stage3D(value:Stage3D):StarlingPropertiesBuilder{
            _stage3D = value;
            return (this);
        }
        public function renderMode(value:String):StarlingPropertiesBuilder{
            _renderMode = value;
            return (this);
        }
        public function profile(value:String):StarlingPropertiesBuilder{
            _profile = value;
            return (this);
        }
        public function enableErrorChecking(value:Boolean):StarlingPropertiesBuilder{
            _enableErrorChecking = value;
            return (this);
        }
        public function handleLostContext(value:Boolean):StarlingPropertiesBuilder{
            _handleLostContext = value;
            return (this);
        }
        public function multitouchEnabled(value:Boolean):StarlingPropertiesBuilder{
            _multitouchEnabled = value;
            return (this);
        }
        public function simulateMultitouch(value:Boolean):StarlingPropertiesBuilder{
            _simulateMultitouch = value;
            return (this);
        }
        public function shareContext(value:Boolean):StarlingPropertiesBuilder{
            _shareContext = value;
            return (this);
        }
        private function setValue(props:StarlingProperties, property:String, value:*):void{
            if (value)
            {
                props[property] = value;
            };
        }

    }
}//package org.flashapi.hummingbird.starling

