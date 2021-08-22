package com.examples.bugsmasher;

import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;

import android.view.View;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;
import android.widget.TextView;

public class HighScoreTableActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_high_score_table);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        SharedPreferences preferences = PreferenceManager.getDefaultSharedPreferences(this);
        SharedPreferences.Editor editor = preferences.edit();

        int highscore = preferences.getInt("highscore",0);

        TextView highscoreText = (TextView) findViewById(R.id.textView);
        CharSequence charSequence = "Current: " + String.valueOf(highscore);
        highscoreText.setText(charSequence);





    }

}
