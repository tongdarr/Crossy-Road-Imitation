class Car {  
  float x;
  float y;
  float carWidth;
  float vx;  //velocity


  Car(float x, float y, float carWidth, float vx) {  
    this.x = x;
    this.y = y;
    this.carWidth = carWidth;
    this.vx = vx;
  }

  void drawCar() {
    ellipseMode(CORNER);
    ellipse(this.x, this.y, this.carWidth, LANE_HEIGHT);   //draws from x,y corner
  }

  void moveCarLeft() {       //decreases x value of car object
    this.x -= this.vx;
  }

  void moveCarRight() {      //increases x value of car object
    this.x += this.vx;
  }

  void obstacleLoopLeft() {    //makes the car obstacles going to the left loop back to the right side of screen
    if (this.x + this.carWidth <= 0) {
      this.x = width;
    }
  }

  void obstacleLoopRight() {   //makes the car obstacles going to the right loop back to the left side of screen
    if (this.x >= width) {
      this.x = 0 - this.carWidth;
    }
  }

  void hitObstacles(Player player) {
    if (player.x + player.pDiameter >  this.x && player.x + player.pDiameter < this.x + this.carWidth && player.y + (player.pDiameter/2) > this.y && player.y + (player.pDiameter) < this.y + 50       //checks if hit by left side of car
      || player.x < this.x + this.carWidth && player.x > this.x && player.y + (player.pDiameter/2) > this.y && player.y + (player.pDiameter) < this.y + 50) {                                          //checks if hit by right side of car        
      player.resetPosition();
      player.lives -= 1;
      timeLimit += (15 - time);
    }
  }
}