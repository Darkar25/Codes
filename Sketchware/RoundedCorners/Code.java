final float[] rd = new float[8];
rd[0] = (float)_tlrdx;
rd[1] = (float)_tlrdy;
rd[2] = (float)_trrdx;
rd[3] = (float)_trrdy;
rd[4] = (float)_brrdx;
rd[5] = (float)_brrdy;
rd[6] = (float)_blrdx;
rd[7] = (float)_blrdy;
int[] colors = new int[_clr.size()-2];
for(int i = 0; i < _clr.size()-2; i++) {
colors[i] = Color.parseColor(_clr.get(i+2));
}
final android.graphics.drawable.GradientDrawable _btn_bg= new android.graphics.drawable.GradientDrawable(android.graphics.drawable.GradientDrawable.Orientatio.._BOTTOM, colors); _btn_bg.setCornerRadii(rd); _view.setBackgroundDrawable(_btn_bg);
if(_outline) {
new Handler().postDelayed(new Runnable() {
@Override public void run() {
Bitmap scaledBitmap = Bitmap.createBitmap(_view.getWidth(), _view.getHeight(), Bitmap.Config.ARGB_8888);
Canvas canvas = new Canvas(scaledBitmap);
canvas.setBitmap(scaledBitmap);
_btn_bg.draw(canvas);
Paint paint = new Paint();
paint.setColor(Color.parseColor(_clr.get(0)));
paint.setStyle(Paint.Style.STROKE);
int strokeWidth = Integer.parseInt(_clr.get(1));
paint.setStrokeWidth(strokeWidth);
Rect rect = new Rect();
_view.getLocalVisibleRect(rect);
Path path = new Path();
path.addRoundRect(new RectF(rect.left + strokeWidth, rect.top + strokeWidth, rect.right - strokeWidth, rect.bottom - strokeWidth), rd, Path.Direction.CW);
canvas.drawPath(path, paint);
canvas.drawBitmap(scaledBitmap,0,0,null);
android.graphics.drawable.BitmapDrawable background = new android.graphics.drawable.BitmapDrawable(scaledBitmap);
_view.setBackground(background);
}
}, 100);
}
