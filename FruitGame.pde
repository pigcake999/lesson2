// ===================== Fruit Game v1.0.0 ===================== //
// ------------------------------------------------------------- //
//                  Made by Christian Barton Randall             //
// ============================================================= //
// Definitions                                                   //
// ============================================================= //

int lives = 5;
boolean playing = false;
boolean gameOver = false;
int score = 0;
int finalScore = 0;
Player player = new Player(0, 0, 10);
ArrayList<Fruit> fruit = new ArrayList<Fruit>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
PImage logo;
String[] lines;
int highScore = 0;
float menuZoom = 0;
boolean zoomMode = true;

// ============================================================= //
// Setup Function                                                //
// ============================================================= //

void setup() {
  size(650, 650);
  frameRate(60);
  enemies.add(new Enemy(random(0 - width/2, width/2), random(0 - height/2, height/2), 2.5));
  fruit.add(new Fruit(random(0 - width/2, width/2), random(0 - height/2, height/2)));
  logo = loadImage("fruity.png");
  lines = loadStrings("highscore.txt");
  highScore = int(lines[0]);
}

// ============================================================= //
// Extra Functions                                               //
// ============================================================= //

boolean detectGameOver(int livesLeft) {
  if (livesLeft <= 0) {
    return true;
  } else {
    return false;
  }
}

void zoomAnimation() {
  if (menuZoom < 1) {
    menuZoom = 1;
    zoomMode = true;
  } else if (menuZoom > 14) {
    zoomMode = false;
    menuZoom = 13.5;
  } else if (zoomMode == true) {
    menuZoom = menuZoom * 1.04;
  } else {
    menuZoom = menuZoom * 0.94;
  }
}

// ============================================================= //
// Draw Function                                                 //
// ============================================================= //

void draw() {
  translate(width/2, height/2); // Set 0, 0 to be the middle x and y
  background(0); // Set background to black.

  if (playing) {
    // Game On
    player.update();
    
    // Write Score in top left
    textSize(24); // Set text size to 64px
    textAlign(LEFT); // Align text to center
    fill(46, 139, 87); // Set text colour to a green
    text("Score: " + score, -1 * (width/2)+10, -1 * (height/2)+30);

    // Write Lives in top right
    textSize(24); // Set text size to 64px
    textAlign(RIGHT); // Align text to center
    fill(46, 139, 87); // Set text colour to a green
    text("Lives: " + lives, width/2-10, -1 * (height/2)+30);

    if (frameCount % 120 >= 119) {
       fruit.add(new Fruit(random(0 - width/2, width/2), random(0 - height/2, height/2)));
    }

    for (int i = fruit.size() - 1; i >= 0; i--) {
      Fruit fruitIter = fruit.get(i);
      fruitIter.update(enemies, player);
      if (fruitIter.dead) {
        fruit.remove(i);
      }
    }
    
    for (Enemy enemy : enemies) {
      enemy.update(fruit);
    }

    gameOver = detectGameOver(lives);
    playing = !detectGameOver(lives);
    finalScore = score;
    if (finalScore > highScore) {
      highScore = finalScore;
      lines[0] = str(finalScore);
      saveStrings("highscore.txt", lines);
    }
  } else if (gameOver) {
    // Game Over
    
    textSize(64); // Set text size to 64px
    textAlign(CENTER); // Align text to center
    fill(46, 139, 87); // Set text colour to a green
    text("Game Over", 0, -1 * (height/4));

    textSize(16); // Set text size to 32px
    fill(255, 255, 255); // Set text colour to white
    text("Final Score: " + finalScore, 0, 0);

    textSize(32); // Set text size to 32px
    fill(255, 255, 255); // Set text colour to white
    text("Press space to restart", 0, height/4);
    
    enemies.clear();
    fruit.clear();
    enemies.add(new Enemy(random(0 - width/2, width/2), random(0 - height/2, height/2), 5));
    fruit.add(new Fruit(random(0 - width/2, width/2), random(0 - height/2, height/2)));
    lives = 5;
    score = 0;
    player = new Player(0, 0, 10);
  } else {
    // Main Menu

    textSize(64); // Set text size to 64px
    textAlign(CENTER); // Align text to center
    fill(46, 139, 87); // Set text colour to a green
    imageMode(CENTER);
    image(logo, 0, -1 * (height/4));
    zoomAnimation();
    textSize(24+menuZoom);
    text("High Score: "+str(highScore), 0, 0);

    textSize(32); // Set text size to 32px
    fill(255, 255, 255); // Set text colour to whites
    text("Press space to begin", 0, height/4);
  }
}

// ============================================================= //
// Listeners                                                     //
// ============================================================= //

// Key Released Listener
void keyReleased() {
  if (playing) {
    // Game on
  } else if (gameOver) {
    // Game Over
    if (key == ' ') {
      playing = true;
      gameOver = false;
    }
  } else {
    // Main Menu
    if (key == ' ') {
      playing = true;
    }
  }
}

// Key Pressed Listener
void keyPressed() {
  if (playing) {
    if (key == 'w') {
      if (player.yVel == 0) {
        player.yVel = -20;
      } else {
        player.yVel -= player.playerSpeed;
      }
    } else if (key == 'a') {
      if (player.xVel == 0) {
        player.xVel = -20;
      } else {
        player.xVel -= player.playerSpeed;
      }
    } else if (key == 's') {
      if (player.yVel == 0) {
        player.yVel = 20;
      } else {
        player.yVel += player.playerSpeed;
      }
    } else if (key == 'd') {
      if (player.xVel == 0) {
        player.xVel = 20;
      } else {
        player.xVel += player.playerSpeed;
      }
    }
  } else if (gameOver) {
    // Game Over
  } else {
    // Main Menu
  }
}
