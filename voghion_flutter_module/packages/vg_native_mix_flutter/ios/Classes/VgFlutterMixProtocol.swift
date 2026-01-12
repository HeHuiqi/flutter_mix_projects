//
//  HqFlutterMixProtocol.swift
//  v_flutter_nativie_bridge
//
//  Created by edy on 2025/7/1.
//

import UIKit

@objc public protocol VgNavigatorProtocol:NSObjectProtocol {
    func openNativePage(routeName:String,args:  Any?)
    func openFutterPage(routeName:String,args:  Any?)

}

public protocol VgFlutterMixProtocol:VgNavigatorProtocol {
    func pageIsVisible() -> Bool
    func closeFlutterPage(routeName:String,args:Any?)

}


