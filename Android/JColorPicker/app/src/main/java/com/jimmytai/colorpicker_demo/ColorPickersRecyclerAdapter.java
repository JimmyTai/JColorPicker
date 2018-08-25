package com.jimmytai.colorpicker_demo;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by JimmyTai on 2018/8/23.
 */
public class ColorPickersRecyclerAdapter extends RecyclerView.Adapter<ColorPickersRecyclerAdapter.ViewHolder> {

    public interface OnItemClickListener {
        void onItemClick(View view, int position);
    }

    private Context context;
    private OnItemClickListener listener;

    public void setOnItemClickListener(OnItemClickListener listener) {
        this.listener = listener;
    }

    ColorPickersRecyclerAdapter(Context context) {
        this.context = context;
    }

    @NonNull
    @Override
    public ColorPickersRecyclerAdapter.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(context).inflate(R.layout.view_item_color_picker, parent, false);
        view.setOnClickListener(onClickListener);
        return new ColorPickersRecyclerAdapter.ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ColorPickersRecyclerAdapter.ViewHolder holder, int position) {
        holder.itemView.setTag(position);
        holder.tv_name.setText(COLOR_PICKERS_DATAS[position].name);
    }

    @Override
    public int getItemCount() {
        return COLOR_PICKERS_DATAS.length;
    }

    public ColorPickersData getItemData(int position) {
        return COLOR_PICKERS_DATAS[position];
    }

    private View.OnClickListener onClickListener = new View.OnClickListener() {

        @Override
        public void onClick(View v) {
            if (listener != null) {
                listener.onItemClick(v, ((int) v.getTag()));
            }
        }
    };

    class ViewHolder extends RecyclerView.ViewHolder {

        @BindView(R.id.itemColorPicker_tv_name)
        TextView tv_name;
        @BindView(R.id.itemColorPicker_iv_indicator)
        ImageView iv_indicator;

        ViewHolder(View itemView) {
            super(itemView);
            ButterKnife.bind(this, itemView);
        }
    }

    /* --- Data --- */

    private final ColorPickersData[] COLOR_PICKERS_DATAS = new ColorPickersData[]{
            new ColorPickersData("White Picker", ColorPickerWhiteActivity.class),
            new ColorPickersData("Color Picker", ColorPickerActivity.class)
    };

    class ColorPickersData {

        String name;
        Class targetClass;

        ColorPickersData(String name, Class targetClass) {
            this.name = name;
            this.targetClass = targetClass;
        }
    }
}
