// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//utils.sqlite.ISQLiteService

package utils.sqlite{
    import org.flashapi.hummingbird.model.IModel;

    public /*dynamic*/ interface ISQLiteService extends IModel {

        function setDataBase(_arg_1:String):void;
        function addSQLiteStatement(_arg_1:SQLiteStatement):void;
        function getSQLiteStatement(_arg_1:uint):SQLiteStatement;

    }
}//package utils.sqlite

