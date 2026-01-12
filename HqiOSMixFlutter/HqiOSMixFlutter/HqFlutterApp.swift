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
        //这里的导航控制器获取的逻辑根据项目自行处理
        guard let rootNavVC = window?.rootViewController as? UINavigationController else { return  }
        let engine =  VgFlutterMixEngine.shared.makeEngine();
        let routeArgs = args as? Dictionary<String, Any> ?? nil
        let flutterVC = VgFlutterViewController(engine: engine,routeName: routeName,routeArgs: routeArgs);
        rootNavVC.pushViewController(flutterVC, animated: true)
    }
}
