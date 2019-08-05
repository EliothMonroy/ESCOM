package com.example.tiposlistas;

import java.text.DateFormat;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;
public final class NewsEntryAdapter extends ArrayAdapter<NewsEntry> {
    private final int newsItemLayoutResource;
    public NewsEntryAdapter(final Context context, final int newsItemLayoutResource) {
        super(context, 0);
        this.newsItemLayoutResource = newsItemLayoutResource;
    }
    @Override
    public View getView(final int position, final View convertView, final ViewGroup parent) {
        final View view = getWorkingView(convertView);
        final ViewHolder viewHolder = getViewHolder(view);
        final NewsEntry entry = getItem(position);
        viewHolder.titleView.setText(entry.getTitle());
        final String formattedSubTitle = String.format("By %s on %s",
                entry.getAuthor(),
                DateFormat.getDateInstance(DateFormat.SHORT).format(entry.getPostDate())
        );
        viewHolder.subTitleView.setText(formattedSubTitle);
        viewHolder.imageView.setImageResource(entry.getIcon());
        return view;
    }
    private View getWorkingView(final View convertView) {
        View workingView = null;
        if(null == convertView) {
            final Context context = getContext();
            final LayoutInflater inflater = (LayoutInflater)context.getSystemService
                    (Context.LAYOUT_INFLATER_SERVICE);
            workingView = inflater.inflate(newsItemLayoutResource, null);
        } else {
            workingView = convertView;
        }
        return workingView;
    }
    private ViewHolder getViewHolder(final View workingView) {
        final Object tag = workingView.getTag();
        ViewHolder viewHolder = null;
        if(null == tag || !(tag instanceof ViewHolder)) {
            viewHolder = new ViewHolder();
            viewHolder.titleView = workingView.findViewById(R.id.news_entry_title);
            viewHolder.subTitleView = workingView.findViewById(R.id.news_entry_subtitle);
            viewHolder.imageView = workingView.findViewById(R.id.news_entry_icon);
            workingView.setTag(viewHolder);
        } else {
            viewHolder = (ViewHolder) tag;
        }
        return viewHolder;
    }
    private static class ViewHolder {
        public TextView titleView;
        public TextView subTitleView;
        public ImageView imageView;
    }
}
