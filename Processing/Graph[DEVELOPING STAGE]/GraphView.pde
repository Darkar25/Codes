import java.util.*;

class GraphView {
  public PGraphics rendered;
  public float width;
  public float height;
  public float x;
  public float y;
  public ArrayList<Float> arr = new ArrayList<Float>();
  private ArrayList<PVector> value_coords = new ArrayList<PVector>();
  private ArrayList<PVector> value_data = new ArrayList<PVector>();
  private ArrayList<Integer> vertical = new ArrayList<Integer>();
  private ArrayList<PVector> vert_coords = new ArrayList<PVector>();
  private ArrayList<Integer> horizontal = new ArrayList<Integer>();
  private ArrayList<PVector> horiz_coords = new ArrayList<PVector>();
  private int textsize = 0;
  private int textoffset = 5;
  protected boolean cycleready = false;
  public GraphView(float x,float y,float width,float height,ArrayList<Float> arr) {
    this.width = width;
    this.height = height;
    this.x = x;
    this.y = y;
    this.arr = arr;
    vertical.add(0);
    vertical.add(1);
  }
  public void add(float value) {
    arr.add(value);
    if(!isNull(horizontal,horizontal.size()-1)) {
      if(horizontal.size()<width/((textsize+textoffset)*horizontal.size())) {
        horizontal.add(horizontal.get(horizontal.size()-1)+1);
      } else {
        throw new IndexOutOfBoundsException("This version of code does not support that much values!size up your Graph Width or add less values!Seems like this Graph support only "+horizontal.size()+" values!"); 
      }
    } else {
      horizontal.add(1);
    }
    if(vertical.get(0)<value) {
      int size;
      if(value>=5) {
        size = 5;
      } else {
        size = (int)value;
      }
      vertical = split(size,(int)value);
    }
    value_data.add(new PVector(value,horizontal.get(horizontal.size()-1)));
    vert_coords = new ArrayList<PVector>();
    horiz_coords = new ArrayList<PVector>();
    value_coords = new ArrayList<PVector>();
    for(int i = 1;i < vertical.size()+1;i++) {
      vert_coords.add(new PVector(0,i*((this.height-textoffset)/vertical.size())-textsize/2));
    }
    for(int i = 1;i < horizontal.size();i++) {
      if(!isNull(horizontal,i-1)) {
        horiz_coords.add(new PVector(i*((this.width-textsize/textoffset)/horizontal.size()),this.height+textsize-textoffset));
      }
    }
    for(int i = 1;i<arr.size();i++) {
      if(horiz_coords.size()>0) {
        value_coords.add(new PVector(horiz_coords.get(i-1).x,compare(vertical,vert_coords,arr.get(i-1))));
      }
      if(i >= horiz_coords.size()) {
        value_coords.add(new PVector(horiz_coords.get(horiz_coords.size()-1).x,compare(vertical,vert_coords,value)));
      }
    }
  }
  public void print() {
    println("---DEBUG INFO---");
    println("Graph Name:"+this);
    println("Graph Coordinates:"+this.x+" "+this.y);
    println("Graph Dimensions:"+this.width+" "+this.height);
    println("Values Coordinates:"+PVectorArrayToString(value_coords));
    println("Values Data:"+PVectorArrayToString(value_data));
    println("Lines Coordinates:"+PVectorArrayToString(vert_coords));
    println("Collumns Coordinates:"+PVectorArrayToString(horiz_coords));
    println("Values:"+arr.toString());
    println("Lines:"+vertical.toString());
    println("Collumns:"+horizontal.toString());
    println("---DEBUG INFO---");
  }
  public void draw() {
    textsize = (int)(this.height/vertical.size()-textoffset*2);
    rendered = createGraphics((int)(this.width+textsize+textoffset),(int)(this.height+textsize+textoffset));
    rendered.beginDraw();
    rendered.rect(x+textsize+textoffset*2,y,x+this.width,y+this.height);
    for(int i = 1;i < vertical.size()+1;i++) {
      rendered.textSize(textsize);
      rendered.fill(0);
      rendered.text(vertical.get(i-1).toString(),0,i*((this.height-textoffset)/vertical.size()));
      rendered.stroke(200);
      rendered.line(x+textsize+textoffset*2,i*((this.height-textoffset)/vertical.size())-textsize/2,x+textsize+textoffset*2+this.width,i*((this.height-PI)/vertical.size())-textsize/2);
      vert_coords.add(new PVector(0,i*((this.height-textoffset)/vertical.size())-textsize/2));
    }
    for(int i = 1;i < horizontal.size()+1;i++) {
      rendered.textSize(textsize);
      rendered.fill(0);
      if(!isNull(horizontal,i-1)) {
        rendered.text(horizontal.get(i-1).toString(),i*((this.width-textsize/textoffset)/horizontal.size()),this.height+textsize-textoffset);
      }
    }
    for(int i = 1;i < value_coords.size()+1;i++) {
      if(!isNull(value_coords,i)) {
        rendered.stroke(0,255,0);
        rendered.strokeWeight(3);
        rendered.line(value_coords.get(i).x+10,value_coords.get(i).y+10,value_coords.get(i-1).x+10,value_coords.get(i-1).y+10);
      }
    }
    for(int i = 1;i < value_coords.size()+1;i++) {
      rendered.fill(0,255,0);
      rendered.strokeWeight(1);
      rendered.stroke(0);
      rendered.rect(value_coords.get(i-1).x+5,value_coords.get(i-1).y+5,10,10,25,25,25,25);
    }
    rendered.endDraw();
    cycleready = true;
    this.print();
  }
  public void onHoverCycle() {
    if(cycleready) {
      PGraphics graphic = createGraphics((int)this.width,(int)this.height);
      graphic.beginDraw();
      //graphic.rect(mouseX-25,mouseY-25,50,50);
      for(int i = 0;i < value_coords.size();i++) {
        PVector vec = (PVector)value_coords.get(i);
        if(mouseX<vec.x+15&&mouseX>vec.x+5&&mouseY<vec.y+15&&mouseY>vec.y+5) {
          image(rendered,x,y);
          String str = "Line:"+(int)value_data.get(i).x+" Collumn:"+(int)value_data.get(i).y;
          graphic.fill(0,0,0,127);
          float val = ((textsize/3.5)*str.length()+width/10)/1.75;
          float val2 = textsize+textoffset;
          if(vec.x+val-width/(width/val*PI)<width) {
            graphic.rect(vec.x-3-val2,vec.y,val,height/15,25,25,25,25);
            graphic.textSize(textsize/3.5);
            graphic.fill(255);
            graphic.text(str,vec.x+27-val2-(str.length()/textsize+textoffset),vec.y+15);
          } else {
            graphic.rect(vec.x+25-val2,vec.y,-val,height/15,25,25,25,25);
            graphic.textSize(textsize/3.5);
            graphic.fill(255);
            graphic.text(str,vec.x+5-(5*str.length()+width/10)-val2-(str.length()/textsize+textoffset),vec.y+15);
          }
          graphic.fill(0,255,255);
          graphic.rect(vec.x+5-val2,vec.y+5,10,10,25,25,25,25);
        } else {
          image(rendered,x,y);
        }
      }
      graphic.endDraw();
      image(graphic,x+textsize+textoffset,y);
    }
  }
  private ArrayList<Integer> split(int size,int val) {
    ArrayList<Integer> ret = new ArrayList<Integer>();
      for(int i = 1;i < size+1;i++) {
        ret.add(val*i/size);
      }
      Collections.reverse(ret);
      return ret;
  }
  private boolean isNull(ArrayList arr,int index) {
    boolean ret = false;
    try {
      Object obj = (Object)arr.get(index);
    } catch(NullPointerException e){
      ret = true;
    } catch(IndexOutOfBoundsException e2) {
      ret = true;
    }
    return ret;
  }
  public String PVectorArrayToString(ArrayList<PVector> arr) {
    final StringBuilder str = new StringBuilder();
    str.append("[");
    for(int i = 0;i < arr.size();i++) {
      str.append("(");
      str.append(String.valueOf(arr.get(i).x));
      str.append(",");
      str.append(String.valueOf(arr.get(i).y));
      str.append(")");
      if(!(i>=arr.size()-1)) {
        str.append(", ");
      }
    }
    str.append("]");
    return str.toString();
  }
  private float compareTo(float to,float from, float max) {
    return from/max*to;
  }
  private float compare(ArrayList<Integer> arr,ArrayList<PVector> arr1,float value) {
    float comp = 0;
    for(int j = 1;j<arr.size();j++) {
      if(value>arr.get(j)&&value<=arr.get(j-1)) {
          comp = compareTo(arr.get(j-1),arr1.get(j).y,arr1.get(j-1).y);
      }
    }
    return comp;
  }
}
