void setup() {
size(500,500,P2D);
background(0);
stroke(255);
noFill();
strokeWeight(5);
float[] cut = {10,23,43,23,19,3,32,10};
cutRect(50,50,width-100,100,25);
cutRect(50,200,width-100,100,25,50,15,10);
cutRect(50,350,width-100,100,cut);
}
