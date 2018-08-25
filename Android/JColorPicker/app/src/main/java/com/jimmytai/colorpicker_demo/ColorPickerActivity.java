package com.jimmytai.colorpicker_demo;

import android.os.Bundle;
import android.widget.TextView;

import com.jaygoo.widget.OnRangeChangedListener;
import com.jaygoo.widget.RangeSeekBar;
import com.jimmytai.jcolorpicker.ColorPicker;
import com.jimmytai.library.utils.activity.JActivity;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by JimmyTai on 2018/8/22.
 */
public class ColorPickerActivity extends JActivity {

    private static final String TAG = ColorPickerActivity.class.getSimpleName();
    private static final boolean DEBUG = false;

    @Override
    public String setTag() {
        return TAG;
    }

    @Override
    public boolean setDebug() {
        return DEBUG;
    }

    @Override
    public int setLayout() {
        return R.layout.activity_color_picker;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        ButterKnife.bind(this);
        initViews();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
    }

    @Override
    public void onBackPressed() {
        super.onBackPressed();
        overridePendingTransition(R.anim.activity_b_to_a_enter_translation, R.anim.activity_b_to_a_exit_translation);
    }

    @Override
    public void finish() {
        super.finish();
        overridePendingTransition(R.anim.activity_b_to_a_enter_translation, R.anim.activity_b_to_a_exit_translation);
    }

    /* --- Callbacks --- */

    private ColorPicker.OnColorSelectedListener colorSelectedListener = new ColorPicker.OnColorSelectedListener() {
        @Override
        public void onColorSelected(int color) {
            Prefs.Color.setColor(ColorPickerActivity.this, color);
        }
    };

    private OnRangeChangedListener brightnessChangeListener = new OnRangeChangedListener() {
        @Override
        public void onRangeChanged(RangeSeekBar view, float leftValue, float rightValue, boolean isFromUser) {
            tv_brightness.setText(String.valueOf((int) leftValue));
        }

        @Override
        public void onStartTrackingTouch(RangeSeekBar view, boolean isLeft) {

        }

        @Override
        public void onStopTrackingTouch(RangeSeekBar view, boolean isLeft) {

        }
    };

    /* --- Views --- */

    private void initViews() {
        seekbar_brightness.setValue(100);
        seekbar_brightness.setOnRangeChangedListener(brightnessChangeListener);
        view_colorPicker.setColor(Prefs.Color.getColor(this));
        view_colorPicker.setOnColorSelectedListener(colorSelectedListener);
    }

    @OnClick(R.id.colorPicker_imbtn_appBarBack)
    public void onViewClicked() {
        finish();
    }

    @BindView(R.id.colorPicker_tv_appBarTitle)
    TextView tv_appBarTitle;
    @BindView(R.id.colorPicker)
    ColorPicker view_colorPicker;
    @BindView(R.id.colorPicker_tv_brightness)
    TextView tv_brightness;
    @BindView(R.id.colorPicker_seekBar_brightness)
    RangeSeekBar seekbar_brightness;
}
