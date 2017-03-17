// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//ui.display.InfoButton

package ui.display{
    import utils.BasicButton;
    import starling.text.TextField;
    import starling.display.Quad;

    public class InfoButton extends BasicButton {

        private var _width:Number;
        private var _height:Number;
        private var _label1:String;
        private var _label2:String;
        private var _text1:TextField;
        private var _text2:TextField;
        private var _bg:Quad;
        private var _padding:int = 60;
        private var _font1:String = "Museo";
        private var _font2:String = "Museo";
        private var _bgUpColor:Number = 0xFFFFFF;
        private var _bgDownColor:Number = 0xF0F0F0;
        private var _label1UpColor:Number = 1155310;
        private var _label1DownColor:Number = 952274;
        private var _label2UpColor:Number = 8750213;
        private var _label2DownColor:Number = 0x777777;

        public function InfoButton(width:Number, height:Number, label1:String, label2:String, font2:String="Museo"){
            _width = width;
            _height = height;
            _label1 = label1;
            _label2 = label2;
            _font2 = font2;
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
            var _local_1:Number = ((_height / 2) - _padding);
            _text1 = new TextField(_width, _local_1, _label1, _font1, 36, _label1UpColor);
            _text1.hAlign = "center";
            _text1.vAlign = "bottom";
            _text1.y = _padding;
            this.content.addChild(_text1);
            _text2 = new TextField(_width, _local_1, _label2, _font2, 36, _label2UpColor);
            _text2.hAlign = "center";
            _text2.vAlign = "top";
            _text2.y = (_height / 2);
            this.content.addChild(_text2);
        }
        public function set label2(val:String):void{
            _text2.text = val;
            _text2.redraw();
        }
        public function set font2(val:String):void{
            _font2 = val;
            _text2.fontName = val;
            _text2.redraw();
        }
        public function set label1UpColor(val:Number):void{
            _label1UpColor = val;
            up();
        }
        public function set label2UpColor(val:Number):void{
            _label2UpColor = val;
            up();
        }
        public function set label1DownColor(val:Number):void{
            _label1DownColor = val;
        }
        public function set label2DownColor(val:Number):void{
            _label2DownColor = val;
        }
        public function set bgUpColor(val:Number):void{
            _bgUpColor = val;
            up();
        }
        public function set bgDownColor(val:Number):void{
            _bgDownColor = val;
        }
        public function set padding(val:int):void{
            _padding = val;
            draw();
        }
        override protected function down():void{
            super.down();
            _bg.color = _bgDownColor;
            _text1.color = _label1DownColor;
            _text1.redraw();
            _text2.color = _label2DownColor;
            _text2.redraw();
        }
        override protected function up():void{
            super.up();
            _bg.color = _bgUpColor;
            _text1.color = _label1UpColor;
            _text1.redraw();
            _text2.color = _label2UpColor;
            _text2.redraw();
        }
        override public function get width():Number{
            return (_bg.width);
        }
        override public function get height():Number{
            return (_bg.height);
        }

    }
}//package ui.display

