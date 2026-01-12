# voghion_flutter_module
A new Flutter module project.

## Getting Started
flutter create -t module --org com.voghion voghion_flutter_module


## 集成指南
* 将 `voghion_flutter_module`放在和你项目的同级目录下
```sh
HqAndroidMixFlutter # 安卓 项目
HqAndroidMixFlutter # IOS 项目
voghion_flutter_module # Flutter 模块项目
```
* 重新获取 `voghion_flutter_module` 项目的依赖
```sh
cd voghion_flutter_module
flutter clean
flutter pub get
```

##  iOS 集成
  * 修改 `HqiOSMixFlutter` 项目的 `Podfile` 中添加如下代码
  ```ruby
    # Uncomment the next line to define a global platform for your project
    # platform :ios, '9.0'

    flutter_application_path = '../voghion_flutter_module'
    load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')

    target 'HqiOSMixFlutter' do
    # Comment the next line if you don't want to use dynamic frameworks
    use_frameworks!

    # Pods for HqiOSMixFlutter
    
    install_all_flutter_pods(flutter_application_path)


    end

    post_install do |installer|
    flutter_post_install(installer) if defined?(flutter_post_install)
    end

  ```

* 重新获取 `HqiOSMixFlutter` 项目的依赖

```sh
cd HqiOSMixFlutter
pod install
```
* 添加测试代码，新建 `HqFlutterApp.swift`，处理路由的跳转，添加如下代码
```swift
//
//  HqFlutterApp.swift
//  HqiOSMixFlutter
//
//  Created by hehuiqi on 2026/1/12.
//

import UIKit
import vg_native_mix_flutter
import FlutterPluginRegistrant
class HqFlutterApp: NSObject {
    static let navigatorImp = HqNavigatorImp()
    // 在 AppDelegate 中启动flutter引擎
    static func setupFutter()  {
        let engine =  VgFlutterMixEngine.shared.makeEngine();
        GeneratedPluginRegistrant.register(with: engine)
        VgFlutterNavigator.shared.delegate = navigatorImp
    }
}
class HqNavigatorImp:NSObject,VgNavigatorProtocol {
    
    func openNativePage(routeName: String, args: Any?) {
        // 这里自行处理原生逻辑
        print("openNativePage",routeName,args as Any)
        
    }
    
    func openFutterPage(routeName: String, args: Any?) {
        // 这里处理flutter 页面跳转
         print("openFutterPage",routeName,args as Any)
        let window = UIApplication.shared.keyWindow
        // 这里的导航控制器获取的逻辑根据项目自行处理
        guard let rootNavVC = window?.rootViewController as? UINavigationController else { return  }
        let engine =  VgFlutterMixEngine.shared.makeEngine();
        let routeArgs = args as? Dictionary<String, Any> ?? nil
        let flutterVC = VgFlutterViewController(engine: engine,routeName: routeName,routeArgs: routeArgs);
        rootNavVC.pushViewController(flutterVC, animated: true)
    }
}
```
* 启动 Flutter 引擎,在 `AppDelegate` 中添加如下代码
```swift
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        HqFlutterApp.setupFutter()
        return true
    }
}
```

* 测试路由跳转,在 `ViewController.swift` 中添加如下代码
```swift
//
//  ViewController.swift
//  HqiOSMixFlutter
//
//  Created by hehuiqi on 2026/1/9.
//

import UIKit
import vg_native_mix_flutter
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Root"
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        // 统一路由跳转工具类 VgFlutterNavigator
        VgFlutterNavigator.shared.openPage(routeName: "/flutter_home", pageType: .flutter)
    }

}

```

## 安卓集成

## 配置项目，导入flutter模块
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
## 代码测试

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

## 参考
https://docs.flutter.cn/add-to-app/ios/project-setup

https://docs.flutter.cn/add-to-app/android/project-setup

https://github.com/gtbluesky/fusion

https://github.com/foxsofter/flutter_thrio

不再更新维护
https://github.com/alibaba/flutter_boost









