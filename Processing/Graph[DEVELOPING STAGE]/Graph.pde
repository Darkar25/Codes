ArrayList<Float> arr = new ArrayList<Float>();
GraphView graph = new GraphView(0,0,500,300,arr);

void setup() {
  size(600,600);
  graph.add(25);
  graph.add(12);
  graph.add(47);
  graph.add(60);
  graph.draw();
}
