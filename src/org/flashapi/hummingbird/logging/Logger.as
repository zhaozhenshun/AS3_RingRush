// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//org.flashapi.hummingbird.logging.Logger

package org.flashapi.hummingbird.logging{
    import flash.events.EventDispatcher;
    import org.flashapi.hummingbird.exceptions.SingletonException;

    public class Logger extends EventDispatcher implements ILogger {

        private static const INSTANCE:ILogger = new (Logger)();

        public function Logger(){
            if (INSTANCE)
            {
                throw (new SingletonException("you must use the getInstance() method to access ILogger instances"));
            };
        }
        public static function getInstance():ILogger{
            return (Logger.INSTANCE);
        }

        public function config(message:String, ... _args):void{
            this.createLog(0, message, _args);
        }
        public function fatal(message:String, ... _args):void{
            this.createLog(1, message, _args);
        }
        public function info(message:String, ... _args):void{
            this.createLog(2, message, _args);
        }
        public function warn(message:String, ... _args):void{
            this.createLog(3, message, _args);
        }
        public function debug(message:String, ... _args):void{
            this.createLog(4, message, _args);
        }
        private function createLog(level:uint, message:String, ... _args):void{
            var _local_4:LogEvent = new LogEvent("log");
            _local_4.level = level;
            _local_4.message = this.composeLogMessage(message, _args);
            this.dispatchEvent(_local_4);
        }
        private function composeLogMessage(message:String, ... _args):String{
            var _local_3 = null;
            var _local_5 = null;
            var _local_6 = message;
            var _local_4:int = (_args.length - 1);
            while (_local_4 >= 0)
            {
                _local_3 = new RegExp((("\\{" + _local_4) + "\\}"), "gim");
                _local_5 = _args[_local_4];
                _local_6 = _local_6.replace(_local_3, _local_5);
                _local_4--;
            };
            return (_local_6);
        }

    }
}//package org.flashapi.hummingbird.logging

