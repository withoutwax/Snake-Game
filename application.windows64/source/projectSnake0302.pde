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