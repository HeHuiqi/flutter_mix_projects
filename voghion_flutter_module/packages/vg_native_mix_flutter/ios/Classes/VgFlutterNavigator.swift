//
//  HqFlutterNavigator.swift
//  hq_navite_mix_flutter
//
//  Created by edy on 2025/7/7.
//

import UIKit

 @objc public enum VgPageType:Int {
    case navite = 1
    case flutter = 2
}


@objc public class VgFlutterNavigator: NSObject {
    @objc public static let shared = VgFlutterNavigator()
    // 私有构造函数防止外部初始化
    private override init() {}
    
    @objc public weak var delegate:VgNavigatorProtocol?
    
    @objc public func openPage(routeName:String,routeArgs: Any? = nil,pageType:VgPageType) {
        
        if pageType == .navite {
            self.delegate?.openNativePage(routeName: routeName, args: routeArgs)
            return
        }
        if pageType == .flutter {
            self.delegate?.openFutterPage(routeName: routeName, args: routeArgs)
            return
        }
        
    }
    
    @objc public func refreshFlutterPage(routeName:String,routeArgs: Dictionary<String, Any>? = nil) {
        let channel = VgNativeMixFlutterPlugin.shared?.methodChannel
        channel?.invokeMethod("refreshPage",arguments: routeArgs)
        
    }
}
