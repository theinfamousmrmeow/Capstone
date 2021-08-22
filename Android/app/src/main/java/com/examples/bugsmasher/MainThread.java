package com.examples.bugsmasher;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.os.Handler;
import android.view.SurfaceHolder;
import android.widget.Toast;

public class MainThread extends Thread {
    private SurfaceHolder holder;
    private Handler handler;		// required for running code in the UI thread
    private boolean isRunning = false;
    Context context;
    Paint paint;
    int touchx, touchy;	// x,y of touch event
    boolean touched;	// true if touch happened
    boolean data_initialized;
    private static final Object lock = new Object();

    public void getScore(int _score){
        Assets.score += _score;
    }



    public MainThread (SurfaceHolder surfaceHolder, Context context) {
        holder = surfaceHolder;
        this.context = context;
        handler = new Handler();
        data_initialized = false;
        touched = false;
    }

    public void setRunning(boolean b) {
        isRunning = b;	// no need to synchronize this since this is the only line of code to writes this variable
    }

    // Set the touch event x,y location and flag indicating a touch has happened
    public void setXY (int x, int y) {
        synchronized (lock) {
            touchx = x;
            touchy = y;
            this.touched = true;
        }
    }

    @Override
    public void run() {
        while (isRunning) {
            // Lock the canvas before drawing
            Canvas canvas = holder.lockCanvas();
            if (canvas != null) {
                // Perform drawing operations on the canvas
                render(canvas);
                // After drawing, unlock the canvas and display it
                holder.unlockCanvasAndPost (canvas);
            }
        }
    }

    // Loads graphics, etc. used in game
    private void loadData (Canvas canvas) {
        Bitmap bmp;
        int newWidth, newHeight;
        float scaleFactor;


        // Create a paint object for drawing vector graphics
        paint = new Paint();

        // Load score bar
        // ADD CODE HERE

        // Load food bar
        bmp = BitmapFactory.decodeResource (context.getResources(), R.drawable.wood);
        // Compute size of bitmap needed (suppose want height = 10% of screen height)
        newHeight = (int)(canvas.getHeight() * (1f/12f));
        // Scale it to a new size
        Assets.scorebar = Bitmap.createScaledBitmap (bmp, canvas.getWidth(), newHeight, false);
        // Delete the original
        bmp = null;

        // Load roach1
        bmp = BitmapFactory.decodeResource (context.getResources(), R.drawable.bug1);
        // Compute size of bitmap needed (suppose want width = 20% of screen width)
        newWidth = (int)(canvas.getWidth() * 0.2f);
        // What was the scaling factor to get to this?
        scaleFactor = (float)newWidth / bmp.getWidth();
        // Compute the new height
        newHeight = (int)(bmp.getHeight() * scaleFactor);
        // Scale it to a new size
        Assets.bug_walk[0] = Bitmap.createScaledBitmap (bmp, newWidth, newHeight, false);
        Assets.superBug_walk[0] = Bitmap.createScaledBitmap (bmp, (int)(newWidth*1.25), (int)(newHeight*1.25), false);
        Assets.roach1 =  Bitmap.createScaledBitmap (bmp, newWidth, newHeight, false);
        // Delete the original
        bmp = null;

        // Load the other bitmaps similarly
        // Load roach1
        bmp = BitmapFactory.decodeResource (context.getResources(), R.drawable.bug2);
        // Compute size of bitmap needed (suppose want width = 20% of screen width)
        newWidth = (int)(canvas.getWidth() * 0.2f);
        // What was the scaling factor to get to this?
        scaleFactor = (float)newWidth / bmp.getWidth();
        // Compute the new height
        newHeight = (int)(bmp.getHeight() * scaleFactor);
        // Scale it to a new size
        Assets.bug_walk[1] = Bitmap.createScaledBitmap (bmp, newWidth, newHeight, false);
        Assets.superBug_walk[1] = Bitmap.createScaledBitmap (bmp, (int)(newWidth*1.25), (int)(newHeight*1.25), false);
        // Delete the original
        bmp = null;

        // Load roach3 (dead bug)
        bmp = BitmapFactory.decodeResource (context.getResources(), R.drawable.bug3);
        // Compute size of bitmap needed (suppose want width = 20% of screen width)
        newWidth = (int)(canvas.getWidth() * 0.2f);
        // What was the scaling factor to get to this?
        scaleFactor = (float)newWidth / bmp.getWidth();
        // Compute the new height
        newHeight = (int)(bmp.getHeight() * scaleFactor);
        // Scale it to a new size
        Assets.roach3 = Bitmap.createScaledBitmap (bmp, newWidth, newHeight, false);
        // Delete the original
        bmp = null;

        // Load Live Icon
        bmp = BitmapFactory.decodeResource (context.getResources(), R.drawable.life_apple);
        // Compute size of bitmap needed (suppose want width = 20% of screen width)
        newWidth = (int)(canvas.getWidth() * 0.1f);
        // What was the scaling factor to get to this?
        scaleFactor = (float)newWidth / bmp.getWidth();
        // Compute the new height
        newHeight = (int)(bmp.getHeight() * scaleFactor);
        // Scale it to a new size
        Assets.lives = Bitmap.createScaledBitmap (bmp, newWidth, newHeight, false);
        // Delete the original
        bmp = null;
        // Spawn my bugs
        Assets.bug = new Bug();
        for (int i=0;i<Assets.bugs.length;i++){
            Assets.bugs[i] = new Bug();
        }
    }

    // Load specific background screen
    private void loadBackground (Canvas canvas, int resId) {
        // Load background
        Bitmap bmp = BitmapFactory.decodeResource (context.getResources(), resId);
        // Scale it to fill entire canvas
        Assets.background = Bitmap.createScaledBitmap (bmp, canvas.getWidth(), canvas.getHeight(), false);
        // Delete the original
        bmp = null;
    }

    private void render (Canvas canvas) {
        int i, x, y;

        if (! data_initialized) {
            loadData(canvas);
            data_initialized = true;
        }

        switch (Assets.state) {
            case GettingReady:
                loadBackground (canvas, R.drawable.background);
                Assets.superBugExists=false;
                Assets.superBugTimer = 0;
                // Draw the background screen
                canvas.drawBitmap (Assets.background, 0, 0, null);
                // Play a sound effect
                Assets.soundPool.play(Assets.sound_getready, 1, 1, 1, 0, 1);
                // Start a timer
                Assets.gameTimer = System.nanoTime() / 1000000000f;
                // Go to next state
                Assets.state = Assets.GameState.Starting;

                break;
            case Starting:
                // Draw the background screen

                canvas.drawBitmap (Assets.background, 0, 0, null);
                // Has 3 seconds elapsed?
                float currentTime = System.nanoTime() / 1000000000f;
                Assets.score = 0;
                if (currentTime - Assets.gameTimer >= 3)
                    // Goto next state
                    Assets.state = Assets.GameState.Running;


                //Start BGM
                if (!Assets.musicPlaying) Assets.startMusic();

                break;


            case Running:
                // Draw the background screen
                canvas.drawBitmap (Assets.background, 0, 0, null);
                // Draw the score bar at top of screen
                // ADD CODE HERE
                // Draw the foodbar at bottom of screen

                // Draw one circle for each life at top right corner of screen
                // Let circle radius be 5% of width of screen

                // Process a touch
                if (touched) {
                    // Set touch flag to false since we are processing this touch now
                    touched = false;
                    // See if this touch killed a bug
                    //TODO:  Loops through all bugs.

                    boolean bugTouched = false;
                    Bug currentBug = null;
                    for (i=0;i<Assets.bugs.length;i++) {
                        currentBug = Assets.bugs[i];

                        bugTouched = currentBug.touched(canvas, touchx, touchy);
                        if (bugTouched) {
                            i=1000;
                        }
                    }
                    if (bugTouched && currentBug != null){
                        //currentBug.hp--;

                        boolean bugKilled = (currentBug.hp<=0);

                        //Check if he is dead.
                        if (bugKilled) {
                            if (currentBug.uberBug) Assets.soundPool.play(Assets.sound_ubersquash, 1, 1, 1, 0, 1);
                                else Assets.soundPool.play(Assets.sounds_squash[Assets.random.nextInt(3)], 1, 1, 1, 0, 1);
                            getScore(currentBug.scoreValue);
                        }
                        else
                            Assets.soundPool.play(Assets.sounds_squash[0], 1, 1, 1, 0, 1);
                        }

                        if (!bugTouched){

                                //Missed!
                                Assets.soundPool.play(Assets.sound_thump, 1, 1, 1, 0, 1);

                        }

                }

                // ADD MORE CODE HERE TO PLAY GAME


                // Draw dead bugs on screen
                for (i=0;i<Assets.bugs.length;i++){
                    Assets.bugs[i].drawDead(canvas);
                }

                for (i=0;i<Assets.bugs.length;i++){
                    Assets.bugs[i].move(canvas);
                    Assets.bugs[i].birth(canvas);
                }

//              //DRAW HUD
                canvas.drawBitmap (Assets.scorebar, 0, 0, null);
                int radius = (Assets.lives.getWidth());
                int spacing = 2; // spacing in between circles
                x = canvas.getWidth() - radius - spacing;	// coordinates for rightmost circle to draw
                y = radius/4 + spacing;
                for (i=0; i<Assets.livesLeft; i++) {
                    canvas.drawBitmap (Assets.lives, x, y, null);
                    x -= (radius + spacing);
                }
                //Draw Score
                Paint paint = new Paint();
                //paint.setColor(Color.WHITE);
                //paint.setStyle(Paint.Style.FILL);
                //canvas.drawPaint(paint);

                paint.setColor(Color.WHITE);

                paint.setTextSize(70);
                paint.setFakeBoldText(true);
                canvas.drawText(String.valueOf(Assets.score), (canvas.getWidth()*0.08f), canvas.getHeight()*0.06f, paint);
                //
                // Are no lives left?
                if (Assets.livesLeft == 0)
                    // Goto next state
                    Assets.state = Assets.GameState.GameEnding;
                break;
            case GameEnding:


                // Show a game over message

                handler.post(new Runnable() {
                    public void run() {
                        Toast.makeText(context, "Game Over", Toast.LENGTH_SHORT).show();
                    }
                });
                Assets.stopMusic();

                //Check high score

                //Check new high score
                if (Assets.isNewHighScore(Assets.score, context)){
                    Assets.setNewHighScore(Assets.score, context);
                    //Toast.makeText(context, "New High Score!", Toast.LENGTH_SHORT).show();
                    Assets.soundPool.play(Assets.sound_highscore, 1, 1, 1, 0, 1);
                    handler.post(new Runnable() {
                        public void run() {
                            Toast.makeText(context, "New High Score!", Toast.LENGTH_SHORT).show();
                        }
                    });

                }

                // Goto next state
                Assets.state = Assets.GameState.GameOver;
                break;
            case GameOver:
                // Fill the entire canvas' bitmap with 'black'
                canvas.drawColor(Color.BLACK);
                isRunning = false;


                //
                //
                //Assets.state = Assets.GameState.Starting;
                // }
                //Back to title Screen
                //return;
                break;
        }
    }
}
