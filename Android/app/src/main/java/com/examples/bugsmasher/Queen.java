package com.examples.bugsmasher;

import java.util.ArrayList;
import java.util.Collections;

public class Queen implements Comparable<Queen> {
    int fitnessScore=0;
    ArrayList<SpawnPoint> chromosone = new ArrayList<>(9);
    //Chromosone design is a little weird, because its actually a sequential list of moves.
    //Player takes the next available move out of his chromosone.

    Queen(){
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                chromosone.add(new SpawnPoint(i,j));
            }
        }
        //Randomize the moveset!
        Collections.shuffle(chromosone);
    }

    Queen(Queen father, Queen mother, int crossover){
        chromosone = new ArrayList<>(9);
        for (int i = 0; i < 9; i++) {
            if (i<crossover){
                chromosone.add(i,father.chromosone.get(i));
            }
            else {
                chromosone.add(i,mother.chromosone.get(i));
            }
        }
    }

//    public void printChromosones(){
//        Board example = new Board();
//        int i = 1;
//        for (Move m:chromosone) {
//            example.spaces[m.x][m.y]=i;
//            i++;
//        }
//        example.printBoard();
//    }



    /**
     * Returns how much better or worse I am than the compared Player.
     */
    public int compareTo(Queen o) {
        return fitnessScore-o.fitnessScore;
    }

}
