// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//ui.display.ToggleButton

package ui.display{
    import utils.BasicButton;
    import starling.text.TextField;
    import starling.display.Quad;

    public class ToggleButton extends BasicButton {

        private var _text:TextField;
        private var _bg:Quad;

        public function ToggleButton(label:String, width:int, height:int){
            _bg = new Quad(width, height, 13685200);
            this.content.addChild(_bg);
            _text = new TextField(width, height, label, "Museo", 48, 1155310);
            _text.hAlign = "center";
            _text.vAlign = "center";
            this.content.addChild(_text);
        }
        public function active(state:Boolean):void{
            _text.color = ((state) ? 0xFFFFFF : 0xB8B8B8);
            _text.redraw();
        }
        override protected function down():void{
            super.down();
            _bg.color = 0xC5C5C5;
        }
        override protected function up():void{
            super.up();
            _bg.color = 13685200;
        }
        override public function get width():Number{
            return (_bg.width);
        }
        override public function get height():Number{
            return (_bg.height);
        }

    }
}//package ui.display

