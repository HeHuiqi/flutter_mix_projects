package com.voghion.vg_native_mix_flutter

import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.View
import android.view.ViewGroup
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterView
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import java.io.Serializable

open class VgFlutterActivity : FlutterActivity(), VgFlutterMixInterface {
    companion object {
        val TAG = "VgFlutterActivity"
        private var sharedFlutterEngine: FlutterEngine? = null

        fun getSharedEngine(): FlutterEngine {
           sharedFlutterEngine = FlutterEngineCache
                .getInstance().get(VgFlutterMixConst.FLUTTER_ENGINE_ID)
            return sharedFlutterEngine!!
        }

        fun  <T> buildIntent(
            launchContext: Context,
            clazz: Class<T>,
            routeName: String,
            routeArgs: Map<String, Any?>? = null,

        ): Intent {
            var to = Intent(launchContext, clazz).also {
                it.putExtra(VgFlutterMixConst.ROUTE_NAME,routeName)
                it.putExtra(VgFlutterMixConst.ROUTE_ARGS,routeArgs as? Serializable)
            }
            return to
        }
    }
    var  isActivityVisible = false
    //是否自动调用 destroyFlutterPages
    var isAutoClose = true
    private var flutterView: FlutterView? = null

    override fun provideFlutterEngine(context: Context): FlutterEngine {
        return getSharedEngine()
    }

    fun  setStatusBar(){
        // 设置状态栏透明
//        window.addFlags(WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS);
//        window.addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);

        // 设置状态栏背景为白色
        window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
        window.setStatusBarColor(Color.TRANSPARENT)
        // 设置状态栏图标为深色（仅 Android 6.0+ 支持）
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val decorView = window.getDecorView()
            decorView.setSystemUiVisibility(decorView.getSystemUiVisibility() or View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR)
        }

    }

    override fun onCreate(savedInstanceState: Bundle?) {

        super.onCreate(savedInstanceState)
        setStatusBar()

        VgNativeMixFlutterPlugin.shared.addDelegate(this)

        val routeName = intent.getStringExtra(VgFlutterMixConst.ROUTE_NAME) ?: ""

        val routeArgs = intent.getSerializableExtra(VgFlutterMixConst.ROUTE_ARGS) as? Map<String, Any>
        setRouteName(routeName = routeName,routeArgs = routeArgs)



        flutterView =  findViewById<FlutterView>(FLUTTER_VIEW_ID)
        if (flutterView == null) {
            val contentView = findViewById<ViewGroup>( android.R.id.content)
            flutterView = contentView.getChildAt(0) as? FlutterView
        }
        Log.i(TAG, "onCreate: ${flutterView}")
        flutterEngine?.renderer


    }
    fun setRouteName(routeName: String, routeArgs: Map<String, Any?>? = null) {
        val channel = VgNativeMixFlutterPlugin.shared.methodChannel
        val page = routeName
        val arguments: Map<String, Any?> = mapOf(
            "fromNativeOpen" to  true,
            "routeName" to page,
            "args" to routeArgs
        )
        Log.i(TAG, "setRouteName: page=${page}, args=${routeArgs}")
        channel.invokeMethod("push", arguments)
    }

    override fun onResume() {
        super.onResume()
        // 重新绑定 Engine（确保与当前 Activity 关联）
        val  engine = getSharedEngine()
        engine.activityControlSurface.attachToActivity(exclusiveAppComponent,lifecycle)
        flutterView?.attachToFlutterEngine(engine)
        engine.lifecycleChannel.appIsResumed()

    }

    override fun onPause() {
        super.onPause()
        val  engine = getSharedEngine()
        Log.i(TAG, "onStart: ")
        engine.lifecycleChannel.appIsInactive()
    }

    override fun onStart() {
        super.onStart()
        Log.i(TAG, "onStart: ")

        isActivityVisible = true
    }
    override fun onStop() {
        super.onStop()
        Log.i(TAG, "onStop: ")
        isActivityVisible = false
    }

    override fun onDestroy() {
        super.onDestroy()
        getSharedEngine().lifecycleChannel.appIsDetached()
        if (isAutoClose) {
            destroyFlutterPages()
        }
    }
    fun destroyFlutterPages(){
        val channel = VgNativeMixFlutterPlugin.shared.methodChannel
        channel.invokeMethod("destroyFlutterPages",null)
        sharedFlutterEngine?.navigationChannel?.popRoute()
    }

    // MARK: HqFlutterMixInterface
    override fun pageIsVisible(): Boolean {
        return  isActivityVisible
    }

    override fun closeFlutterPage(
        routeName: String,
        args: Map<String, Any?>?
    ) {
        Log.i(TAG, "closeFlutterPage: ${routeName},${args}")
        destroyFlutterPages()
        isAutoClose = false
        getSharedEngine().activityControlSurface.detachFromActivity()
        VgNativeMixFlutterPlugin.shared.removeLastDelegate()
        finish()
    }
    override fun openFlutterPage(
        routeName: String,
        args: Map<String, Any?>?
    ) {
        Log.i(TAG, "openFlutterPage: ${routeName},${args}")
    }

    override fun openNativePage(
        routeName: String,
        args: Map<String, Any?>?
    ) {
        Log.i(TAG, "openNativePage: ${routeName},${args}")
        VgFlutterNavigator.shared.delegate?.openNativePage(routeName,args)
    }


}