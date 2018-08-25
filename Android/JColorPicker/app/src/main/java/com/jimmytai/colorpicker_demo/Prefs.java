package com.jimmytai.colorpicker_demo;

import android.content.Context;

/**
 * Created by JimmyTai on 2018/8/24.
 */
public class Prefs {

    public static class WhiteColor {
        private static final String name = "white_color";
        private static final String field_rgb = "rgb";

        public static void setColor(Context context, int color) {
            context.getSharedPreferences(name, Context.MODE_PRIVATE).edit()
                    .putInt(field_rgb, color)
                    .apply();
        }

        public static int getColor(Context context) {
            return context.getSharedPreferences(name, Context.MODE_PRIVATE).getInt(field_rgb, 0);
        }
    }

    public static class Color {
        private static final String name = "color";
        private static final String field_rgb = "rgb";

        public static void setColor(Context context, int color) {
            context.getSharedPreferences(name, Context.MODE_PRIVATE).edit()
                    .putInt(field_rgb, color)
                    .apply();
        }

        public static int getColor(Context context) {
            return context.getSharedPreferences(name, Context.MODE_PRIVATE).getInt(field_rgb, 0);
        }
    }
}
