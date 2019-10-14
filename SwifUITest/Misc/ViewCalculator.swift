//
//  ViewCalculator.swift
//  SwifUITest
//
//  Created by Tomas Green on 2019-10-14.
//  Copyright © 2019 Evry AB. All rights reserved.
//

import SwiftUI
import UIKit

//systemLayoutSizeFitting

/*
 func size(using object:Any,width:CGFloat) -> CGSize {
     configure(using: object)
     setWidth(width)
     return self.systemLayoutSizeFitting(UILayoutFittingCompressedSize,withHorizontalFittingPriority: UILayoutPriority.defaultHigh, verticalFittingPriority: UILayoutPriority.defaultLow)
 }
 */


func calculateHeight(article:ArticleViewModel,width:CGFloat = 375) -> CGFloat {
    
    let swiftUIView = NewsListItem(article: article).frame(width: width)
    let vc = UIHostingController(rootView: swiftUIView)
    vc.view.alpha = 0
//    let win = (UIApplication.shared.windows.filter {$0.isKeyWindow}.first!)
//    win.rootViewController?.addChild(vc)
//    win.rootViewController?.view.addSubview(vc.view)
    let h = vc.view.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize,withHorizontalFittingPriority: UILayoutPriority.defaultHigh, verticalFittingPriority: UILayoutPriority.defaultHigh)
    print(h)
//    vc.view.removeFromSuperview()
//    vc.removeFromParent()
    return h.height
}


func calculateHeight2(article:ArticleViewModel,width:CGFloat = 375){
    DispatchQueue.main.async {
        let d = Date()
        let swiftUIView = NewsListItem(article: article).frame(width: width)
        let vc = UIHostingController(rootView: swiftUIView)
        let h = vc.view.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize,withHorizontalFittingPriority: UILayoutPriority.defaultHigh, verticalFittingPriority: UILayoutPriority.defaultHigh)
        print(h)
        print((d.timeIntervalSinceNow * -1)/1000)
    }
}
