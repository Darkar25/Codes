class ArrayableAdapter { //<>//
  public ArrayableArray array = null; //<>//
  public ArrayableAdapter(ArrayableArray arr) { //<>//
    this.array = arr; //<>//
  } //<>//
  public void stepBack() { //<>//
    if(this.array.parent != null) { //<>//
      this.array = this.array.parent; //<>//
    } else { //<>//
      println("<ArrayableAdapter>Parent array is null.Cannot step back"); //<>//
    } //<>//
  } //<>//
  public void stepForward(int index) { //<>//
    try {
      this.array = this.array.getArray(index);
    } catch(IllegalArgumentException e) {
      println("<ArrayableAdapter>Item on index ".concat(String.valueOf(index)).concat(" is not ArrayableArray.Cannot step forward"));
    }
  }
  public void draw(int size) {
    this.array.draw(size);
  }
  public void setArray(ArrayableArray arr) {
    this.array = arr;
  } //<>//
  public boolean add(Object obj) { //<>//
    this.array.add(obj); //<>//
    return true; //<>//
  } //<>//
  public void add(int index,Object obj){ //<>//
    this.array.add(index,obj); //<>//
  } //<>//
} //<>//
