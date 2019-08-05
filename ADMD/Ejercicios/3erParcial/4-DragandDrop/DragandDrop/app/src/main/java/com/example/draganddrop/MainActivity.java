package com.example.draganddrop;

import android.annotation.SuppressLint;
import android.content.ClipData;
import android.content.ClipDescription;
import android.graphics.Point;
import android.support.design.widget.CoordinatorLayout;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.DragEvent;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    ImageView imagen;
    private static final String IMAGEVIEW_TAG = "icon bitmap";
    String msg="Log";
    private RelativeLayout.LayoutParams layoutParams;
    RelativeLayout padre;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        imagen=findViewById(R.id.imagen);
        imagen.setTag(IMAGEVIEW_TAG);

        padre=findViewById(R.id.padre);

        layoutParams=new RelativeLayout.LayoutParams(padre.getWidth(), padre.getHeight());

        addDrag();

    }


    public void addDrag(){

        Log.d(msg, "Voy en addDrag");





        imagen.setOnLongClickListener(new View.OnLongClickListener() {

            // Defines the one method for the interface, which is called when the View is long-clicked
            public boolean onLongClick(View v) {

                Log.e(msg, "Agregue longClick");

                // Create a new ClipData.
                // This is done in two steps to provide clarity. The convenience method
                // ClipData.newPlainText() can create a plain text ClipData in one step.

                // Create a new ClipData.Item from the ImageView object's tag
                ClipData.Item item = new ClipData.Item((CharSequence) v.getTag());

                // Create a new ClipData using the tag as a label, the plain text MIME type, and
                // the already-created item. This will create a new ClipDescription object within the
                // ClipData, and set its MIME type entry to "text/plain"

                //String array[] = new String[]{"1", "2"};

                String[] mimeTypes = {ClipDescription.MIMETYPE_TEXT_PLAIN};

                ClipData dragData = new ClipData((String) v.getTag(), mimeTypes, item);

                // Instantiates the drag shadow builder.
                //View.DragShadowBuilder myShadow = new MyDragShadowBuilder(imagen);
                View.DragShadowBuilder myShadow = new View.DragShadowBuilder(imagen);

                // Starts the drag

                v.startDrag(dragData,  // the data to be dragged
                        myShadow,  // the drag shadow builder
                        null,      // no need to use local data
                        0          // flags (not currently used, set to 0)
                );

                v.setVisibility(View.INVISIBLE);
                return true;
            }
        });

        padre.setOnDragListener(new View.OnDragListener() {
            @Override
            public boolean onDrag(View v, DragEvent event) {

                int x_cord, x_cord1, y_cord, y_cord1;
                FrameLayout.LayoutParams layoutParams1 = new FrameLayout.LayoutParams(
                        FrameLayout.LayoutParams.MATCH_PARENT, FrameLayout.LayoutParams.MATCH_PARENT);

                //Log.e(msg, "Agregue on drag");
                switch(event.getAction()) {
                    case DragEvent.ACTION_DRAG_STARTED:
                        //layoutParams = (RelativeLayout.LayoutParams)v.getLayoutParams();
                        Log.d(msg, "Action is DragEvent.ACTION_DRAG_STARTED");

                        RelativeLayout container2 = (RelativeLayout) v;

                        layoutParams1.setMargins(0, 0, 0, 0);

                        container2.setLayoutParams(layoutParams1);


                        if (event.getClipDescription().hasMimeType(ClipDescription.MIMETYPE_TEXT_PLAIN)) {
                            // if you want to apply color when drag started to your view you can uncomment below lines
                            // to give any color tint to the View to indicate that it can accept
                            // data.

                            //  view.getBackground().setColorFilter(Color.BLUE, PorterDuff.Mode.SRC_IN);//set background color to your view

                            // Invalidate the view to force a redraw in the new tint
                            //  view.invalidate();

                            // returns true to indicate that the View can accept the dragged data.
                            return true;

                        }

                        // Returns false. During the current drag and drop operation, this View will
                        // not receive events again until ACTION_DRAG_ENDED is sent.
                        return false;

                    case DragEvent.ACTION_DRAG_ENTERED:
                        Log.d(msg, "Action is DragEvent.ACTION_DRAG_ENTERED");

                        //FrameLayout.LayoutParams layoutParams2 = new FrameLayout.LayoutParams(
                        //        FrameLayout.LayoutParams.MATCH_PARENT, FrameLayout.LayoutParams.WRAP_CONTENT);

                        //layoutParams2.setMargins(0, 0, 0, 0);

                        //RelativeLayout container1 = (RelativeLayout) v;//caste the view into LinearLayout as our drag acceptable layout is LinearLayout

                        //container1.setLayoutParams(layoutParams2);

                        v.invalidate();
                        return true;

                    case DragEvent.ACTION_DRAG_EXITED :
                        Log.e(msg, "Action is DragEvent.ACTION_DRAG_EXITED");

                        //v.setLayoutParams(layoutParams);
                        //v.setVisibility(View.VISIBLE);

                        v.invalidate();

                        return true;

                    case DragEvent.ACTION_DRAG_LOCATION  :
                        //Log.d(msg, "Action is DragEvent.ACTION_DRAG_LOCATION");


                        return true;

                    case DragEvent.ACTION_DRAG_ENDED   :
                        Log.d(msg, "Action is DragEvent.ACTION_DRAG_ENDED");

                        v.invalidate();

                        if (event.getResult())
                            Toast.makeText(getApplicationContext(), "El evento drop funcionó.", Toast.LENGTH_SHORT).show();

                        else
                            Toast.makeText(getApplicationContext(), "El evento drop NO funcionó.", Toast.LENGTH_SHORT).show();

                        return false;

                    case DragEvent.ACTION_DROP:
                        Log.d(msg, "ACTION_DROP event");
                        x_cord = (int) event.getX()-110;
                        y_cord = (int) event.getY()-110;
                        Log.d(msg, "X:"+x_cord);
                        Log.d(msg, "X:"+y_cord);

                        //layoutParams.leftMargin = x_cord;
                        //layoutParams.topMargin = y_cord;
                        //layoutParams.leftMargin=x_cord;
                        //layoutParams.leftMargin=y_cord;
                        //View view = (View) event.getLocalState();
                        //ViewGroup owner = (ViewGroup) view.getParent();
                        //owner.removeView(view);//remove the dragged view


                        layoutParams1.setMargins(x_cord, y_cord, 0, 0);

                        RelativeLayout container = (RelativeLayout) v;//caste the view into LinearLayout as our drag acceptable layout is LinearLayout
                        //container.removeView(imagen);

                        container.setLayoutParams(layoutParams1);

                        //container.addView(imagen);//Add the dragged view

                        imagen.setVisibility(View.VISIBLE);//finally set Visibility to VISIBLE


                        return true;

                    default:
                        Log.d(msg, "estoy en default");


                        break;
                }


                return false;
            }
        });


    }

}


