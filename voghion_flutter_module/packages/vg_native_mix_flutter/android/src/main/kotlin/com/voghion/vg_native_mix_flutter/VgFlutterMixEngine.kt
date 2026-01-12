package com.voghion.vg_native_mix_flutter

import android.content.Context
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

enum class VgPageType {
    native,
    flutter
}

class VgFlutterMixEngine {
    companion object {
         val  shared = VgFlutterMixEngine()
    }
    lateinit var flutterEngine: FlutterEngine
    fun makeEngine(context: Context) : FlutterEngine {
        flutterEngine = FlutterEngine(context)
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )
        //        flutterEngine = FlutterEngineGroup(context).createAndRunEngine(context, DartExecutor.DartEntrypoint.createDefault())

        FlutterEngineCache
            .getInstance()
            .put(VgFlutterMixConst.FLUTTER_ENGINE_ID, flutterEngine)
        return flutterEngine
    }
}