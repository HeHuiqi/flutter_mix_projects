package com.voghion.vg_native_mix_flutter


interface VgNavigatorInterface {
    fun openNativePage(routeName:String,args: Map<String, Any?>?)
    fun openFlutterPage(routeName:String,args: Map<String, Any?>?)
}


interface VgFlutterMixInterface: VgNavigatorInterface {
    fun pageIsVisible():Boolean
    fun closeFlutterPage(routeName:String,args: Map<String, Any?>?)
}