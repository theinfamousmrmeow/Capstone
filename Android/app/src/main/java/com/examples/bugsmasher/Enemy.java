package com.examples.bugsmasher;

import android.graphics.Canvas;

public class Enemy extends Entity{

    int cost;
    int x;
    int y;


    @Override
    public void Draw(Canvas canvas){
        canvas.drawBitmap(Assets.roach1, x-Assets.roach1.getWidth()/2,  y-Assets.roach1.getHeight()/2, null);
    }

}
