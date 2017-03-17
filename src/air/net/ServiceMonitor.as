// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//air.net.ServiceMonitor

package air.net{
    import flash.events.EventDispatcher;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.desktop.NativeApplication;
    import flash.events.Event;
    import flash.events.StatusEvent;

    public dynamic class ServiceMonitor extends EventDispatcher {

        private static const kInvalidParamError:uint = 2004;
        private static const kDelayRangeError:uint = 2066;

        private var _running:Boolean = false;
        private var _delay:Number = 0;
        private var _timer:Timer;
        private var _available:Boolean = false;
        private var _specializer:Object = null;
        private var _notifyRegardless:Boolean = false;
        private var _statusTime:Date;

        public function ServiceMonitor(){
            this._timer = new Timer(this._delay);
            this._statusTime = new Date();
            super();
            this._timer.addEventListener(TimerEvent.TIMER, this.onTimer);
        }
        private static function makeForwarder(name:String):Function{
            return (function forwarder (... _args){
                return (this.__monitor__[name].apply(this.__monitor__, _args));
            });
        }
        public static function makeJavascriptSubclass(constructorFunction:Object):void{
            var name:String;
            var proto:Object = constructorFunction.prototype;
            var names:Array = ["start", "stop", "willTrigger", "removeEventListener", "addEventListener", "dispatchEvent", "hasEventListener"];
            for each (name in names)
            {
                proto[name] = makeForwarder(name);
            };
            proto.setAvailable = function (value:Boolean):void{
                this.__monitor__.available = value;
            };
            proto.getAvailable = function ():Boolean{
                return (this.__monitor__.available);
            };
            proto.toString = makeForwarder("_toString");
            proto.initServiceMonitor = function (){
                return (_initServiceMonitor(this));
            };
        }
        private static function _initServiceMonitor(specializer:Object):ServiceMonitor{
            var _local_2:ServiceMonitor = new (ServiceMonitor)();
            specializer.__monitor__ = _local_2;
            _local_2._specializer = specializer;
            return (_local_2);
        }

        public function stop():void{
            if (!this._running)
            {
                return;
            };
            this._running = false;
            this._timer.stop();
            NativeApplication.nativeApplication.removeEventListener(Event.NETWORK_CHANGE, this.onNetworkChange);
        }
        public function set pollInterval(value:Number):void{
            if ((((value < 0)) || (!(isFinite(value)))))
            {
                Error.throwError(RangeError, kDelayRangeError);
            };
            this._delay = value;
            this._timer.stop();
            if (this._delay > 0)
            {
                this._timer.delay = this._delay;
                if (this._running)
                {
                    this._timer.start();
                };
            };
        }
        public function get available():Boolean{
            return (this._available);
        }
        private function _toString():String{
            return ((('[ServiceMonitor available="' + this.available) + '"]'));
        }
        public function get lastStatusUpdate():Date{
            return (new Date(this._statusTime.time));
        }
        public function set available(value:Boolean):void{
            var _local_3:String;
            var _local_4:String;
            var _local_2:Boolean = this._available;
            this._available = value;
            this._statusTime = new Date();
            if (((!((_local_2 == this._available))) || (this._notifyRegardless)))
            {
                _local_3 = ((this._available) ? "Service.available" : "Service.unavailable");
                _local_4 = "status";
                dispatchEvent(new StatusEvent(StatusEvent.STATUS, false, false, _local_3, _local_4));
            };
            this._notifyRegardless = false;
        }
        protected function checkStatus():void{
            if (((this._specializer) && (this._specializer.checkStatus)))
            {
                this._specializer.checkStatus();
            };
        }
        private function onNetworkChange(event:Event):void{
            if (!this._running)
            {
                return;
            };
            if (this._delay > 0)
            {
                this._timer.stop();
                this._timer.start();
            };
            this.checkStatus();
        }
        public function start():void{
            if (this._running)
            {
                return;
            };
            this._running = true;
            this._notifyRegardless = true;
            if (this._delay > 0)
            {
                this._timer.start();
            };
            NativeApplication.nativeApplication.addEventListener(Event.NETWORK_CHANGE, this.onNetworkChange, false, 0, true);
            this.checkStatus();
        }
        public function get pollInterval():Number{
            return (this._delay);
        }
        private function onTimer(event:TimerEvent):void{
            this.checkStatus();
        }
        override public function toString():String{
            if (((this._specializer) && (this._specializer.toString)))
            {
                return (this._specializer.toString());
            };
            return (this._toString());
        }
        public function get running():Boolean{
            return (this._running);
        }

    }
}//package air.net

