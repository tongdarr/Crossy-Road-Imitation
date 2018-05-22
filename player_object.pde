class Player {
  float x;
  float y;
  float pDiameter = 40;                    //width and height of the player
  int lives = 3;
  boolean passedLvl1 = false;   //enables the buttons to work
  boolean passedLvl2 = false;   //enables the buttons to work

  Player(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void drawPlayer() {
    ellipseMode(CORNER);
    ellipse(this.x, this.y, pDiameter, pDiameter);
  }

  void gameOver() {
    if (this.lives == 0) {
      background(0);
      fill(255, 0, 0);                   //red colour text
      textSize(50);
      text("GAME OVER", 290, 300);        //text saying game over
      textSize(25);
      text("Press shift to exit or Press k to play again", 190, 400);
      noLoop();
      gameStoppedTime = millis()/1000;
    }
  }

  void resetPlayer() {            //resets position, lives, and passedlvl booleans
    this.x = 430;
    this.y = 557;
    this.lives = 3;
    this.passedLvl1 = false;
    this.passedLvl2 = false;
    playAgainTime = millis()/1000;
    timeLimit += 15 - (time)+(playAgainTime-gameStoppedTime);           //finds the difference between the game over and the time user takes to replay if they want to replay
  }

  void resetPosition() {                        //resets position of player
    this.x = 430;
    this.y = 557;
  }

  void crossedRoad() {                                      //checks if player has crossed the road
    if (this.y < 50) {
      noLoop();
      passedLvl1 = true; 
      background(0);
      fill(0, 255, 0);                                       //green colour text
      textSize(50);
      text("Level 1 Cleared!", 270, 300);                    //text saying game over
      textSize(25);
      text("Press p to play next level", 310, 400);
      gameStoppedTime = millis()/1000;
    }
  }

  void crossedRiver() {                                            //checks if player has crossed the river
    if (passedLvl1) {
      if (this.y < 50) {
        passedLvl2 = true; 
        background(0);
        fill(0, 255, 0);
        textSize(50);
        text("You Win!", 340, 300);
        textSize(25);
        text("Press shift to exit or k to play again", 240, 400);
        noLoop();
        gameStoppedTime = millis()/1000;
      }
    }
  }

  void hitEdgeOfRiverLeft() {                                              //if the player hits the left edge while in the river, they lose a life
    if (this.y - this.pDiameter/2 > 50 && this.y + this.pDiameter/2 < 553) {
      if (this.x < 0) {
        this.lives -= 1;
        resetPosition();
        timeLimit += (15 - time);
      }
    }
  }

  void hitEdgeOfRiverRight() {
    if (this.y - this.pDiameter/2 > 50 && this.y + this.pDiameter/2 < 553) {          //if the player hits the right edge while in the river, they lose a life
      if (this.x + this.pDiameter > width) {
        this.lives -= 1;
        resetPosition();
        timeLimit += (15 - time);
      }
    }
  }
}