# JColorPicker

<a target="_blank" href="https://developer.android.com/reference/android/os/Build.VERSION_CODES.html#LOLLIPOP"><img src="https://img.shields.io/badge/Android%20API-20%2B-brightgreen.svg" alt="API" /></a>	<a target="_blank" href="https://developer.android.com/reference/android/os/Build.VERSION_CODES.html#LOLLIPOP"><img src="https://img.shields.io/badge/license-apache-blue.svg" alt="License" /></a>

>**iOS coming soon ...**

An open source color picker for Android. The color picker widget style comes from Yeelight App which is an IoT LED bulb app. This color picker is suitable for developers who want to create a led light control App.

## Screenshot
JColorPicker provides two kind of picker, WhiteColorPicker and ColorPicker.

 >- **WhiteColorPicker** - choosing color temperature
 >- **ColorPicker** - choosing any color

<img src="https://github.com/JimmyTai/JColorPicker/blob/master/Screenshot/Android_White_ColorPicker.png?raw=true" width="200" height="356"> <img src="https://github.com/JimmyTai/JColorPicker/blob/master/Screenshot/Android_ColorPicker.png?raw=true" width="200" height="356">

## Usage
You can simply implement `ColorPicker` to your XML file and set a `OnColorSelectedListener`.

**WhiteColorPicker**

 Add the `WhiteColorPicker` to XML:
 
 ```xml
<com.jimmytai.jcolorpicker.WhiteColorPicker
	colorpicker:wcp_indicator_radius="20dp" // default 20dp
	colorpicker:wcp_indicator_activate_scale="1.3" // default 1.3
	colorpicker:wcp_indicator_thickness="4dp" // default 4dp
	colorpicker:wcp_indicator_shadow_radius="8dp" // default 8dp
	colorpicker:wcp_indicator_shadow_color="#e0e0e0" // default #e0e0e0
/>
```

You can add attributes to customize the `WhiteColorPicker`:

| name | type | documentation |
|------|------|---------------|
| wcp_indicator_radius| dimension| indicator size|
| wcp_indicator_activate_scale| float| the radius scale when indicator be activated|
| wcp_indicator_thickness| dimension| indicator white part size| 
| wcp_indicator_shadow_radius| dimension| indicator shadow size|
| wcp_indicator_shadow_color| color | the color of shadow|

**ColorPicker**

 Add the `ColorPicker` to XML:
 
 ```xml
<com.jimmytai.jcolorpicker.ColorPicker
	colorpicker:cp_indicator_radius="20dp" // default 20dp
	colorpicker:cp_indicator_activate_scale="1.3" // default 1.3
	colorpicker:cp_indicator_thickness="4dp" // default 4dp
	colorpicker:cp_indicator_shadow_radius="8dp" // default 8dp
	colorpicker:cp_indicator_shadow_color="#e0e0e0" // default #e0e0e0
/>
```

You can add attributes to customize the `ColorPicker`:

| name | type | documentation |
|------|------|---------------|
| cp_indicator_radius| dimension| indicator size|
| cp_indicator_activate_scale| float| the radius scale when indicator be activated|
| cp_indicator_thickness| dimension| indicator white part size| 
| cp_indicator_shadow_radius| dimension| indicator shadow size|
| cp_indicator_shadow_color| color | the color of shadow|

**OnColorSelectedListener**
Add the following code into your Activity to listener the color selected event.

 ```Java
 private ColorPicker.OnColorSelectedListener colorSelectedListener = 
			new ColorPicker.OnColorSelectedListener() {  
    @Override  
	public void onColorSelected(int color) {         
		// add your code ....
   }
};

ColorPicker view_colorPicker = (ColorPicker) findViewById(R.id.your_colorpicker_id);
view_colorPicker.setOnColorSelectedListener(colorSelectedListener);
 ```

## Download
Download [the latest AAR](https://bintray.com/jimmytai/maven/download_file?file_path=com%2Fjimmytai%2Flibrary%2Fjcolorpicker%2F1.0.0%2Fjcolorpicker-1.0.0.aar) or grab via Gradle:

**Gadle**
```
implementation 'com.jimmytai.library:jcolorpicker:1.0.0'
```
**Maven**
```
<dependency>
	<groupId>com.jimmytai.library</groupId
	<artifactId>jcolorpicker</artifactId>
	<version>1.0.0</version>
	<type>pom</type>
</dependency>
```
## License

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
