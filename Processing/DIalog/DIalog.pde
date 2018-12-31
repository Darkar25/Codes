ArrayList<String> list;
PickDialog dialog;
void setup() {
  surface.setResizable(true);
  size(600,600,P2D);
  background(0);
  list = new ArrayList<String>();
  list.add("Дароу братан");
  list.add("Чо каво?");
  list.add("Всё збс,сам как?");
  list.add("Да вот,прогу тут пишу ебабельную");
  list.add("Понятно");
  list.add("Ну вот и всё?");
  list.add("Вот и всё...");
  list.add("Давай пока");
  dialog = new PickDialog(100,list);
  dialog.show();
}
void draw() {
  
}

void mouseMoved() {
  dialog.update();
}

void mouseClicked() {
  dialog.click();
}
