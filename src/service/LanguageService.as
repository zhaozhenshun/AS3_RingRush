// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//service.LanguageService

package service{
    import org.flashapi.hummingbird.service.AbstractService;
    import utils.Dictionary;

    [Qualifier(alias="LanguageService")]
    public class LanguageService extends AbstractService implements ILanguageService {

        private var _locale:String = "en";
        private var _translations:Dictionary;

        public function LanguageService(){
            _translations = new Dictionary();
            var _local_1:Dictionary = new Dictionary();
            _local_1.setValue("SETTINGS_LABEL", "EINSTELLUNGEN");
            _local_1.setValue("SETTINGS_MUSIC", "MUSIK");
            _local_1.setValue("SETTINGS_SOUND", "TON");
            _local_1.setValue("SETTINGS_RESTORE", "EINKÄUFE WIEDERHERSTELLEN");
            _local_1.setValue("SETTINGS_REMOVE", "WERBUNG ENTFERNEN");
            _local_1.setValue("SETTINGS_IS_REMOVED", "WERBUNG WURDE ENTFERNT");
            _local_1.setValue("SETTINGS_NOT_SUPPORTED", "IN APP EINKÄUFE NICHT MÖGLICH");
            _local_1.setValue("INFO_LABEL", "ENTWICKELT VON");
            _local_1.setValue("INFO_HELLO", "SAG HALLO");
            _local_1.setValue("AD_INFO", "UNTERSTÜTZE UNS UND ENTFERNE DIE WERBUNG!");
            _local_1.setValue("RATE_TITLE", "Bitte bewerte Ring Rush");
            _local_1.setValue("RATE_MESSAGE", "Gefällt dir Ring Rush? Schreib uns deine Meinung");
            _local_1.setValue("RATE_NOW_LABEL", "Jetzt bewerten");
            _local_1.setValue("RATE_DECLINE_LABEL", "Später erinnern");
            _local_1.setValue("RATE_NOT_LABEL", "Nicht nochmal fragen");
            _local_1.setValue("PURCHASE_INFO", "VIELEN DANK FÜR DIE UNTERSTÜTZUNG!");
            _local_1.setValue("PURCHASE_SUCCESS", "VIELEN DANK! DIE WERBUNG WURDE ENTFERNT.");
            _local_1.setValue("PURCHASE_FAIL", "SORRY! ETWAS IST SCHIEF GELAUFEN. BITTE VERSUCHEN SIE ES SPÄTER NOCHMAL.");
            _local_1.setValue("PURCHASE_PROCESSING", "BITTE WARTEN. WIRD GELADEN ...");
            _translations.setValue("de", _local_1);
        }
        public function setLocale(val:String):void{
            _locale = val;
        }
        public function getLocale():String{
            return (_locale);
        }
        public function translate(entity:String, val:String):String{
            var _local_3 = null;
            var _local_4 = val;
            var _local_5:String = this.getLocale();
            var _local_6:Dictionary = _translations.getValue(_local_5);
            if (_local_6 != null)
            {
                _local_3 = _local_6.getValue(entity);
                if (_local_3 != null)
                {
                    _local_4 = _local_3;
                };
            };
            return (_local_4);
        }

    }
}//package service

