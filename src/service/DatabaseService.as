// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//service.DatabaseService

package service{
    import org.flashapi.hummingbird.service.AbstractService;
    import utils.sqlite.ISQLiteService;
	import utils.sqlite.SQLiteService;
    import utils.sqlite.SQLiteStatement;

    [Qualifier(alias="DatabaseService")]
    public final class DatabaseService extends AbstractService implements IDatabaseService {

        [Service(alias="SQLiteService")]
        public var sqliteService:ISQLiteService;
		
		private static var _instance:DatabaseService;
		
		public static function GetInstance():DatabaseService {
			if (!_instance) _instance = new DatabaseService();
			return _instance;
		}
		
		public function DatabaseService() {
			
			sqliteService = new SQLiteService();
		}
		
        public function init():void{
            sqliteService.setDataBase("assets/db/app.sqlite");
        }
        public function query(query:String, itemClass:Class, callback:Function):void{
            var _local_4:SQLiteStatement = new SQLiteStatement();
            _local_4.query = query;
            _local_4.itemClass = itemClass;
            _local_4.callback = callback;
            sqliteService.addSQLiteStatement(_local_4);
            _local_4.execute();
            _local_4 = null;
        }

    }
}//package service

