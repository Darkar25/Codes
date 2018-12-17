import java.util.*;

class GraphView {
  public float width;
  public float height;
  public float x;
  public float y;
  public ArrayList<Float> arr = new ArrayList<Float>();
  private ArrayList<Integer> vertical = new ArrayList<Integer>();
  private ArrayList<PVector> vert_coords = new ArrayList<PVector>();
  private ArrayList<Integer> horizontal = new ArrayList<Integer>();
  private ArrayList<PVector> horiz_coords = new ArrayList<PVector>();
  private int textsize = 0;
  private int textoffset = 5;
  public GraphView(float x,float y,float width,float height,ArrayList<Float> arr) {
    this.width = width;
    this.height = height;
    this.x = x;
    this.y = y;
    this.arr = arr;
    vertical.add(0);
    vertical.add(1);
  }
  public void add(float value) { //<>//
    arr.add(value); //<>//
    if(!isNull(horizontal,horizontal.size()-1)) { //<>//
      if(horizontal.size()<width/(textsize+textoffset)) { //<>//
        horizontal.add(horizontal.get(horizontal.size()-1)+1); //<>// //<>//
      } else { //<>//
        int vall = horizontal.get(horizontal.size()-1)+1; //<>// //<>//
        int size2 = horizontal.size()+1; //<>//
        horizontal = split(size2,vall); //<>//
      } //<>//
    } else { //<>//
      horizontal.add(1); //<>//
    } //<>//
    if(vertical.get(0)<value) { //<>// //<>//
      int size; //<>//
      if(value>=5) { //<>//
        size = 5; //<>//
      } else { //<>//
        size = (int)value; //<>//
      } //<>//
      vertical = split(size,(int)value); //<>// //<>// //<>// //<>// //<>//
    } //<>//
  } //<>//
  public void print() {
    println("---DEBUG INFO---");
    println("Graph Name:"+this);
    println("Graph Coordinates:"+this.x+" "+this.y);
    println("Graph Dimensions:"+this.width+" "+this.height);
    println("-----");
    final StringBuilder str = new StringBuilder();
    str.append("[");
    for(int i = 0;i < vert_coords.size();i++) {
      str.append("(");
      str.append(String.valueOf(vert_coords.get(i).x));
      str.append(",");
      str.append(String.valueOf(vert_coords.get(i).y));
      str.append(")");
      if(!(i>=vert_coords.size()-1)) {
        str.append(", ");
      }
    }
    str.append("]");
    final StringBuilder str2 = new StringBuilder();
    str2.append("[");
    for(int i = 0;i < horiz_coords.size();i++) {
      str2.append("(");
      str2.append(String.valueOf(horiz_coords.get(i).x));
      str2.append(",");
      str2.append(String.valueOf(horiz_coords.get(i).y));
      str2.append(")");
      if(!(i>=horiz_coords.size()-1)) {
        str2.append(", ");
      }
    }
    str2.append("]");
    println("Lines Coordinates:"+str.toString());
    println("Collumns Coordinates:"+str2.toString());
    println("Values:"+arr.toString());
    println("Lines:"+vertical.toString());
    println("Collumns:"+horizontal.toString());
    println("---DEBUG INFO---");
  }
  public void draw() {
    stroke(255);
    fill(255);
    textsize = (int)(this.height/vertical.size()-textoffset*2);
    rect(x+textsize+textoffset*2,y,x+this.width,y+this.height);
    for(int i = 1;i < vertical.size()+1;i++) {
      textSize(textsize);
      fill(0);
      text(vertical.get(i-1).toString(),0,i*((this.height-textoffset)/vertical.size()));
      stroke(200);
      line(x+textsize+textoffset*2,i*((this.height-textoffset)/vertical.size())-textsize/2,x+textsize+textoffset*2+this.width,i*((this.height-PI)/vertical.size())-textsize/2);
      vert_coords.add(new PVector(0,i*((this.height-textoffset)/vertical.size())-textsize/2));
    }
    for(int i = 1;i < vertical.size();i++) {
      textSize(textsize);
      fill(0);
      if(!isNull(horizontal,i-1)) {
        text(horizontal.get(i-1).toString(),i*((this.width-textsize/textoffset)/horizontal.size()),this.height+textsize-textoffset);
        horiz_coords.add(new PVector(i*((this.width-textsize/textoffset)/horizontal.size()),this.height+textsize-textoffset));
      }
    }
    this.print();
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
}
