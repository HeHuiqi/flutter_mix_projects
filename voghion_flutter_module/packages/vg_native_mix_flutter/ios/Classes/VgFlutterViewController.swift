//
//  HqFlutterViewController.swift
//  HqMixFlutter
//
//  Created by edy on 2025/6/13.
//

import UIKit
import Flutter
@objc open class VgFlutterViewController: FlutterViewController,VgFlutterMixProtocol {
   
    
    
    @objc public var isVisible:Bool = false
    //是否自动调用 destroyFlutterPages
    @objc var isAutoClose = true
    @objc public convenience init(engine:FlutterEngine){
        self.init(engine: engine, routeName: "")
    }
    @objc public  init(engine:FlutterEngine, routeName: String = "", routeArgs: Dictionary<String, Any>? = nil,) {
      
        engine.viewController = nil
        super.init(engine: engine, nibName: nil, bundle: nil)
        self.modalPresentationStyle = .fullScreen
        self.view.backgroundColor = UIColor.white
        if routeName.isEmpty {
            return
        }
        setRouteName(routeName: routeName,routeArgs: routeArgs)
        
    }
    
    @objc public func setRouteName(routeName: String, routeArgs: Dictionary<String, Any>? = nil) {
        let channel = VgNativeMixFlutterPlugin.shared?.methodChannel
        let argumetns:[String:Any] = [
            "fromNativeOpen":true,
            "routeName":routeName,
            "args":routeArgs as Any
        ]
        channel?.invokeMethod("push", arguments: argumetns)
    }
  
    public  required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    open override func viewDidLoad() {
        super.viewDidLoad()
        VgNativeMixFlutterPlugin.shared?.addDelegate(self)
        
    }
    open override func viewWillAppear(_ animated: Bool) {
        //必须在super之前这里重新复值才会激活Futter页面
        self.engine.viewController = self
        
        super.viewWillAppear(animated)
//        self.engine.viewController = self
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.navigationBar.isHidden = true
        viewDidLayoutSubviews()


    }
    open override func viewDidAppear(_ animated: Bool) {
        viewDidLayoutSubviews()
        super.viewDidAppear(animated)
        isVisible = true
        
    }
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isVisible = false
    }
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.engine.viewController = nil
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    func destroyFlutterPages(){
        let channel = VgNativeMixFlutterPlugin.shared?.methodChannel
        channel?.invokeMethod("destroyFlutterPages",arguments: nil)
        self.popRoute()

    }
    deinit {
        if(self.isAutoClose) {
            destroyFlutterPages()
        }
        self.engine.viewController = nil
        self.navigationController?.navigationBar.isHidden = false
        print("VgFlutterViewController---deinit")
    }
    
   
    
    // MARK: - HqFlutterMixProtocol
    @objc open func openNativePage(routeName: String, args: Any?) {
        debugPrint("openNativePage==\(routeName),args:\(args as Any)")
        VgFlutterNavigator.shared.openPage(routeName: routeName,routeArgs: args, pageType:.navite)
    }
    @objc public func openFutterPage(routeName: String, args: Any?) {
        debugPrint("openFutterPage==\(routeName),args:\(args as Any)")
    }
    @objc open func closeFlutterPage(routeName: String, args: Any?) {
        debugPrint("closeFlutterPage==\(routeName),args:\(args as Any)")
        VgNativeMixFlutterPlugin.shared?.removeLastDelegate()
        destroyFlutterPages()
        self.isAutoClose = false
        if self.presentingViewController != nil  {
            self.dismiss(animated: true)
        } else {
            self.navigationController?.navigationBar.isHidden = false
            self.navigationController?.popViewController(animated: true)
        }
    }
    @objc open func pageIsVisible() -> Bool {
        return self.isVisible
    }

}
 
