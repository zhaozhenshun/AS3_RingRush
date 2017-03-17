// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//utils.ChangeColor

package utils{
    public class ChangeColor {

        private var _initColor:Number;
        private var _finalColor:Number;
        private var _currentColor:int;
        private var _currentProgress:Number = 0;
        private var _callback:Function;
        private var rStart:Number;
        private var gStart:Number;
        private var bStart:Number;
        private var rFinal:Number;
        private var gFinal:Number;
        private var bFinal:Number;

        public function get currentProgress():Number{
            return (_currentProgress);
        }
        public function set currentProgress(value:Number):void{
            _currentProgress = value;
            updateColor();
        }
        public function setColors(initialColor:Number, finalColor:Number):void{
            _initColor = initialColor;
            _finalColor = finalColor;
            calculateStartAndFinalColorsArgbs();
            this.currentProgress = 0;
        }
        public function setCallback(val:Function):void{
            _callback = val;
        }
        public function get color():Number{
            return (_currentColor);
        }
        private function updateColor():void{
            calculateColorBasedOnProgress();
            if (_callback != null)
            {
                (_callback());
            };
        }
        private function calculateColorBasedOnProgress():void{
            var _local_2:Number = (rStart + ((rFinal - rStart) * _currentProgress));
            var _local_1:Number = (gStart + ((gFinal - gStart) * _currentProgress));
            var _local_3:Number = (bStart + ((bFinal - bStart) * _currentProgress));
            _currentColor = toRGB(_local_2, _local_1, _local_3);
        }
        private function calculateStartAndFinalColorsArgbs():void{
            rStart = getRed(_initColor);
            gStart = getGreen(_initColor);
            bStart = getBlue(_initColor);
            rFinal = getRed(_finalColor);
            gFinal = getGreen(_finalColor);
            bFinal = getBlue(_finalColor);
        }
        private function getRed(color:int):int{
            return (((color >> 16) & 0xFF));
        }
        private function getGreen(color:int):int{
            return (((color >> 8) & 0xFF));
        }
        private function getBlue(color:int):int{
            return ((color & 0xFF));
        }
        private function toRGB(red:int, green:int, blue:int):int{
            return ((((red << 16) | (green << 8)) | blue));
        }

    }
}//package utils

