
# 配置项目，导入flutter模块
* `settings.gradle.kts` 导入项目

```groovy
pluginManagement {
    repositories {
        google {
            content {
                includeGroupByRegex("com\\.android.*")
                includeGroupByRegex("com\\.google.*")
                includeGroupByRegex("androidx.*")
            }
        }
        mavenCentral()
        gradlePluginPortal()
        maven("https://storage.googleapis.com/download.flutter.io")
    }
}
dependencyResolutionManagement {
//    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
//    将 Gradle 的仓库策略从「强制优先 settings」改为「允许 project 仓库」，兼容 Flutter 插件的仓库添加行为
    repositoriesMode.set(RepositoriesMode.PREFER_PROJECT)
    repositories {
        google()
        mavenCentral()
        maven("https://storage.googleapis.com/download.flutter.io")
    }

}

rootProject.name = "HqAndroidMixFlutter"



include(":app")

val flutterModulePath = "${settingsDir.parentFile}/voghion_flutter_module/.android/include_flutter.groovy"
apply(from = flutterModulePath)
 
```

* `app/build.gradle.kts` 添加依赖

```groovy
plugins {
    alias(libs.plugins.android.application)
    alias(libs.plugins.kotlin.android)
}

android {
    namespace = "com.hhq.hqandroidmixflutter"
    compileSdk {
        version = release(36)
    }

    defaultConfig {
        applicationId = "com.hhq.hqandroidmixflutter"
        minSdk = 24
        targetSdk = 36
        versionCode = 1
        versionName = "1.0"

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        //添加
        ndk {
            // Filter for architectures supported by Flutter
            abiFilters += listOf("armeabi-v7a", "arm64-v8a", "x86_64")
        }
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
    kotlinOptions {
        jvmTarget = "11"
    }
}

dependencies {
    implementation(libs.androidx.core.ktx)
    implementation(libs.androidx.appcompat)
    implementation(libs.material)
    implementation(libs.androidx.activity)
    implementation(libs.androidx.constraintlayout)
    testImplementation(libs.junit)
    androidTestImplementation(libs.androidx.junit)
    androidTestImplementation(libs.androidx.espresso.core)
    //添加依赖
    implementation(project(":flutter"))
}
```
# 配置`AndroidManifest.xml`
```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools">

    <application
        android:name=".HqApp"
        android:allowBackup="true"
        android:dataExtractionRules="@xml/data_extraction_rules"
        android:fullBackupContent="@xml/backup_rules"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:supportsRtl="true"
        android:theme="@style/Theme.HqAndroidMixFlutter">
<!-- 添加FlutterActivity -->
        <activity
            android:name="io.flutter.embedding.android.FlutterActivity"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize" />
<!-- 添加插件 VgFlutterActivity -->
        <activity
            android:name="com.voghion.vg_native_mix_flutter.VgFlutterActivity"
            android:exported="false" />
        <activity
            android:name=".MainActivity"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />

                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>

</manifest>

```
# 代码测试

`HqFlutterApp.kt`

```kotlin
package com.hhq.hqandroidmixflutter

import android.content.Context
import android.content.Intent
import android.util.Log
import com.voghion.vg_native_mix_flutter.VgFlutterActivity
import com.voghion.vg_native_mix_flutter.VgFlutterMixEngine
import com.voghion.vg_native_mix_flutter.VgFlutterNavigator
import com.voghion.vg_native_mix_flutter.VgNavigatorInterface

// 实现 VgNavigatorInterface 接口，统一处理页面跳转已经参数处理

// 跳转页面统一使用 VgFlutterNavigator.shared.(routeName,routeArgs,pageType)

class HqFlutterApp:VgNavigatorInterface {


    companion object {
        var TAG: String = "VgFlutterApp"
    }

    var context: Context? = null
    fun setupFlutter(context: Context) {
        this.context = context
        Log.i(TAG, "setupFlutter: ${this.context}")
        VgFlutterMixEngine.shared.makeEngine(context)
        VgFlutterNavigator.shared.delegate = this
    }
    override fun openNativePage(
        routeName: String,
        args: Map<String, Any?>?
    ) {
        // 这里处理flutter打开原生页面的逻辑
        Log.i(TAG, "openNativePage: ")
    }

    override fun openFlutterPage(
        routeName: String,
        args: Map<String, Any?>?
    ) {
        Log.i(TAG, "openFlutterPage: $routeName")
        Log.i(TAG, "openFlutterPage-args: $args")
        if (context == null) {
            Log.i(TAG, "context is null")
            return
        }
        context?.apply {
            val intent = VgFlutterActivity.buildIntent<VgFlutterActivity>(
                this,
                VgFlutterActivity::class.java ,
                routeName,
                args
            )
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK) // 关键标志
            this.startActivity(intent)
        }
    }

}
```
`HqApp.kt`
```kotlin
package com.hhq.hqandroidmixflutter

import android.app.Application

class HqApp: Application() {
    override fun onCreate() {
        super.onCreate()
        //启动Flutter
        HqFlutterApp().setupFlutter(this)
    }
}
```
`MainActivity.kt`
```kotlin
package com.hhq.hqandroidmixflutter

import android.os.Bundle
import android.widget.Button
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.voghion.vg_native_mix_flutter.VgFlutterNavigator
import com.voghion.vg_native_mix_flutter.VgPageType

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }
        setup()
    }
    fun  setup(){
        val btn = findViewById<Button>(R.id.homeBtn)
        btn.setOnClickListener {
            //这里 routeName 要和flutter中配置的路由一致
            VgFlutterNavigator.shared.openPage(routeName = "/flutter_home", pageType = VgPageType.flutter)
        }
    }
}
```





