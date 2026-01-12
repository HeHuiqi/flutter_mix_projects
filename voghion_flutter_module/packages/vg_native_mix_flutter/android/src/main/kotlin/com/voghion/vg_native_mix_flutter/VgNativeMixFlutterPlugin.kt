package com.voghion.vg_native_mix_flutter

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** VgNativeMixFlutterPlugin */
class VgNativeMixFlutterPlugin: FlutterPlugin, MethodCallHandler {
  companion object {
    const val plugiNname = "VgNativeMixFlutterPlugin"
    const val closeFlutterPage = "closeFlutterPage"
    const val openNativePage = "openNativePage"
    lateinit var shared: VgNativeMixFlutterPlugin
  }
  lateinit var methodChannel : MethodChannel
  var delegates: MutableList<VgFlutterMixInterface> = mutableListOf()

  fun addDelegate(delegate:VgFlutterMixInterface){
    this.delegates.add(delegate)
  }
  fun removeLastDelegate(){
    if (this.delegates.isEmpty()) {
      return
    }
    val  idx = this.delegates.lastIndex
    this.delegates.removeAt(idx)
  }
  fun parseCallArgs(arguments: Any?):VgParseFlutterCallArgs {
    val parseArgs = VgParseFlutterCallArgs()
    var routeName = ""
    var args: Map<String, Any?>? = null
    val  argus: HashMap<String,Any>? = arguments as? HashMap<String, Any>?
    routeName = argus?.get("routeName") as? String ?: ""
    args = argus?.get("args") as? HashMap<String, Any>?
    parseArgs.routerName = routeName
    parseArgs.args = args
    return parseArgs
  }
  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    methodChannel = MethodChannel(flutterPluginBinding.binaryMessenger, "vg_native_mix_flutter")
    methodChannel.setMethodCallHandler(this)
    shared = this
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when(call.method) {
      "getPlatformVersion" -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      closeFlutterPage -> {
        for (dl in this.delegates) {
          if (dl.pageIsVisible()) {
            val parseCallArgs = parseCallArgs(call.arguments)
            dl.closeFlutterPage(parseCallArgs.routerName, args = parseCallArgs.args)
          }
        }
        result.success(true)
      }
      openNativePage -> {
        for (dl in this.delegates) {
          if (dl.pageIsVisible()) {
            val parseCallArgs = parseCallArgs(call.arguments)
            dl.openNativePage(parseCallArgs.routerName, args = parseCallArgs.args)
          }
        }
        result.success(true)
      }
      else ->  {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    methodChannel.setMethodCallHandler(null)
  }
}
