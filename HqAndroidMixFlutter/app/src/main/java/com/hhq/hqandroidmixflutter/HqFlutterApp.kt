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