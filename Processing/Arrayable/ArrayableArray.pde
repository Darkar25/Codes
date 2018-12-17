class ArrayableArray extends ArrayList<Object> {
  public Class type; //<>//
  public ArrayableArray parent;
  public ArrayableArray(Class type) { //<>//
    this.type = type; //<>//
  } //<>//
  public ArrayableArray() { //<>//
  this.type = Integer.class; //<>//
  } //<>//
  @Override //<>//
  public boolean add(Object obj) { //<>//
    if(obj.getClass() == this.type) { //<>//
      super.add(obj); //<>//
    } else { //<>//
      if(obj instanceof ArrayableArray) { //<>//
        ArrayableArray arr = (ArrayableArray)obj; //<>//
        if(arr.type == this.type) { //<>//
          super.add(arr); //<>//
          arr.parent = this; //<>// //<>//
        } else { //<>//
          throw new IllegalArgumentException("<ArrayableArray>Given array type does not match the parent Array type. Given type:\"".concat(arr.type.toString()).concat("\" Array type:\"").concat(this.type.toString()).concat("\"")); //<>//
        } //<>//
      } else { //<>//
        throw new IllegalArgumentException("<ArrayableArray>Given value type does not match the Array value type. Given type:\"".concat(obj.getClass().toString()).concat("\" Array type:\"").concat(this.type.toString()).concat("\"")); //<>//
      } //<>//
    } //<>//
    return true; //<>//
  } //<>//
  @Override
  public void add(int index,Object obj){
    if(obj.getClass() == this.type) {
      super.add(index,obj);
    } else {
      if(obj instanceof ArrayableArray) {
        ArrayableArray arr = (ArrayableArray)obj;
        if(arr.type == this.type) {
          super.add(index,arr);
          arr.parent = this;
        } else {
          throw new IllegalArgumentException("<".concat(this.getClass().toString()).concat(">Given array type does not match the parent Array type. Given type:\"").concat(arr.type.toString()).concat("\" Array type:\"").concat(this.type.toString()).concat("\""));
        }
      } else {
        throw new IllegalArgumentException("<ArrayableArray>Given value type does not match the Array value type. Given type:\"".concat(obj.getClass().toString()).concat("\" Array type:\"").concat(this.type.toString()).concat("\""));
      }
    }
  }
  public String toJSON() { //<>//
    String str = null; //<>//
    try{ //<>//
      Gson gson = new Gson(); //<>//
      JsonElement jsonArray = gson.toJsonTree(this, new TypeToken<List<Object>>() {}.getType()); //<>//
      str = jsonArray.toString(); //<>//
      } catch(NoClassDefFoundError e) { //<>//
        println("<ArrayableArray>GSON not defined.cannot convert array to json"); //<>//
      } //<>//
      return str; //<>//
  } //<>//
  public ArrayableArray getArray(int index) { //<>//
    ArrayableArray ret; //<>//
    if(super.get(index) instanceof ArrayableArray) { //<>//
      ret = (ArrayableArray)super.get(index); //<>//
    } else { //<>//
      throw new IllegalArgumentException("<ArrayableArray>Excepted:\"".concat(this.getClass().toString()).concat("\",but got:\"").concat(super.get(index).getClass().toString()).concat("\"")); //<>//
    } //<>//
    return ret; //<>//
  } //<>//
  public void draw(int size) {
    drawLayer(this,size);
  }
  private void drawLayer(ArrayableArray arr,int size) {
    for(int i = 0;i < arr.size();i++) {
      if(arr.get(i) instanceof ArrayableArray) {
        translate(size,0);
        drawLayer((ArrayableArray)arr.get(i),size);
      } else {
        textSize(size);
        fill(0);
        text(arr.get(i).toString(),0f,0f);
      }
      translate(0,size);
    }
    translate(-size,-size);
  } //<>//
} //<>//
