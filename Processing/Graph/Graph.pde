GraphView graph = new GraphView(0,0,600,300,new ArrayList<Float>());

void setup() {
  size(700,600,P2D);
  //graph.debug = true;
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
