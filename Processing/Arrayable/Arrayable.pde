import com.google.gson.annotations.*; //<>//
import com.google.gson.*; //<>//
import com.google.gson.internal.*; //<>//
import com.google.gson.internal.bind.*; //<>//
import com.google.gson.internal.bind.util.*; //<>//
import com.google.gson.reflect.*; //<>//
import com.google.gson.stream.*; //<>//
import java.util.*; //<>//

void setup() { //<>//
  size(500,500);
  background(255);
  ArrayableArray arr = new ArrayableArray(String.class); //<>//
  ArrayableAdapter adapter = new ArrayableAdapter(arr);
  adapter.add("Item 1");
  adapter.add(new ArrayableArray(String.class));
  adapter.stepForward(1);
  adapter.add("Item 1.1");
  adapter.add("Item 1.2");
  adapter.add(new ArrayableArray(String.class));
  adapter.stepForward(2);
  adapter.add("Item 1.2.1");
  adapter.add("Item 1.2.2");
  adapter.add("Item 1.2.3");
  adapter.add("Item 1.2.4");
  adapter.stepBack();
  adapter.add("Item 1.3");
  adapter.add(new ArrayableArray(String.class));
  adapter.stepForward(4);
  adapter.add("Item 1.3.1");
  adapter.add("Item 1.3.2");
  adapter.stepBack();
  adapter.stepBack();
  adapter.add("Item 2");
  adapter.add("Item 3");
  adapter.add(new ArrayableArray(String.class));
  adapter.stepForward(4);
  adapter.add("Item 3.1");
  adapter.add("Item 3.2"); //<>//
  println(arr.toJSON()); //<>//
  translate(0,25);
  arr.draw(15);
} //<>//
