//
//  TextView.swift
//  SwifUITest
//
//  Created by Tomas Green on 2019-10-10.
//  Copyright © 2019 Evry AB. All rights reserved.
//

import SwiftUI
import UIKit

extension String {
    func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        if self.count < 1 {
            label.text = "   "
        } else {
            label.text = self
        }
        label.font = font
        label.sizeToFit()
        return label.frame.height
    }
}



struct TextView: UIViewRepresentable {
    class Coordinator: NSObject, UITextViewDelegate {
        var host:TextView
        init(host: TextView) {
            self.host = host
        }
        func textViewDidChange(_ textView: UITextView) {
            if host.text != textView.text {
                
            }
            triggerUpdate(using: host.view)
        }
        func triggerUpdate(using view:UITextView) {
            let maxHeight = (UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.frame.height ?? 480) * 0.3
            let height = view.systemLayoutSizeFitting(CGSize(width: view.contentSize.width, height: maxHeight), withHorizontalFittingPriority: UILayoutPriority.defaultLow, verticalFittingPriority: UILayoutPriority.defaultHigh).height
            
            if height >= maxHeight {
                host.update(height: ceil(maxHeight), scrollEnabled: true)
            } else {
                host.update(height: ceil(height),scrollEnabled: true)
            }
            
        }
    }

    @Binding var text: String
    @Binding var height: CGFloat
    let view = UITextView()
    func makeUIView(context: Context) -> UITextView {
        view.text = self.text
        view.isScrollEnabled = true
        view.isUserInteractionEnabled = true
        view.alwaysBounceHorizontal = false
        view.alwaysBounceVertical = false
        view.showsHorizontalScrollIndicator = false
        //view.showsVerticalScrollIndicator = false
        view.backgroundColor = UIColor.clear
        view.font = UIFont.systemFont(ofSize: 16)
        view.delegate = context.coordinator
        view.contentInset = .zero
        view.textContainerInset = .zero
        view.verticalScrollIndicatorInsets.bottom = -10
        view.clipsToBounds = false
        height = ceil(view.font?.lineHeight ?? 20)
        return view
    }
    func update(height:CGFloat,scrollEnabled:Bool) {
        if self.height != height {
            self.height = height
            print("heightChange:", height)
        }
        if self.view.isScrollEnabled != scrollEnabled {
            self.view.isScrollEnabled = scrollEnabled
            print("scrollChange:", scrollEnabled)
        }
    }
    func updateUIView(_ uiView: UITextView, context: Context) {
        
    }
    func makeCoordinator() -> TextView.Coordinator {
        return Coordinator(host: self)
    }
}
