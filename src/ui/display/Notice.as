// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//ui.display.Notice

package ui.display{
    import starling.display.Sprite;
    import starling.text.TextField;
    import starling.display.graphics.RoundedRectangle;

    public class Notice extends Sprite {

        private var _width:Number;
        private var _padding:Number;
        private var _container:Sprite;
        private var _label:String = "text";
        private var _text:TextField;
        private var _textColor:Number = 0;
        private var _bg:RoundedRectangle;
        private var _bgColor:Number = 0xFFFFFF;

        public function Notice(width:Number, padding:Number=10){
            _width = width;
            _padding = padding;
            _container = new Sprite();
            this.addChild(_container);
            _text = new TextField((_width - (_padding * 2)), 1, _label, "Museo", 24, _textColor);
            _text.autoSize = "vertical";
            _text.hAlign = "center";
            _text.vAlign = "center";
            _text.x = _padding;
            _text.y = _padding;
            _container.addChild(_text);
            _bg = new RoundedRectangle(width, (_text.height + (_padding * 2)), 10, 10, 10, 10);
            _bg.material.color = _bgColor;
            _container.addChildAt(_bg, 0);
            _container.x = (-(_bg.width) * 0.5);
            _container.y = (-(_bg.height) * 0.5);
        }
        override public function set height(value:Number):void{
        }
        override public function set width(value:Number):void{
            _width = value;
            redraw();
        }
        override public function get width():Number{
            return (_bg.width);
        }
        override public function get height():Number{
            return (_bg.height);
        }
        public function set text(val:String):void{
            _label = val;
            redraw();
        }
        public function set bgColor(val:Number):void{
            _bgColor = val;
            _bg.material.color = _bgColor;
        }
        public function set textColor(val:Number):void{
            _textColor = val;
            redraw();
        }
        private function redraw():void{
            _text.text = _label;
            _text.color = _textColor;
            _text.width = (_width - (_padding * 2));
            _text.redraw();
            _bg.width = _width;
            _bg.height = (_text.height + (_padding * 2));
            _container.x = (-(_bg.width) * 0.5);
            _container.y = (-(_bg.height) * 0.5);
        }

    }
}//package ui.display

