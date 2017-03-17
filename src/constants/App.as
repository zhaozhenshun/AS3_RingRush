// Decompiled by AS3 Sorcerer 3.64
// http://www.as3sorcerer.com/

//constants.App

package constants{
    import models.dto.TypeItem;

    public class App {

        public static const SYSTEM_OS:String = "android";
        public static const SYSTEM_IOS:String = "ios";
        public static const SYSTEM_ANDROID:String = "android";
        public static const DEV_STATE:Boolean = false;
        public static const DEV_LEVEL_ID:uint = 1;
        public static const PATH_DATABASE:String = "assets/db/app.sqlite";
        public static const SHARED_OBJECT:String = "ringrush";
        public static const FACEBOOK_APP_ID:String = "658872867511730";
        public static const SHARE_IMAGE_WIDTH:int = 300;
        public static const SHARE_IMAGE_HEIGHT:int = 300;
        public static const ITUNES_CONNECT_APPLE_ID:String = "878644127";
        public static const ITUNES_LEADERBOARD_ID:String = "leaderboardringrush";
        public static const LEADERBOARD_MIN_SCORE:int = 1;
        public static const ITUNES_PRODUCT_ID:String = "net.gvand.ringrush.RemoveAD";
        public static const ANDROID_PUBLIC_KEY:String = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAoR7lnhMBjVbhjuAdYhKPoT/zTwZGd/7szLH0gvnzQAoTK+VSFGLTfywAncYtRou9mdsBCSf8fi3oI12v0+6s3hDzcaCxFvInMPgA7XwLZxtXG+fxoMKWD/tj7+2nyJFJRi+QHU9ryOzj8C+yi6f5GY8FBeKGn0HhKjXmRLzEmhXy8C6XXxtb6VPM//RDPdETj5V1mHiKX2dlGVCOrs4bCpd/uIf0vl/tvjbylsbN48EN0WtdRFvneEBdQ8P4scH23wmcJ94m9mxRL1kBeT/+BX14k/dYdMlBemv1I5ZfWScRznjYWNA49Kd36ZlsDAiD87v0iaeRBRZc7IQNN25vUQIDAQAB";
        public static const PLAY_PRODUCT_ID:String = "remove_ad";
        public static const PLAY_LEADERBOARD_ID:String = "CgkIlMDJlNoYEAIQAA";
        public static const GAME_STATE_INIT:uint = 0;
        public static const GAME_STATE_IDLE:uint = 1;
        public static const GAME_STATE_PAUSED:uint = 2;
        public static const GAME_STATE_DEATH:uint = 3;
        public static const GAME_STATE_SCORED:uint = 4;
        public static const GAME_STATE_START:uint = 5;
        public static const GAME_STATE_TIME_UPDATE:uint = 6;
        public static const GAME_STATE_PROGRESS:uint = 7;
        public static const GAME_STATE_TIME_UP:uint = 8;
        public static const GAME_STATE_OVER:uint = 9;
        public static const GAME_STATE_RESET:uint = 10;
        public static const ELEMENT_TYPE_BASIC:uint = 0;
        public static const ELEMENT_TYPE_BLOCK:uint = 1;
        public static const ELEMENT_TYPE_BOUNCE:uint = 2;
        public static const ELEMENT_TYPE_THROUGH:uint = 3;
        public static const ELEMENT_TYPE_MAGNET:uint = 4;
        public static const ELEMENT_TYPE_TIME:uint = 5;
        public static const ELEMENT_TYPE_ENEMY:uint = 6;
        public static const ELEMENT_TYPE_LASER:uint = 7;
        public static const ELEMENT_TYPE_DIRECTION:uint = 8;
        public static const ELEMENT_TYPE_SPEED_FASTER:uint = 9;
        public static const ELEMENT_TYPE_SPEED_SLOWER:uint = 10;
        public static const ELEMENT_TYPE_DEATH:uint = 11;
        public static const ELEMENT_TYPE_BRICK:uint = 12;
        public static const ELEMENT_TYPE_MORPH:uint = 13;
        public static const ELEMENT_TYPE_STAR:uint = 21;
        public static const DISPLAY_NONE:uint = 0;
        public static const DISPLAY_IMAGE:uint = 1;
        public static const DISPLAY_MOVIECLIP:uint = 2;
        public static const PLAYER_STATE_INIT:uint = 0;
        public static const PLAYER_STATE_IDLE:uint = 1;
        public static const PLAYER_STATE_BASIC:uint = 2;
        public static const PLAYER_STATE_JUMP:uint = 3;
        public static const PLAYER_STATE_DEATH:uint = 4;
        public static const PLAYER_STATE_TIME_UP:uint = 5;
        public static const PLAYER_STATE_RESET:uint = 6;
        public static const RING_COUNT:uint = 3;
        public static const RING_MIN_SPEED:Number = -4;
        public static const RING_MAX_SPEED:Number = 4;
        public static const SEGMENT_TOLERANCE:uint = 30;
        public static const VIEW_TITLE:uint = 0;
        public static const VIEW_IN_GAME:uint = 1;
        public static const VIEW_INFO:uint = 2;
        public static const POPUP_INFO:uint = 0;
        public static const POPUP_SETTINGS:uint = 1;
        public static const POPUP_PURCHASE:uint = 2;
        public static const POPUP_AD:uint = 3;
        public static const POPUP_OFFSET:uint = 30;
        public static const TIME_LEVEL:uint = 4;
        public static const TIME_ELEMENT_UPDATE:uint = 2;
        public static const TIME_CONTROLLER_CHECK:Number = 0.13;
        public static const TIME_IN_GAME_COMPLETE:Number = 0.3;
        public static const TIME_TITLE_COMPLETE:Number = 0.8;
        public static const TIME_TITLE_FACE_DELAY:Number = 3;
        public static const TIME_PLAYER_MOVE_SPEED:Number = 0.15;
        public static const TIME_PLAYER_IDLE_DELAY:Number = 5;
        public static const TIME_POPUP_ANIMATION:Number = 0.3;
        public static const AD_ID_IOS:String = "ca-app-pub-1247813503190157/2013904826";
        public static const AD_ID_ANDROID:String = "ca-app-pub-1247813503190157/3988335622";
        public static const AD_MIN_COUNT:Number = 3;
        public static const AD_MIN_SCORE:Number = 4;
        public static const AD_OWN_COUNT:Number = 4;
        public static const RATEBOX_MIN_SCORE:Number = 12;
        public static const STARS_COUNT:uint = 30;
        public static const STARS_Y_MOVEMENT:uint = 250;
        public static const SOUNDS_SFX_JUMP:String = "sfx_jump";
        public static const SOUNDS_SFX_STAR:String = "sfx_star_pickup";
        public static const SOUNDS_SFX_MENU:String = "sfx_menu";
        public static const SOUNDS_SFX_EXPLOSION:String = "sfx_explosion";
        public static const SOUNDS_SFX_DIRECTION:String = "sfx_changedirection";
        public static const SOUNDS_SFX_SUN:String = "sfx_sun";
        public static const SOUNDS_SFX_BOUNCE:String = "sfx_bounce";
        public static const SOUNDS_SFX_SMASH:String = "sfx_smash";
        public static const SOUNDS_SFX_SPIKES:String = "sfx_spikes";
        public static const SOUNDS_SFX_BRICK:String = "sfx_brick";
        public static const SOUNDS_SFX_COUNT:String = "sfx_counter";
        public static const SOUNDS_SFX_HIGHSCORE:String = "sfx_highscore";
        public static const SOUNDS_MUSIC:String = "music";

        public static var STAGE_ORGINAL_WIDTH:int = 640;
        public static var STAGE_ORGINAL_HEIGHT:int = 960;
        public static var STAGE_WIDTH:int = 0;
        public static var STAGE_HEIGHT:int = 0;
        public static var STAGE_HEIGHT_OFFSET:int = 0;
        public static var STAGE_XPOS:int = 0;
        public static var STAGE_YPOS:int = 0;
        public static var STAGE_SCALE_FACTOR:int = 1;

        public static function elementType(val:*):TypeItem{
            var _local_2:TypeItem = new TypeItem();
            switch (val)
            {
                case 0:
                    _local_2.display = 0;
                    break;
                case 1:
                    _local_2.display = 2;
                    _local_2.textureName = "element_brick_";
                    break;
                case 2:
                    _local_2.display = 2;
                    _local_2.textureName = "element_bouncer_";
                    break;
                case 11:
                    _local_2.display = 1;
                    _local_2.textureName = "element_death";
                    break;
                case 5:
                    _local_2.display = 1;
                    _local_2.textureName = "element_time";
                    break;
                case 8:
                    _local_2.display = 1;
                    _local_2.textureName = "element_direction";
                    break;
                case 12:
                    _local_2.display = 1;
                    _local_2.textureName = "element_block_brick";
                    break;
                case 9:
                    _local_2.display = 1;
                    _local_2.textureName = "element_speed_up";
                    break;
                case 10:
                    _local_2.display = 1;
                    _local_2.textureName = "element_speed_down";
                    break;
                case 13:
                    _local_2.display = 2;
                    _local_2.textureName = "element_morph_";
                    break;
                case 21:
                    _local_2.display = 1;
                    _local_2.textureName = "star";
            };
            return (_local_2);
        }

    }
}//package constants

