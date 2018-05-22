class Log {
  float x;
  float y;
  float logWidth;
  float vx;

  Log(float x, float y, float logWidth, float vx) {  
    this.x = x;
    this.y = y;
    this.logWidth = logWidth;
    this.vx = vx;
  }

  void drawLog() {
    rectMode(CORNER);
    rect(this.x, this.y, this.logWidth, LANE_HEIGHT);   //draws from x,y corner
  }

  void moveLogLeft() {       //decreases x value of log object
    this.x -= this.vx;
  }

  void moveLogRight() {      //increases x value of log object
    this.x += this.vx;
  }

  void obstacleLoopLeft() {    //makes the car obstacles going to the left loop back to the right side of screen
    if (this.x + this.logWidth <= 0) {
      this.x = width;
    }
  }

  void obstacleLoopRight() {   //makes the car obstacles going to the right loop back to the left side of screen
    if (this.x >= width) {
      this.x = 0 - this.logWidth;
    }
  }
  
  boolean on(Player player) {
    return player.x + player.pDiameter >  this.x && player.x + player.pDiameter < this.x + this.logWidth && player.y + (player.pDiameter/2) > this.y && player.y + (player.pDiameter) < this.y + LANE_HEIGHT       //checks if hit by left side of car
      || player.x < this.x + this.logWidth && player.x > this.x && player.y + (player.pDiameter/2) > this.y && player.y + (player.pDiameter) < this.y + LANE_HEIGHT;                                     //checks if hit by right side of car   
  }
}