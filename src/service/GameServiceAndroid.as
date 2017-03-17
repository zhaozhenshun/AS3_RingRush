// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//service.GameServiceAndroid

package service{
    //import com.milkmangames.nativeextensions.GoogleGames;
    //import com.milkmangames.nativeextensions.events.GoogleGamesEvent;
	import service.GameService;

    [Qualifier(alias="GameService")]
    public class GameServiceAndroid extends GameService {

        private var _message:String;

        override public function init():void{
            super.init();
            //if (check())
            //{
                //GoogleGames.games.addEventListener("SIGN_IN_SUCCEEDED", onSignedIn);
                //GoogleGames.games.addEventListener("SIGN_IN_FAILED", onSignInFailed);
                //GoogleGames.games.addEventListener("SIGNED_OUT", onSignedOut);
                //GoogleGames.games.addEventListener("SUBMIT_SCORE_SUCCEEDED", onSubmitted);
                //GoogleGames.games.addEventListener("SUBMIT_SCORE_FAILED", onScoreFailed);
                //GoogleGames.games.addEventListener("UNLOCK_ACHIEVEMENT_SUCCEEDED", onUnlocked);
                //GoogleGames.games.addEventListener("UNLOCK_ACHIEVEMENT_FAILED", onUnlockFailed);
                //if (getServiceState())
                //{
                    //GoogleGames.games.signIn();
                //};
            //};
        }
        //override protected function isAuthenticated():Boolean{
            //return (GoogleGames.games.isSignedIn());
        //}
        //override protected function check():Boolean{
            //if (!GoogleGames.isSupported())
            //{
                //return (false);
            //};
            //return (true);
        //}
        //override public function supported():Boolean{
            //return (check());
        //}
        //override public function clicked():void{
            //if (check())
            //{
                //if (!isAuthenticated())
                //{
                    //GoogleGames.games.signIn();
                //}
                //else
                //{
                    //GoogleGames.games.showLeaderboard("CgkIlMDJlNoYEAIQAA");
                //};
            //};
        //}
        //override protected function postScoreHook(score:int):void{
            //GoogleGames.games.submitScore("CgkIlMDJlNoYEAIQAA", score);
            //postAchievementsHook();
        //}
        //override protected function postAchievementsHook():void{
            //var _local_1 = null;
            //var _local_4:int;
            //var _local_3:int;
            //var _local_2 = null;
            //var _local_5:int;
            //if (_achievements != null)
            //{
                //_local_1 = _achievements.keys;
                //_local_3 = _local_1.length;
                //_local_5 = 0;
                //while (_local_5 < _local_3)
                //{
                    //_local_4 = _local_1[_local_5];
                    //_local_2 = _achievements.getValue(_local_4);
                    //if (((_local_2.unlocked) && (!(_local_2.posted))))
                    //{
                        //GoogleGames.games.unlockAchievement(_local_2.code_android);
                    //};
                    //_local_5++;
                //};
            //};
        //}
        //private function onUnlocked(e:GoogleGamesEvent):void{
            //var _local_2 = null;
            //var _local_5:int;
            //var _local_4:int;
            //var _local_3 = null;
            //var _local_6:int;
            //if (_achievements != null)
            //{
                //_local_2 = _achievements.keys;
                //_local_4 = _local_2.length;
                //_local_6 = 0;
                //while (_local_6 < _local_4)
                //{
                    //_local_5 = _local_2[_local_6];
                    //_local_3 = _achievements.getValue(_local_5);
                    //if (_local_3.code_android == e.achievementId)
                    //{
                        //_local_3.posted = true;
                    //};
                    //_local_6++;
                //};
            //};
        //}
        //private function onUnlockFailed(e:GoogleGamesEvent):void{
        //}
        //override public function getMessage():String{
            //return (_message);
        //}
        //private function onSignedIn(e:GoogleGamesEvent):void{
            //_sharedObject.data.gameservice = true;
            //_sharedObject.flush();
            //this.dispatchModelEvent("gameServiceReady");
        //}
        //private function onSignInFailed(e:GoogleGamesEvent):void{
        //}
        //private function onSignedOut(e:GoogleGamesEvent):void{
        //}
        //private function onSubmitted(e:GoogleGamesEvent):void{
        //}
        //private function onScoreFailed(e:GoogleGamesEvent):void{
        //}

    }
}//package service

