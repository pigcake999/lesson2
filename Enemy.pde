// ============================================================= //
// Enemy Class                                                   //
// ============================================================= //

class Enemy {
  float enemyX, enemyY, enemySpeed;
  
  public Enemy (float xPos, float yPos, float speed) {
    this.enemyX = xPos;
    this.enemyY = yPos;
    this.enemySpeed = speed;
  }
  
  public void update(ArrayList<Fruit> fruitList) {
    this.drawEnemy();
    this.moveEnemy(fruitList);
  }
  
  private void drawEnemy() {
    fill(255,0,0); // Set colour to red
    ellipse(this.enemyX, this.enemyY, 30, 30); // Draw Fruit
  }
  
  private void moveEnemy(ArrayList<Fruit> fruitList) {
    float closestX = -1000;
    float closestY = -1000;
    
    for (Fruit fruitIter : fruitList) {
      if (closestX == -1000 && closestY == -1000) {
        closestX = fruitIter.fruitX;
        closestY = fruitIter.fruitY;
      } else {
        if (dist(closestX,closestY,this.enemyX, this.enemyY) > dist(fruitIter.fruitX, fruitIter.fruitY, this.enemyX, this.enemyY)) {
          closestX = fruitIter.fruitX;
          closestY = fruitIter.fruitY;
        }
      }
    }
    
    float distance = dist(closestX,closestY,this.enemyX, this.enemyY);
    
    float moveX = (closestX - this.enemyX) / distance;
    float moveY = (closestY - this.enemyY) / distance;
    
    boolean canMove = true;
    
    if (this.enemyX + moveX * this.enemySpeed < -1 * (width/2) || this.enemyX + moveX * this.enemySpeed > width/2) canMove = false;
    if (this.enemyY + moveY * this.enemySpeed < -1 * (height/2) || this.enemyY + moveY * this.enemySpeed > height/2) canMove = false;
    
    if (canMove) {
      this.enemyX += moveX * this.enemySpeed;
      this.enemyY += moveY * this.enemySpeed;
    }
  }
}
