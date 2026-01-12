import Flutter
import UIKit


public class VgNativeMixFlutterPlugin: NSObject, FlutterPlugin {
    
    public  var delegates:[VgFlutterMixProtocol?] = []

    public static let name = "VgNativeMixFlutterPlugin"
    public static let closeFlutterPage = "closeFlutterPage"
    public static let openNativePage = "openNativePage"
    
    
    public static var shared:VgNativeMixFlutterPlugin?
    public var methodChannel:FlutterMethodChannel?

    
  public static func register(with registrar: FlutterPluginRegistrar) {
      let channel = FlutterMethodChannel(name: "vg_native_mix_flutter", binaryMessenger: registrar.messenger())
      let instance = VgNativeMixFlutterPlugin()
      shared = instance
      shared?.methodChannel = channel
      registrar.addMethodCallDelegate(instance, channel: channel)
  }
    
    public func addDelegate(_ delgate:  VgFlutterMixProtocol){
        self.delegates.append(delgate)
    }
    public func removeLastDelegate(){
        if self.delegates.isEmpty {
            return
        }
        self.delegates.removeLast()
    }
    func parseCallArgs(arguments:Any?) ->VgParseFlutterCallArgs {
        let parseArgs = VgParseFlutterCallArgs()
        var pageName = ""
        var args:Any? = nil
        if let _arguments:Dictionary<String,Any>? = arguments as? Dictionary<String, Any>? {
            pageName = _arguments?["routeName"] as? String ?? "";
            args = _arguments?["args"]
        }
        parseArgs.routeName = pageName
        parseArgs.args = args
        return parseArgs
    }
   
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case VgNativeMixFlutterPlugin.closeFlutterPage:
        for dl in self.delegates {
            if dl != nil && dl?.pageIsVisible() ?? false {
                let parseArgs = parseCallArgs(arguments: call.arguments)
                dl?.closeFlutterPage(routeName: parseArgs.routeName, args: parseArgs.args)
            }
        }
        result(true)
    case VgNativeMixFlutterPlugin.openNativePage:
        for dl in self.delegates {
            if dl != nil && dl?.pageIsVisible() ?? false {
                let parseArgs = parseCallArgs(arguments: call.arguments)
                dl?.openNativePage(routeName: parseArgs.routeName, args: parseArgs.args)
            }
        }
        result(true)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}

