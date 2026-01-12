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
            VgFlutterNavigator.shared.openPage(routeName = "/flutter_home", pageType = VgPageType.flutter, routeArgs = null)
        }
    }
}