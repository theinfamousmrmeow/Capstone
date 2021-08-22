package com.examples.bugsmasher;

import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.media.SoundPool;
import android.preference.PreferenceManager;
import android.widget.TextView;

import java.util.Random;
import android.content.Context;
import android.media.MediaPlayer;


public class Assets {
    static int MAX_BUGS = 10;
    static Bitmap background;
    static Bitmap scorebar;
    static Bitmap lives;
    static Bitmap roach1;
    static Bitmap[] bug_walk = new Bitmap[2];
    static Bitmap[] superBug_walk = new Bitmap[2];
    static Bitmap roach2;
    static Bitmap roach3;
    static Random random = new Random();
    static boolean musicPlaying = false;

    // States of the Game Screen
    enum GameState {
        GettingReady,	// play "get ready" sound and start timer, goto next state
        Starting,		// when 3 seconds have elapsed, goto next state
        Running, 		// play the game, when livesLeft == 0 goto next state
        GameEnding,	    // show game over message
        GameOver,		// game is over, wait for any Touch and go back to title activity screen
    };
    static GameState state;		// current state of the game
    static float gameTimer;	    // in seconds
    static float superBugTimer;
    static int livesLeft;		// 0-3
    static int score;
    static int highScore = 0;
    static boolean superBugExists;

    static SoundPool soundPool;
    static MediaPlayer mediaPlayer;
    static int sound_getready;
    static int sounds_squash[];
    static int bgm_main;
    static int sound_squish;
    static int sound_squish2;
    static int sound_eat;
    static int sound_squish3;
    static int sound_thump;
    static int sound_highscore;
    static int sound_ubersquash;

    //static Bug[] bug; // try using an array of bugs instead of only 1 bug (so you can have more than 1 on screen at a time)
    static Bug[] bugs = new Bug[MAX_BUGS];
    static Bug bug; // try using an array of bugs instead of only 1 bug (so you can have more than 1 on screen at a time)

    static void loadData (Canvas canvas) {

    }

    static void createMediaPlayer(Context context){
        mediaPlayer = MediaPlayer.create(context, R.raw.battle_of_pogs);
    }

    static void startMusic(){



        //soundPool.play(bgm_main, 1, 1, 1, 0, 1);

        try{
        //mediaPlayer.prepare();
        mediaPlayer.setLooping(true);
        mediaPlayer.start();
        musicPlaying = true;
        }
        catch (Exception e){
            //Didn't work...
        }



    }

    static void stopMusic(){
        mediaPlayer.stop();
        musicPlaying = false;
    }

    static boolean isNewHighScore(int _score, Context context){

        SharedPreferences preferences = PreferenceManager.getDefaultSharedPreferences(context);
        highScore = preferences.getInt("highscore",0);

        if (_score > highScore){return true;}
        else {return false;}
    }

    static void setNewHighScore(int _score, Context context){
        //Set new high score.
        highScore = _score;

        SharedPreferences preferences = PreferenceManager.getDefaultSharedPreferences(context);
        SharedPreferences.Editor editor = preferences.edit();
        editor.putInt("highscore",score);
        editor.apply();

    }
}
