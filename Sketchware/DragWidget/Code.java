_view.setOnLongClickListener(new OnLongClickListener() {
@Override
public boolean onLongClick(View v) {
i = 1;
return true;
}
});
_view.setOnTouchListener(new OnTouchListener() {
PointF DownPT = new PointF();
PointF StartPT = new PointF();
@Override
public boolean onTouch(View v, MotionEvent event) {
if(i == 1) {
int eid = event.getAction();
switch (eid) {
case MotionEvent.ACTION_MOVE:PointF mv = new PointF(event.getX() - DownPT.x, event.getY() - DownPT.y);
Rect rect = new Rect();
((View)_view.getParent()).getLocalVisibleRect(rect);
if((StartPT.x+mv.x>=rect.left+_padding)&&(StartPT.x+mv.x<=rect.right-(_padding+_view.getWidth()))) {
_view.setX((int)(StartPT.x+mv.x));
}
if((StartPT.y+mv.y>=rect.top+_padding)&&(StartPT.y+mv.y<=rect.bottom-(_padding+_view.getHeight()))) {
_view.setY((int)(StartPT.y+mv.y));
}
StartPT = new PointF(_view.getX(), _view.getY());
break;
case MotionEvent.ACTION_DOWN : DownPT.x = event.getX();
DownPT.y = event.getY();
StartPT = new PointF(_view.getX(), _view.getY());
break;
case MotionEvent.ACTION_UP :
i = 0;
break;
default : break;
}
}
return false;
}
});
