void drawArrow(float cx, float cy, float fx, float fy, int size, float trans){
  float len = (float) Math.sqrt((fx-cx)*(fx-cx)+(fy-cy)*(fy-cy));
  float angle = -atan2(cx-fx,cy-fy)-PI/2;
  pushMatrix();
  translate(cx, cy);
  rotate(angle);
  stroke(255, 255, 255, 255*trans);
  line(0,0,len, 0);
  line(len-1.5, -1.5, len - size, -size);
  line(len-1.5, 1.5, len - size, size);
  popMatrix();
}
