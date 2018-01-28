PFont gotham;
Board b;
Snake snake;
Food f;
Theme theme;

int scl = 20;
float snakeSpeed = 1;
int score = 0;
int highScore = 0;
int level = 0;


void setup() {
  size(900, 800);
  theme = new Theme();
  theme.theme01();
  gotham = createFont("Gotham-Bold.otf", 12);
  textFont(gotham);
  b = new Board(30, 30);
  snake = new Snake();
  f = new Food();
  frameRate(5);


}


void draw() {
  background(0, 0, 0);
  translate((width/2)-((b.boardHeight/2)*scl)-100, (height/2)-((b.boardHeight/2)*scl));
  noStroke();
  scoreBoard();

  b.render();
  b.level();
  f.render();

  snake.update();
  snake.render();
  snake.death();

  f.foodLocation();

}



void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      snake.xDir = 0;
      snake.yDir = -1;
    } else if (keyCode == DOWN) {
      snake.xDir = 0;
      snake.yDir = 1;
    } else if (keyCode == LEFT) {
      snake.xDir = -1;
      snake.yDir = 0;
    } else if (keyCode == RIGHT) {
      snake.xDir = 1;
      snake.yDir = 0;
    }
  }
  //RESTART
  if (key == 'r') {
    setup();
    loop();
    score = 0;
  } else if (key == 'p') {
    noLoop();
  } else if (key == 'o') {
    loop();
  }

  // THEME CONTROL
  else if (key == '1') {
    theme.theme01();
  } else if (key == '2') {
    theme.theme02();
  } else if (key == '3') {
    theme.theme03();
  } else if (key == '4') {
    theme.theme04();
  } else if (key == '5') {
    theme.theme05();
  }
}

void scoreBoard() {
  int textLocx = (b.boardWidth+1)*scl;
  int textLocy = 20;

  //SCOREBOARD
  fill(255);
  textAlign(LEFT);
  text("SCORE: ", textLocx, textLocy);
  text(score, textLocx+50, textLocy);
  text("HIGH SCORE: ", textLocx, textLocy+15);
  text(highScore, textLocx+85, textLocy+15);
  text("CONTROLS: ", textLocx, textLocy+30);
  text("PAUSE: P", textLocx, textLocy+55);
  text("PLAY: O", textLocx, textLocy+70);
  text("LEVEL:", textLocx, textLocy+95);
  text(level, textLocx+45, textLocy+95);

  //ITEM INFO
  fill(theme.food);
  rect(textLocx, textLocy+110, scl, scl);
  text("FOOD", textLocx+scl+5, textLocy+122);

  fill(theme.snake);
  rect(textLocx, textLocy+135, scl, scl);
  text("SNAKE", textLocx+scl+5, textLocy+147);

  stroke(theme.poisonStroke);
  fill(theme.poison);
  rect(textLocx, textLocy+160, scl, scl);
  text("POISON", textLocx+scl+5, textLocy+172);


  //THEME INFO
  fill(71, 255, 232);
  rect(textLocx, textLocy+250, scl, scl);
  text("THEME 01: SCI-FI", textLocx+scl+5, textLocy+262);

  fill(247, 127, 127);
  rect(textLocx, textLocy+275, scl, scl);
  text("THEME 02: SIMPLE", textLocx+scl+5, textLocy+287);

  stroke(87, 95, 104, 255);
  fill(0, 0, 0);
  rect(textLocx, textLocy+300, scl, scl);
  fill(87, 95, 104);
  text("THEME 03: BLACK & WHITE", textLocx+scl+5, textLocy+312);

  noStroke();
  fill(36, 58, 134);
  rect(textLocx, textLocy+325, scl, scl);
  text("THEME 04: PIPE", textLocx+scl+5, textLocy+337);

  fill(159, 220, 210);
  rect(textLocx, textLocy+350, scl, scl);
  text("THEME 05: GREEN ROBOT", textLocx+scl+5, textLocy+362);
}


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

class Board {
  int boardWidth;
  int boardHeight;
  int currentScore = 0;

  Board(int w, int h) {
    boardWidth = w;
    boardHeight = h;
  }

  void render() {
    noStroke();
    fill(theme.background); //HEX# 2B2E32
    rect(0, 0, b.boardWidth*scl, b.boardHeight*scl);
  }

  void level() {
    if (currentScore == 5) {
      level++;
      f.currentLevel++;
      currentScore = 0;
    }
  }

}

class Food {
  PVector food = new PVector((floor(random(b.boardWidth))), (floor(random(b.boardHeight))));
  //PVector poison = new PVector((floor(random(b.boardWidth))), (floor(random(b.boardHeight))));
  ArrayList<PVector> poison = new ArrayList<PVector>();

  int currentLevel = 0;

  void render() {
    stroke(theme.foodStroke);
    fill(theme.food); //HEX# F77F7F
    rect(food.x*scl, food.y*scl, scl, scl);

    if (currentLevel == 1) {
      poison.add(new PVector((floor(random(b.boardWidth))), (floor(random(b.boardHeight)))));
      //for (int i = 0; i < poison.size(); i++) {
      //  rect(poison.get(i).x*scl, poison.get(i).y*scl, scl, scl);
      //}


      currentLevel = 0;
    }

    stroke(theme.poisonStroke);
    fill(theme.poison); //HEX# 575F68
    for (PVector p : poison) {
        rect(p.x*scl, p.y*scl, scl, scl);
    }


  }

  void foodLocation() {

    if (snake.eat() == true) {
      score ++;
      b.currentScore++;

      food.x = (floor(random(b.boardHeight)));
      food.y = (floor(random(b.boardWidth)));
    }

    food.x = constrain(food.x, 0, b.boardHeight-1);
    food.y = constrain(food.y, 0, b.boardWidth-1);

  }


}

class Theme {

  color background;
  color poison;
  color poisonStroke;
  color snake;
  color snakeStroke;
  color food;
  color foodStroke;

  color poisonText;

  //THEME #1 - SCHI-FI
  void theme01 () {
    background = color(43, 46, 50);
    poison = color(87, 95, 104);
    poisonStroke = color(255, 255, 255, 0);
    snake = color(71, 255, 232);
    snakeStroke = color(255, 255, 255, 0);
    food = color(247, 127, 127);
    foodStroke = color(255, 255, 255, 0);

    poisonText = color(87, 95, 104);
  }

  //THEME #2 - SIMPLE
  void theme02 () {
    background = color(242, 242, 242);
    poison = color(87, 95, 104);
    poisonStroke = color(255, 255, 255, 0);
    snake = color(242, 242, 242);
    snakeStroke = color(0, 255);
    food = color(247, 127, 127);
    foodStroke = color(255, 255, 255, 0);

    poisonText = color(87, 95, 104);
  }

  //THEME #3 - B/W
  void theme03 () {
    background = color(242, 242, 242);
    poison = color(26, 26, 26);
    poisonStroke = color(87, 95, 104, 255);
    snake = color(77, 77, 77);
    snakeStroke = color(255, 255, 255, 0);
    food = color(255, 255, 255);
    foodStroke = color(0, 0, 0, 255);

    poison = color(87, 95, 104);
  }

  //THEME #4 - PIPE
  void theme04 () {
    background = color(216, 233, 245);
    poison = color(36, 58, 134);
    poisonStroke = color(255, 255, 255, 0);
    snake = color(255, 255, 255);
    snakeStroke = color(40, 45, 132, 255);
    food = color(190, 23, 78);
    foodStroke = color(255, 255, 255, 0);

    poison = color(36, 58, 134);
  }

  //THEME #5 - GREEN ROBOT
  void theme05 () {
    background = color(159, 220, 210);
    poison = color(247, 127, 127);
    poisonStroke = color(255, 255, 255, 0);
    snake = color(255, 237, 164);
    snakeStroke = color(255, 255, 255, 0);
    food = color(56, 182, 192);
    foodStroke = color(255, 255, 255, 0);

    poison = color(247, 127, 127);
  }
}
