package com.hhq.hqandroidmixflutter

import android.app.Application

class HqApp: Application() {
    override fun onCreate() {
        super.onCreate()
        //启动Flutter
        HqFlutterApp().setupFlutter(this)
    }
}