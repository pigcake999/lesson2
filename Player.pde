// ============================================================= //
// Player Class                                                  //
// ============================================================= //

class Player {
  float playerX, playerY, playerSpeed, xVel, yVel;
  
  public Player(int initialX, int initialY, int speed) {
    this.playerX = initialX;
    this.playerY = initialY;
    this.playerSpeed = speed;
    this.xVel = 0;
    this.yVel = 0;
  }
  
  public void update() {
    this.drawPlayer();
    this.movePlayer();
  }
  
  private void drawPlayer() {
    fill(255); // Set colour to white
    ellipse(this.playerX, this.playerY, 50, 50); // Draw Player
  }
  
  private void movePlayer() {
    // X axis
    if (this.xVel > 100) {
      this.xVel = 100;
    }
    if (this.xVel < -100) {
      this.xVel = -100;
    }
    this.xVel *= 0.8;
    if (this.playerX + this.xVel > -1 * (width/2) && this.playerX + this.xVel < width/2){
      this.playerX += this.xVel;
    }
    if (this.xVel >= 10) {
      this.xVel = 10;
    }
    
    // Y axis
    this.yVel *= 0.8;
    if (this.playerY + this.yVel > -1 * (height/2) && this.playerY + this.yVel < height/2){
      this.playerY += this.yVel;
    }
    if (this.yVel >= 10) {
      this.yVel = 10;
    }
  }
}
