new Handler().postDelayed(new Runnable() {
@Override public void run() {
final int[] clr = new int[(int)_transLayersNum + 1];
for(int i = 0; i < _transLayersNum; i++) {
clr[i] = (Color.parseColor("#00000000"));
}
clr[clr.length-1] = (Color.parseColor("#505050"));
View view;
for(int i = 0; i < _listviee.getChildCount(); i++) {
final int firstListItemPosition = _listviee.getFirstVisiblePosition();
final int lastListItemPosition = firstListItemPosition + _listviee.getChildCount() - 1;
if (i < firstListItemPosition || i > lastListItemPosition ) {
view = _listviee.getAdapter().getView(i, null, _listviee);
} else {
final int childIndex = i - firstListItemPosition;
view = _listviee.getChildAt(childIndex);
}
android.graphics.drawable.Drawable[] layers = new android.graphics.drawable.Drawable[2];
if(view.getBackground() != null) {
layers[0] = view.getBackground();
} else {
layers[0] = new android.graphics.drawable.ColorDrawable(Color.parseColor("#00000000"));
}
final android.graphics.drawable.GradientDrawable shadow = new android.graphics.drawable.GradientDrawable(android.graphics.drawable.GradientDrawable.Orientatio.._BOTTOM, clr);
layers[1] = shadow;
android.graphics.drawable.LayerDrawable ld = new android.graphics.drawable.LayerDrawable(layers);
view.setBackground(ld);
}
}
}, 100);
