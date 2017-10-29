class Snake {
  PVector snakeLoc = new PVector((floor(random(b.boardWidth))), (floor(random(b.boardHeight))));
  
  float xDir = 1;
  float yDir = 0;
  int total = 0;
  
  ArrayList<PVector> body = new ArrayList<PVector>();

  
  void render() {
    fill(theme.snake); //HEX# 47FFE8
    stroke(theme.snakeStroke);
    rect(snakeLoc.x*scl, snakeLoc.y*scl, scl, scl);
    
    for (int i = 0; i < body.size(); i++) {
      rect(body.get(i).x*scl, body.get(i).y*scl, scl, scl);
    }
    
  }
  
  boolean eat() {
    float d = dist(snakeLoc.x, snakeLoc.y, f.food.x, f.food.y);
    
    if (d < 1) {
      total++;
      return true;
    } else {
      return false;
    }
  }
  
  
  void death() {
    for (int i = 0; i < body.size(); i++) {
      PVector pos = body.get(i);
      float d = dist(snakeLoc.x, snakeLoc.y, pos.x, pos.y);
      if (d < 1) {
        gameOver();
      }
    }
    if (level > 0) {
      float p;
      for (int i = 0; i < f.poison.size(); i++) {
        p = dist(snakeLoc.x, snakeLoc.y, f.poison.get(i).x, f.poison.get(i).y);

        if (p < 1) {
          gameOver();
        }
      }
    }
  }
  void gameOver() {
    fill(255, 0, 0);
    textSize(30);
    textAlign(CENTER);
    text("GAME OVER", b.boardWidth/2*scl, b.boardHeight/2*scl);
    textAlign(CENTER, TOP);
    text("PRESS 'R' TO RESTART", b.boardWidth/2*scl, b.boardHeight/2*scl);
    body.clear();
    noLoop();
        
    if (score > highScore) {
      highScore = score;
    }
    level = 0; 
  }

  
  void update() {
    if (total > 0) {
      if (total == body.size()) {
        body.remove(0);
      }
      body.add(new PVector(snakeLoc.x, snakeLoc.y));
    } 
    
    snakeLoc.x += (snakeSpeed * xDir);
    snakeLoc.y += (snakeSpeed * yDir);
    
    snakeLoc.x = constrain(snakeLoc.x, 0, b.boardWidth-1);
    snakeLoc.y = constrain(snakeLoc.y, 0, b.boardHeight-1); 

  }
}