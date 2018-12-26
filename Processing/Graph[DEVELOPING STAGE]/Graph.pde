GraphView graph = new GraphView(0,0,450,300,new ArrayList<Float>());

void setup() {
  size(600,600);
  graph.debug = true;
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
