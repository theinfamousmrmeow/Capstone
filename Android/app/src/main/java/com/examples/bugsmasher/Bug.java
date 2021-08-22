package com.examples.bugsmasher;

import android.graphics.Bitmap;
import android.graphics.Canvas;


public class Bug extends Enemy {

    // States of a Bug
    enum BugState {
        Dead,
        ComingBackToLife,
        Alive, 			    // in the game
        DrawDead,			// draw dead body on screen
    };

    BugState state;			// current state of bug
    int x,y;				// location on screen (in screen coordinates)
    int scoreValue;         // Points earned when squished
    int hp;                 // Pokes until death

    double speed;			// speed of bug (in pixels per second)
    boolean zigzagger = false;
    boolean leftZigging;
    boolean uberBug;
    //Visuals
    float scale;            // Size of this bug
    int frame=0;
    Bitmap sprite = Assets.roach1;
    // All times are in seconds
    float timeToBirth;		// # seconds till birth
    float startBirthTimer;	// starting timestamp when decide to be born
    float deathTime;		// time of death
    float lastUpdate;		// used to move and animate the bug
    float animationTimer = 0;

    // Bug starts not alive
    public Bug () {
        state = BugState.Dead;
    }

    public void goSuper(){
        hp=4;
        scoreValue*=10;
        uberBug = true;
        Assets.superBugExists=true;
        Assets.superBugTimer = System.nanoTime() / 1000000000f;
        zigzagger=Assets.random.nextBoolean();
        leftZigging=Assets.random.nextBoolean();
    }

    // Bug birth processing
    public void birth (Canvas canvas) {
        //frame = 0;
        // Bring a bug to life?
        if (state == BugState.Dead) {

            //Lose my powers
            if (uberBug){
                Assets.superBugExists=false;
                uberBug=false;
                zigzagger=false;
            }


            // Set it to coming alive
            state = BugState.ComingBackToLife;
            scoreValue=1;
            uberBug = false;
            // Set a random number of seconds before it comes to life
            timeToBirth = (float)Math.random () * 5;
            // Note the current time
            startBirthTimer = System.nanoTime() / 1000000000f;

            float sinceLastSuper = startBirthTimer - Assets.superBugTimer;

            if (!Assets.superBugExists && sinceLastSuper >20 && Assets.random.nextInt(6)==1){
                goSuper();
            }
        }
        // Check if bug is alive yet
        else if (state == BugState.ComingBackToLife) {
            float curTime = System.nanoTime() / 1000000000f;
            // Has birth timer expired?
            if (curTime - startBirthTimer >= timeToBirth) {
                // If so, then bring bug to life
                state = BugState.Alive;
                // Set bug starting location at top of screen
                x = (int)(Math.random() * canvas.getWidth());
                // Keep entire bug on screen
                if (x < Assets.roach1.getWidth()/2)
                    x = Assets.roach1.getWidth()/2;
                else if (x > canvas.getWidth() - Assets.roach1.getWidth()/2)
                    x = canvas.getWidth() - Assets.roach1.getWidth()/2;
                y = 0;
                // Set speed of this bug
                speed = canvas.getHeight() / 4; // no faster than 1/4 a screen per second
                // subtract a random amount off of this so some bugs are a little slower
                speed *= (Math.random())/4d + 0.75d;
                if (uberBug){
                    speed *=0.75d;
                }
                // Record timestamp of this bug being born
                lastUpdate = curTime;
                //animationTimer = 0;
            }
        }
    }

    // Bug movement processing
    public void move (Canvas canvas) {
        // Make sure this bug is alive
        if (state == BugState.Alive) {
            // Get elapsed time since last call here
            float curTime = System.nanoTime() / 1000000000f;
            float elapsedTime = curTime - lastUpdate;
            lastUpdate = curTime;
            animationTimer+=1;

            // Compute the amount of pixels to move (vertically down the screen)
            y += (speed * elapsedTime);
            if (zigzagger){
                if (leftZigging) x-=(speed*elapsedTime);
                else x+=(speed*elapsedTime);

                if (x<canvas.getWidth()*0.1f){
                    leftZigging = false;
                }
                if (x>canvas.getWidth()*0.9f){
                    leftZigging = true;
                }

            }
            // Draw bug on screen

            if (animationTimer>4){
                animationTimer=0;
                frame++;
                if (frame>=Assets.bug_walk.length){
                    frame=0;
                }

            }

            if (!uberBug) canvas.drawBitmap(Assets.bug_walk[frame], x-Assets.roach1.getWidth()/2,  y-Assets.roach1.getHeight()/2, null);
            else canvas.drawBitmap(Assets.superBug_walk[frame], x-Assets.roach1.getWidth()/2,  y-Assets.roach1.getHeight()/2, null);
            // ADD CODE HERE - Draw each frame of animation as appropriate - don't just draw 1 frame
            //Toggle Frames

            // Has it reached the bottom of the screen?
            if (y >= canvas.getHeight()) {
                // Kill the bug
                state = BugState.Dead;
                // Subtract 1 life
                Assets.livesLeft--;
                Assets.soundPool.play(Assets.sound_eat, 1, 1, 1, 0, 1);

            }
        }
    }

    // Process touch to see if kills bug - return true if bug killed
    public boolean touched (Canvas canvas, int touchx, int touchy) {
        boolean touched = false;
        // Make sure this bug is alive
        if (state == BugState.Alive) {
            // Compute distance between touch and center of bug
            float dis = (float)(Math.sqrt ((touchx - x) * (touchx - x) + (touchy - y) * (touchy - y)));
            // Is this close enough for a kill?
            if (dis <= Assets.roach1.getWidth()*0.5f) {
                touched = true;
                hp--;
                if (hp<=0)
                {
                    state = BugState.DrawDead;    // need to draw dead body on screen for a while
                    // Record time of death
                    deathTime = System.nanoTime() / 1000000000f;
                }
            }
        }
        return (touched);
    }

    // Draw dead bug body on screen, if needed
    public void drawDead (Canvas canvas) {
        if (state == BugState.DrawDead) {
            canvas.drawBitmap(Assets.roach3, x-Assets.roach1.getWidth()/2,  y-Assets.roach1.getHeight()/2, null);
            // Get time since death
            float curTime = System.nanoTime() / 1000000000f;
            float timeSinceDeath = curTime - deathTime;
            // Drawn dead body long enough (4 seconds) ?
            if (timeSinceDeath > 4)
                state = BugState.Dead;
        }
    }
    @Override
    public void Draw(Canvas canvas){
        canvas.drawBitmap(sprite, x-Assets.roach1.getWidth()/2,  y-Assets.roach1.getHeight()/2, null);
        //canvas.drawBitmap(Assets.roach1, x-Assets.roach1.getWidth()/2,  y-Assets.roach1.getHeight()/2, null);
    }

}
