package com.jimmytai.colorpicker_demo;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.TextView;

import com.jimmytai.library.utils.activity.JActivity;

import butterknife.BindView;
import butterknife.ButterKnife;

public class MainActivity extends JActivity {

    private static final String TAG = MainActivity.class.getSimpleName();
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
        return R.layout.activity_main;
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

    /* --- Callbacks --- */

    private ColorPickersRecyclerAdapter.OnItemClickListener onItemClickListener = new ColorPickersRecyclerAdapter.OnItemClickListener() {
        @Override
        public void onItemClick(View view, int position) {
            Intent i = new Intent(MainActivity.this, adapter.getItemData(position).targetClass);
            i.setFlags(Intent.FLAG_ACTIVITY_REORDER_TO_FRONT);
            startActivity(i);
            overridePendingTransition(R.anim.activity_a_to_b_enter_translation, R.anim.activity_a_to_b_exit_translation);
        }
    };

    /* --- Views --- */

    private ColorPickersRecyclerAdapter adapter;

    private void initViews() {
        LinearLayoutManager manager = new LinearLayoutManager(this);
        manager.setOrientation(LinearLayoutManager.VERTICAL);
        recycler_color_pickers.setLayoutManager(manager);
        recycler_color_pickers.setAdapter(adapter = new ColorPickersRecyclerAdapter(this));
        adapter.setOnItemClickListener(onItemClickListener);
    }

    @BindView(R.id.main_tv_header_title)
    TextView tv_headerTitle;
    @BindView(R.id.main_recycler_color_pickers)
    RecyclerView recycler_color_pickers;

}
