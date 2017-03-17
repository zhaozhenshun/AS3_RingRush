// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//models.dto.ElementItem

package models.dto{
    import constants.App;

    public class ElementItem implements IElementItem {

        public var id:uint;
        public var start:uint;
        public var end:uint;
        private var _type:uint;
        private var _display:uint;
        public var lastType:uint;
        public var orgType:uint;
        public var state:uint;

        public function get display():uint{
            return (_display);
        }
        public function set type(val:uint):void{
            if (_type != 0)
            {
                lastType = _type;
            };
            _type = val;
            var _local_2:TypeItem = App.elementType(val);
            _display = _local_2.display;
            _local_2 = null;
        }
        public function get type():uint{
            return (_type);
        }

    }
}//package models.dto

