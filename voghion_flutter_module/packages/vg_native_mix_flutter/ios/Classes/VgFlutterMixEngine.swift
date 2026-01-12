//
//  HqFlutterMixEngine.swift
//  v_flutter_nativie_bridge
//
//  Created by edy on 2025/7/1.
//

import UIKit
import Flutter
@objc public class VgFlutterMixEngine: NSObject {
   @objc public static let shared = VgFlutterMixEngine()
    // 私有构造函数防止外部初始化
    private override init() {}
//    @objc public var flutterEngine:FlutterEngine = FlutterEngineGroup(name: "hq_flutter_mix_engine", project: nil).makeEngine(with: nil)
    @objc  lazy var flutterEngine:FlutterEngine = {
        let engine = FlutterEngineGroup(name: "hq_flutter_mix_engine", project: nil).makeEngine(with: nil)
        return engine
    }()
    @discardableResult

    @objc public func makeEngine() -> FlutterEngine {
        return flutterEngine
    }
         
}
