ArrayList<Float> arr = new ArrayList<Float>();
GraphView graph = new GraphView(0,0,450,300,arr);

void setup() {
  size(600,600);
  graph.add(20);
  graph.add(10);
  graph.add(40);
  graph.add(10);
  graph.add(20);
  graph.add(10);
  graph.add(4);
  graph.add(1);
  graph.add(40);
  graph.add(32);
  graph.draw();
}

void draw() {
  graph.onHoverCycle();
}
