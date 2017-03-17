// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//service.NetStatusService

package service{
    import org.flashapi.hummingbird.service.AbstractService;
    import air.net.URLMonitor;
    import flash.net.URLRequest;
    import flash.desktop.NativeApplication;
    import flash.events.Event;
    import flash.events.StatusEvent;
    import events.ModelEvent;

    [Qualifier(alias="NetStatusService")]
    public class NetStatusService extends AbstractService implements INetStatusService {

        private var urlMonitor:URLMonitor;
        private var url:String;
        private var urlRequest:URLRequest;

        public function NetStatusService(){
            urlRequest = new URLRequest("http://www.google.de");
            urlRequest.method = "HEAD";
            urlMonitor = new URLMonitor(urlRequest);
            urlMonitor.addEventListener("status", netStatus);
            NativeApplication.nativeApplication.addEventListener("networkChange", netChange);
        }
        protected function netChange(event:Event):void{
            start();
        }
        public function start():void{
            if (!urlMonitor.running)
            {
                urlMonitor.start();
            };
        }
        public function stop():void{
            if (urlMonitor.running)
            {
                urlMonitor.stop();
            };
        }
        private function netStatus(event:StatusEvent):void{
            this.dispatchModelEvent("netStateChanged");
            stop();
        }
        public function getState():Boolean{
            if (urlMonitor != null)
            {
                return (urlMonitor.available);
            };
            return (false);
        }
        private function dispatchModelEvent(eventType:String):void{
            this.dispatchEvent(new ModelEvent(eventType));
        }

    }
}//package service

