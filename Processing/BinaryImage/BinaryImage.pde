import java.util.Arrays;

int[] arr;
int y = 0;
String msg = "Пишов нахуй!";
boolean solid = true;

void setup() {
  size(750,750);
  background(0);
  byte[] bytes = msg.getBytes();
  StringBuilder binary = new StringBuilder();
  for (byte b : bytes)
  {
     int val = b;
     for (int i = 0; i < 8; i++)
     {
        binary.append((val & 128) == 0 ? 0 : 1);
        val <<= 1;
     }
     binary.append(' ');
  }
  String[] str = null;
  String str1 = null;
  int len = 0;
  if(!solid) {
    str = split(binary.toString(), " ");
    len = str.length;
  } else {
    str1 = binary.toString().replace(" ","");
    len = 2;
  }
  for(int i = 0;i < len-1;i++) {
    if(solid) {
      arr = fromStringToIntArray(str1);
    } else {
      arr = fromStringToIntArray(str[i]);
    }
    println(Arrays.toString(arr));
    drawMessage(arr,i);
    arr = null;
  }
  saveFrame("output.png");
}

public void drawMessage(int[] arr,int line) {
  stroke(255);
  strokeWeight(5);
  beginShape();
  int x = 0;
  for(int i = 0;i < arr.length;i++) {
    if(arr[i] == 1) {
      if(!isNull(arr,i-1)&&x>0) {
      if(arr[i-1]!=arr[i]) {
        line(x,y+25+(line*35),x+25,y+(line*35)); //<>//
        line(x+25,y+(line*35),x+50,y+(line*35)); //<>//
      } else {
        line(x+25,y+(line*35),x+50,y+(line*35)); //<>//
      }
      } else {
        line(x,y+25+(line*35),x+25,y+(line*35)); //<>//
        line(x+25,y+(line*35),x+50,y+(line*35)); //<>//
      }
    } else if(arr[i] == 0) {
      if(!isNull(arr,i-1)) {
      if(arr[i-1]!=arr[i]&&x>0) {
        line(x+25,y+(line*35),x,y+25+(line*35)); //<>//
        line(x,y+25+(line*35),x+25,y+25+(line*35)); //<>//
      } else {
        line(x,y+25+(line*35),x+25,y+25+(line*35)); //<>//
      }
      } else {
        line(x,y+25+(line*35),x+25,y+25+(line*35)); //<>// //<>//
      }
    } else {
      throw new IllegalArgumentException("Invalid int value at index "+i+" with value "+arr[i]+".Are you trying to fill array by yourself?"); //<>//
    }
    if(x+75>width) {
      y+=30;
      x=0;
    } else {
      x+=25; //<>//
    }
  }
  endShape();
  //textSize(25);
  //text(Arrays.toString(arr),x+25,y+25+(line*35));
}

public boolean isNull(int[] array,int index) {
  boolean ret = false;
  try{
    Object obj = (Object)array[index];
  } catch(ArrayIndexOutOfBoundsException e) {
    ret = true;
  }
    return ret;
}
public int[] fromStringToIntArray(String str) {
int[] ret = new int[str.length()];
    for(int j = 0;j < str.length();j++) {
    ret[j] = Integer.valueOf(Character.toString(str.charAt(j)));
    }
    return ret;
}
