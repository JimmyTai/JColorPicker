package com.jimmytai.colorpicker_demo;

import android.os.Bundle;
import android.widget.TextView;

import com.jaygoo.widget.OnRangeChangedListener;
import com.jaygoo.widget.RangeSeekBar;
import com.jimmytai.jcolorpicker.WhiteColorPicker;
import com.jimmytai.library.utils.activity.JActivity;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by JimmyTai on 2018/8/22.
 */
public class ColorPickerWhiteActivity extends JActivity {

    private static final String TAG = ColorPickerWhiteActivity.class.getSimpleName();
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
        return R.layout.activity_color_picker_white;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        ButterKnife.bind(this);
        initViews();
    }

    @Override
    protected void onStart() {
        super.onStart();
        view_whiteColorPicker.setColor(Prefs.WhiteColor.getColor(this));
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

    private WhiteColorPicker.OnColorSelectedListener colorSelectedListener
            = new WhiteColorPicker.OnColorSelectedListener() {
        @Override
        public void onColorSelected(int color) {
            Prefs.WhiteColor.setColor(ColorPickerWhiteActivity.this, color);
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
        view_whiteColorPicker.setOnColorSelectedListener(colorSelectedListener);
        seekbar_brightness.setValue(100);
        seekbar_brightness.setOnRangeChangedListener(brightnessChangeListener);
    }

    @OnClick(R.id.whitePicker_imbtn_appBarBack)
    public void onViewClicked() {
        finish();
    }

    @BindView(R.id.whitePicker_tv_appBarTitle)
    TextView tv_appBarTitle;
    @BindView(R.id.whiteColorPicker)
    WhiteColorPicker view_whiteColorPicker;
    @BindView(R.id.whitePicker_seekBar_brightness)
    RangeSeekBar seekbar_brightness;
    @BindView(R.id.whitePicker_tv_brightness)
    TextView tv_brightness;
}
