public void cutRect(float x,float y,float w,float h,float c) {
  if(!(c>w/2||c>h/2)) {
    beginShape();
    vertex(x+c,y);
    vertex(x+w,y);
    vertex(x+w,y+h-c);
    vertex(x+w-c,y+h);
    vertex(x,y+h);
    vertex(x,y+c);
    vertex(x+c,y);
    endShape();
  } else {
    throw new IllegalArgumentException("Cut size cannot be more than half of side of rectangle");
  }
}
public void cutRect(float x,float y,float w,float h,float c,float c2,float c3,float c4) {
  if(!(c>w/2||c>h/2||c2>w/2||c2>h/2||c3>w/2||c3>h/2||c4>w/2||c4>h/2)) {
    beginShape();
    vertex(x+c,y);
    vertex(x+w-c2,y);
    vertex(x+w,y+c2);
    vertex(x+w,y+h-c3);
    vertex(x+w-c3,y+h);
    vertex(x+c4,y+h);
    vertex(x,y+h-c4);
    vertex(x,y+c);
    vertex(x+c,y);
    endShape();
  } else {
    throw new IllegalArgumentException("Cut size cannot be more than half of side of rectangle");
  }
}
public void cutRect(float x,float y,float w,float h,float[] c) {
  if(c.length>7&&!(c.length>8)) {
    if(!(c[0]>w/2||c[1]>h/2||c[2]>w/2||c[3]>h/2||c[4]>w/2||c[5]>h/2||c[6]>w/2||c[7]>h/2)) {
      beginShape();
      vertex(x+c[0],y);
      vertex(x+w-c[2],y);
      vertex(x+w,y+c[3]);
      vertex(x+w,y+h-c[5]);
      vertex(x+w-c[4],y+h);
      vertex(x+c[6],y+h);
      vertex(x,y+h-c[7]);
      vertex(x,y+c[1]);
      vertex(x+c[0],y);
    endShape();
  } else {
    throw new IllegalArgumentException("Cut size cannot be more than half of side of rectangle");
  }
  } else {
    throw new IllegalArgumentException("Cut array excepts 8 values");
  }
}
