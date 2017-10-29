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