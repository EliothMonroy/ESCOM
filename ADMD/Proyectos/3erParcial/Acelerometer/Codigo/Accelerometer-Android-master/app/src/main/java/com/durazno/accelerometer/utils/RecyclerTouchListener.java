package com.durazno.accelerometer.utils;

import android.content.Context;
import android.view.GestureDetector;
import android.view.MotionEvent;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;


/**
 * OnClickListener it gets the component clicked by the MotionEvent.
 * Triggers the click event by the GestureDetector once you have the
 * component you just get the int position.
 */

public class RecyclerTouchListener implements RecyclerView.OnItemTouchListener {

    private GestureDetector gestureDetector;
    private ClickListener clickListener;

    public RecyclerTouchListener(Context context, final ClickListener clickListener) {
        this.clickListener = clickListener;
        gestureDetector = new GestureDetector(context, new GestureDetector.SimpleOnGestureListener(){
            @Override
            public boolean onSingleTapUp(MotionEvent e) {
                return true;
            }
        });
    }

    @Override
    public boolean onInterceptTouchEvent(@NonNull RecyclerView rv, @NonNull MotionEvent e) {
        if(gestureDetector.onTouchEvent(e)){
            View view = rv.findChildViewUnder(e.getX(), e.getY());
            if(view != null){
                int position = rv.getChildAdapterPosition(view);
                if(position != RecyclerView.NO_POSITION){
                    clickListener.onClick(view, position);
                }
            }
        }



        return false;
    }

    @Override
    public void onTouchEvent(@NonNull RecyclerView rv, @NonNull MotionEvent e) {
        // Never used, using onInterceptTouchEvent.
    }

    @Override
    public void onRequestDisallowInterceptTouchEvent(boolean disallowIntercept) {
        throw new UnsupportedOperationException();
    }

    public interface ClickListener{
        void onClick(View view, int position);
    }
}
