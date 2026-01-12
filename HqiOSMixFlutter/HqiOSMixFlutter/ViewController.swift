//
//  ViewController.swift
//  HqiOSMixFlutter
//
//  Created by hehuiqi on 2026/1/9.
//

import UIKit
import vg_native_mix_flutter
class ViewController: UIViewController {

    lazy var touchMeLab: UILabel = {
        let lab = UILabel()
        lab.text = "Touch Me"
        lab.textAlignment = .center
        return lab
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Root"
        self.view.addSubview(touchMeLab)
        touchMeLab.bounds = self.view.bounds
        touchMeLab.center = self.view.center
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        // 统一路由跳转工具类 VgFlutterNavigator
        VgFlutterNavigator.shared.openPage(routeName: "/flutter_home", pageType: .flutter)
    }

}

