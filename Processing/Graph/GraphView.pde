import java.util.*;

class GraphView {
  //Объявление переменных <
  public PGraphics rendered;
  public float width;
  public float height;
  public float x;
  public float y;
  public boolean debug = false;
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
  private boolean hovered = false;
  private boolean errored = false;
  //>
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
      vertical = split(size,(int)value); //<>//
    }
    value_data.add(new PVector(value,horizontal.get(horizontal.size()-1)));
    vert_coords = new ArrayList<PVector>();
    horiz_coords = new ArrayList<PVector>();
    value_coords = new ArrayList<PVector>();
    //Установка координат для вертикальной линии
    for(int i = 1;i < vertical.size()+1;i++) {
      vert_coords.add(new PVector(0,i*((this.height-textoffset)/vertical.size())-textsize+textoffset-15));
    }
    //Установка координат для горизонтальной линии
    for(int i = 1;i < horizontal.size()+1;i++) {
      if(!isNull(horizontal,i-1)) {
        horiz_coords.add(new PVector(i*((this.width-textsize/textoffset)/horizontal.size())+textoffset,this.height+textsize-textoffset));
      }
    }
    for(int i = 1;i<horizontal.size()+1;i++) {
      if(!isNull(horiz_coords,i-1)&&!isNull(vertical,vertical.size()-2)) {
        value_coords.add(new PVector(horiz_coords.get(i-1).x,map(arr.get(i-1),vertical.get(vertical.size()-2),0,this.height/HALF_PI,this.height)-10));
      }
    }
  }
  public void print() {
    println("---DEBUG INFO---");
    println("Айди графика:"+this);
    println("Координаты графика:"+this.x+" "+this.y);
    println("Размеры графика:"+this.width+" "+this.height);
    println("Координаты точек:"+PVectorArrayToString(value_coords));
    println("Данные точек:"+PVectorArrayToString(value_data));
    println("Координаты вертикальной линии:"+PVectorArrayToString(vert_coords));
    println("Координаты горизонтальной линии:"+PVectorArrayToString(horiz_coords));
    println("Точки:"+arr.toString());
    println("Линии:"+vertical.toString());
    println("Колонны:"+horizontal.toString());
    println("---DEBUG INFO---");
  }
  public void draw() {
    textsize = (int)(this.height/vertical.size()-textoffset*2);
    rendered = createGraphics((int)(this.width+textsize+textoffset),(int)(this.height+textsize+textoffset));
    rendered.beginDraw();
    rendered.rect(x+textsize+textoffset*2,y,x+this.width,y+this.height);
    //Отрисовка вертикального текста и линий
    for(int i = 1;i < vertical.size()+1;i++) {
      rendered.textSize(textsize);
      rendered.fill(0);
      rendered.text(vertical.get(i-1).toString(),0,i*((this.height-textoffset)/vertical.size()));
      rendered.stroke(200);
      rendered.line(vert_coords.get(i-1).x+textsize+textoffset,vert_coords.get(i-1).y-textsize/2,vert_coords.get(i-1).x+this.width+textsize+textoffset,vert_coords.get(i-1).y-textsize/2);
      vert_coords.add(new PVector(0,i*((this.height-textoffset)/vertical.size())-textsize/2));
    }
    //Отрисовка горизонтального текста
    for(int i = 0;i < horiz_coords.size()+1;i++) {
      rendered.textSize(textsize);
      rendered.fill(0);
      if(!isNull(horiz_coords,i)) {
        rendered.text(horizontal.get(i).toString(),horiz_coords.get(i).x,this.height+textsize-textoffset);
      }
    }
    //Отрисовка точек
    for(int i = 0;i < value_coords.size()+1;i++) {
      if(!isNull(value_coords,i)) {
        rendered.stroke(0,255,0);
        rendered.strokeWeight(3);
        if(!isNull(value_coords,i+1)) {
          rendered.line(value_coords.get(i+1).x+15,value_coords.get(i+1).y+10,value_coords.get(i).x+15,value_coords.get(i).y+10);
        }
        rendered.fill(0,255,0);
        rendered.strokeWeight(1);
        rendered.stroke(0);
        rendered.rect(value_coords.get(i).x+10,value_coords.get(i).y+5,10,10,25);
      }
    }
    rendered.endDraw();
    image(this.rendered,this.x,this.y);
    cycleready = true;
    if(debug) {
      this.print();
    }
  }
  public void onHoverCycle() {
    if(cycleready) {
      PGraphics graphic = createGraphics((int)this.width-textoffset,(int)this.height);
      PGraphics mouserect = createGraphics(10,10);
      graphic.beginDraw();
      if(debug) {
        mouserect.beginDraw();
        mouserect.fill(255,127,255,127);
        mouserect.rect(0,0,10,10,25);
        mouserect.endDraw();
      }
      for(int i = 0;i < value_coords.size();i++) {
        PVector vec = (PVector)value_coords.get(i);
        if(mouseX<vec.x+20&&mouseX>vec.x+10&&mouseY<vec.y+15&&mouseY>vec.y+5) {
          hovered = true;
          String str;
          if(!isNull(value_data,i)) {
            str = "Line:"+(int)value_data.get(i).x+" Collumn:"+(int)value_data.get(i).y;
          } else {
            str = "Line:N/A Collumn:N/A";
            if(hovered && !errored) {
              println("Cannot validate point at position " + i + "!Maybe code-level bug?Contact me vk.com/gushser");
              errored = true;
            }
          }
          graphic.fill(0,0,0,127);
          float val = ((textsize/3.5)*str.length()+width/10)/1.75;
          float val2 = textsize+textoffset;
          if(vec.x+val-width/(width/val*PI)<width) {
            graphic.rect(vec.x-3-val2,vec.y,val,height/15,25);
            graphic.textSize(textsize/3.5);
            graphic.fill(255);
            graphic.text(str,vec.x+27-val2-(str.length()/textsize+textoffset),vec.y+15);
          } else {
            graphic.rect(vec.x+25-val2,vec.y,-val,height/15,25);
            graphic.textSize(textsize/3.5);
            graphic.fill(255);
            graphic.text(str,vec.x+5-(5*str.length()+width/10)-val2-(str.length()/textsize+textoffset),vec.y+15);
          }
          graphic.fill(0,255,255);
          graphic.rect(vec.x+5-val2,vec.y+5,10,10,25);
        } else if(!isHovered(value_coords)) {
          hovered = false;
          errored = false;
        }
      }
      graphic.image(mouserect,mouseX-(textsize+textoffset*2+textoffset),mouseY-5);
      graphic.endDraw();
      image(rendered,x,y);
      image(graphic,x+textsize+textoffset*2,y);
    }
  }
  //Разбиение числа на равные части
  private ArrayList<Integer> split(int size,int val) {
    ArrayList<Integer> ret = new ArrayList<Integer>();
      for(int i = 1;i < size+1;i++) {
        ret.add(val*i/size);
      }
      Collections.reverse(ret);
      return ret;
  }
  private boolean isHovered(ArrayList<PVector> arr) {
    boolean ret = false;
    for(int i = 0;i < arr.size();i++) {
       PVector vec = (PVector)value_coords.get(i);
       if(mouseX<vec.x+20&&mouseX>vec.x+10&&mouseY<vec.y+15&&mouseY>vec.y+5) {
         ret = true;
       }
    }
    return ret;
  }
  //Проверка если значение NULL или выходит за пределы списка
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
  //Перевод PVector списка в строку
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
}
