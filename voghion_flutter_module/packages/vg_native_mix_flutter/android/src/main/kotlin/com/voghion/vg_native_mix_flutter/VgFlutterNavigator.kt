package com.voghion.vg_native_mix_flutter

class VgFlutterNavigator {

    companion object {
        val  shared = VgFlutterNavigator()
    }
    var delegate: VgNavigatorInterface? = null

    fun openPage(routeName:String, routeArgs: Map<String, Any?>?, pageType:VgPageType) {
        if (pageType == VgPageType.native) {
            this.delegate?.openNativePage(routeName, args = routeArgs)
            return
        }
        if (pageType == VgPageType.flutter) {
            this.delegate?.openFlutterPage(routeName, args = routeArgs)
            return
        }
    }
     fun refreshFlutterPage(routeName:String,routeArgs: Any? = null) {
         val channel = VgNativeMixFlutterPlugin.shared.methodChannel
         channel.invokeMethod("refreshPage",routeArgs)

    }
}