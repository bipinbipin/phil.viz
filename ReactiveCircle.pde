class ReactiveCircle {
 float x, y;
 float r;
 color col;
 
 ReactiveCircle() {
   x = random(width);
   y = random(height);
   r = random(4, 32);
 }
 
 //ReactiveCircle(color tmpCol) {
 //  col = tmpCol;
 //}
 
 void display() {
   stroke(5);
   strokeWeight(3);
   fill(col);
   ellipse(x, y, r*2, r*2);
 }
  
}
