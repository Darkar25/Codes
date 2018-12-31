class PickDialog {
  public float radius;
  public ArrayList<String> variants;
  public float sliderAngle = radians(90);
  public float variantAngle;
  private boolean shown = false;
  private PVector selected;
  private int selectedId;
  private boolean clicked;
  public PickDialog(float r,ArrayList<String> v) {
    this.radius = r;
    this.variants = v;
    this.variantAngle = 360/variants.size();
    if(variants.size()>2) {
      this.sliderAngle = radians(this.variantAngle);
    }
  }
  public void show() {
    this.shown = true;
    background(0);
    update();
  }
  public void hide() {
    this.shown = false;
    background(0);
  }
  public void update() {
    if(shown) {
      noStroke();
      background(0);
      if(!clicked) {
        for(int i = 0;i < variants.size();i++) {
          fill(67,74,82);
          if(getAngle(new PVector(width/2,height/2),new PVector(mouseX,mouseY))>=i*this.variantAngle&&getAngle(new PVector(width/2,height/2),new PVector(mouseX,mouseY))<i*this.variantAngle+this.variantAngle) {
            float textsize = radius/variants.size();
            textSize(textsize);
            fill(255);
            text(variants.get(i),0,height/2+this.radius+textsize+15,width,height);
            fill(0,255,0);
            selectedId = i;
          }
          arc(width/2,height/2,radius*2,radius*2,radians(i*this.variantAngle),radians(i*this.variantAngle+this.variantAngle));
        }
      } else {
        for(int i = 0;i < variants.size();i++) {
          fill(67,74,82);
          arc(width/2,height/2,radius*2,radius*2,radians(i*this.variantAngle),radians(i*this.variantAngle+this.variantAngle));
        }
        fill(255);
        float textsize = radius/variants.size();
        textSize(textsize);
        text(variants.get(this.selectedId),0,height/2+this.radius+textsize+15,width,height);
        fill(255,165,0);
        arc(width/2,height/2,radius*2,radius*2,radians(this.selected.x),radians(this.selected.y));

      }
      fill(66,170,255);
      arc(width/2,height/2,radius,radius,radians(getAngle(new PVector(width/2,height/2),new PVector(mouseX,mouseY)))-this.sliderAngle/2,radians(getAngle(new PVector(width/2,height/2),new PVector(mouseX,mouseY)))+this.sliderAngle/2);
      fill(0);
      ellipse(width/2,height/2,radius/(HALF_PI/1.25),radius/(HALF_PI/1.25));
    }
  }
  private float getAngle(PVector vec1,PVector vec2) {
    float angle = (float) Math.toDegrees(Math.atan2(vec2.y - vec1.y, vec2.x - vec1.x));
    if(angle < 0){
        angle += 360;
    }
    return angle;
  }
  public void click() {
    selected = new PVector(selectedId*this.variantAngle,selectedId*this.variantAngle+this.variantAngle);
    this.clicked = true;
  }
  public void reset() {
    this.clicked = false;
    this.shown = false;
  }
}
