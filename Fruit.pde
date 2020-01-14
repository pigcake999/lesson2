// ============================================================= //
// Fruit Class                                                   //
// ============================================================= //

class Fruit {
  float fruitX, fruitY;
  boolean dead;
  
  public Fruit (float xPos, float yPos) {
    this.fruitX = xPos;
    this.fruitY = yPos;
    this.dead = false;
  }
  
  public void update(ArrayList<Enemy> enemyList, Player playerObject) {
    this.drawFruit();
    
    for (Enemy enemyIter : enemyList) {
      if (dist(enemyIter.enemyX, enemyIter.enemyY, this.fruitX, this.fruitY) < 10) {
        this.die("enemy");
      }
    }
    
    if (dist(this.fruitX, this.fruitY, playerObject.playerX, playerObject.playerY) < 30) {
        this.die("player");
    }
  }
  
  private void drawFruit() {
    fill(0,255,0); // Set colour to green
    ellipse(this.fruitX, this.fruitY, 10, 10); // Draw Fruit
  }
  
  private void die(String enemyOrPlayer) {
    this.dead = true;
    if (enemyOrPlayer == "enemy") {
      lives -= 1;
    } else {
      score += 1;
    }
  }
}
