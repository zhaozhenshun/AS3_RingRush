// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//ui.display.SimpleButton

package ui.display{
    import utils.BasicButton;
    import starling.text.TextField;
    import starling.display.Quad;

    public class SimpleButton extends BasicButton {

        private var _width:Number;
        private var _height:Number;
        private var _label:String;
        private var _text:TextField;
        private var _bg:Quad;
        private var _bgUpColor:Number = 0xFFFFFF;
        private var _bgDownColor:Number = 0xF0F0F0;
        private var _labelUpColor:Number = 1155310;
        private var _labelDownColor:Number = 952274;

        public function SimpleButton(width:Number, height:Number, label:String){
            _width = width;
            _height = height;
            _label = label;
            draw();
        }
        private function clean():void{
            while (this.content.numChildren > 0)
            {
                this.content.removeChildAt(0);
            };
        }
        private function draw():void{
            this.clean();
            _bg = new Quad(_width, _height, _bgUpColor);
            this.content.addChild(_bg);
            _text = new TextField(_width, _height, _label, "Museo", 36, _labelUpColor);
            _text.hAlign = "center";
            _text.vAlign = "center";
            this.content.addChild(_text);
        }
        public function set label(val:String):void{
            _label = val;
            if (_text != null)
            {
                _text.text = _label;
                _text.redraw();
            };
        }
        public function set labelUpColor(val:Number):void{
            _labelUpColor = val;
            up();
        }
        public function set labelDownColor(val:Number):void{
            _labelDownColor = val;
        }
        public function set bgUpColor(val:Number):void{
            _bgUpColor = val;
            up();
        }
        public function set bgDownColor(val:Number):void{
            _bgDownColor = val;
        }
        override protected function down():void{
            super.down();
            _bg.color = _bgDownColor;
            _text.color = _labelDownColor;
            _text.redraw();
        }
        override protected function up():void{
            super.up();
            _bg.color = _bgUpColor;
            _text.color = _labelUpColor;
            _text.redraw();
        }
        override public function get width():Number{
            return (_bg.width);
        }
        override public function get height():Number{
            return (_bg.height);
        }

    }
}//package ui.display

