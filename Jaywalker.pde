int size = 10;
ArrayList<Car>[] cars = new ArrayList[size];
ArrayList<Log>[] logs = new ArrayList[size];
int initialTime;
float speed = 1;
final int LANE_HEIGHT = 50;
Player player = new Player(430, 557);
int timeLimit = 15;
int time;
int gameStoppedTime;                                 //time till game is stopped and at a point where you must press a button to continue
int playAgainTime;                            //time till game starts after being stopped 


void setup() {
  size(900, 650);
  initialTime = millis();                
  for ( int i = 0; i < size; i++) {                            //creates array of arraylist of car objects                 
    cars[i] = new ArrayList<Car>();
  }
  for (int i = 0; i < 10; i++) {
    if (i == 0) speed = 1;
    if (i == 1) speed = 2;
    if (i == 2) speed = 1.5;
    if (i == 3) speed = 1.7;
    if (i == 4) speed = 3;
    if (i == 5) speed = 2.8;
    if (i == 6) speed = 1.75;
    if (i == 7) speed = 1.25;
    if (i == 8) speed = 2.3;
    if (i == 9) speed = 1;    
    int number = 4;
    if (speed > 2) number = 3;
    for (int j = 0; j < number; j++) {
      cars[i].add(new Car((50+ 250*j), 500-(50*i), 80, speed));
    }
  }   
  for ( int i = 0; i < size; i++) {                             //creates array of arraylist of log objects     
    logs[i] = new ArrayList<Log>();
  }
  for (int i = 0; i < 10; i++) {
    if (i == 0) speed = 1;
    if (i == 1) speed = 2.75;
    if (i == 2) speed = 1.5;
    if (i == 3) speed = 1.8;
    if (i == 4) speed = 1.6;
    if (i == 5) speed = 2.25;
    if (i == 6) speed = 1.9;
    if (i == 7) speed = 2.2;
    if (i == 8) speed = 1;
    if (i == 9) speed = 2.5;    
    int number = 3;
    if (speed > 2) number = 2;
    for (int j = 0; j < number; j++) {
      logs[i].add(new Log((50+ 300*j), 500-(50*i), 130, speed));
    }
  }
}

void draw() {
  if (player.passedLvl1 == false) {                              //while player is still on first level
    background(0);
    fill(0, 255, 0);                                      
    rect(0, 555, width, 50);                                    //draws green rect platform where player starts
    rect(0, 0, width, 50);                                      //where the player must reach
    fill(255, 0, 0);
    player.drawPlayer();
    fill(255);
    int currentTime=millis();
    if (currentTime > 20000) {
    }
    time =  (timeLimit - (currentTime-initialTime)/1000);   
    textSize(50);                                                //text for lives and time remaining
    text("Lives : " + player.lives, 0, 650);
    text("Time Remaining: " + time, 300, 650);
    if (time <= 0) {                                          //if u run out of time, lose a life and reset player position and time
      player.resetPosition();
      player.lives -= 1;
      timeLimit += (15-time);
    }

    for (int i = 0; i < size; i++) {                              //outer loop is array of arraylists
      for (int j = 0; j < cars[i].size(); j++) {                  //inner loop is arraylist of cars
        if (i%2 == 0) {
          cars[i].get(j).moveCarRight();
          cars[i].get(j).obstacleLoopRight();
        } else {
          cars[i].get(j).moveCarLeft();
          cars[i].get(j).obstacleLoopLeft();
        }        
        cars[i].get(j).drawCar();
        cars[i].get(j).hitObstacles(player);
      }
    }    
    player.gameOver();  
    player.crossedRoad();
  } else {                                                    //if user passed level 1 then proceed to level 2
    background(0);
    fill(0, 255, 0);
    rect(0, 555, width, 50);                                 //draws green rect platform where player starts
    rect(0, 0, width, 50);                                    //where the player must reach
    fill(0, 0, 255);
    rect(0, 50, width, 503); 
    fill(255);
    int currentTime=millis();
    time =  (timeLimit - (currentTime-initialTime)/1000);   
    textSize(50);
    text("Time Remaining: " + time, 300, 650);
    if (time <= 0) {                                          //if user runs out of time, reset time,
      player.resetPosition();
      player.lives -= 1;
      timeLimit += (15-time);
    }
    text("Lives : " + player.lives, 0, 650);
    fill(165, 70, 70);
    for (int i = 0; i < size; i++) {                      //nested loop responsible for moving log/player on log and detecting whether or not
      for (int j = 0; j < logs[i].size(); j++) {
        if (i%2 == 0) {
          logs[i].get(j).moveLogRight();
          logs[i].get(j).obstacleLoopRight();
          if (logs[i].get(j).on(player)) {
            player.x += logs[i].get(j).vx;
          }
          player.hitEdgeOfRiverRight();
        } else {
          logs[i].get(j).moveLogLeft();
          logs[i].get(j).obstacleLoopLeft();
          if (logs[i].get(j).on(player)) {
            player.x -= logs[i].get(j).vx;
          }
          player.hitEdgeOfRiverLeft();
        }        
        logs[i].get(j).drawLog();
        boolean onLog = false;
        for (ArrayList<Log> logList : logs) {
          for (Log logObjects : logList) {
            if (logObjects.on(player)) {
              onLog = true;
              break;
            }
          }
        }
        if (onLog == false && player.y - player.pDiameter/2 > 50 && player.y + player.pDiameter/2 < 553) {        //checks if player is on the log or not
          player.resetPosition();
          player.lives -= 1;
          timeLimit += (15 - time);
        }
      }
    }
    fill(255, 0, 0);
    player.drawPlayer();
    player.gameOver();
    player.crossedRiver();
  }
}


void keyPressed() {                          //keys to control the player
  if (key == CODED) {
    if (keyCode == UP) {
      player.y -= 50;
    }
    if (keyCode == DOWN) {
      player.y += 50;
      if (player.y + player.pDiameter > 600) {
        player.y -= 50;
      }
    }
    if (keyCode == LEFT) {
      player.x -= 50;
      if (player.x < 0) {
        player.x += 50;
      }
    }
    if (keyCode == RIGHT) {
      player.x += 50;
      if (player.x + player.pDiameter > width) {
        player.x -= 50;
      }
    }
  }

  if (player.lives == 0) {                  //allows user to leave game w/o pressing the x at the top right
    if (keyCode == SHIFT) {      
      exit();
    }
  }
  if (player.passedLvl2 == true) {        //allows user to leave game w/o pressing the x at the top right
    if (keyCode == SHIFT) {      
      exit();
    }
  }
  if (player.passedLvl2 == true) {        //allows user to play game again if they have won already
    if (key == 'k') {      
      loop();
      player.resetPlayer();
    }
  }
  if (player.lives == 0) {
    if (key == 'k') {                      //resets the game by resetting the players lives and original x, y position if user loses      
      loop();
      player.resetPlayer();
    }
  }
  if (player.passedLvl1 == true) {
    if (key == 'p') {    
      loop();      
      player.resetPosition();
      playAgainTime = millis()/1000;
      timeLimit += 15 - (time)+(playAgainTime-gameStoppedTime);           //finds the difference between the game over and the time user takes to replay if they want to replay
    }
  }
}