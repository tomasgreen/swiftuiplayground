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
                triggerUpdate(using: textView)
            }
        }
        func triggerUpdate(using view:UITextView) {
            guard let text = view.text else {
                return
            }
            guard let font = view.font else {
                return
            }
            let height = text.height(constraintedWidth: view.contentSize.width, font: font)
            let h = (UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.frame.height ?? 480) * 0.3
            if height >= h {
                host.update(height: h,scrollEnabled: true)
            } else {
                host.update(height: height,scrollEnabled: false)
            }
        }
    }

    @Binding var text: String
    @Binding var height: CGFloat
    let view = UITextView()
    func makeUIView(context: Context) -> UITextView {
        view.text = self.text
        view.isScrollEnabled = false
        view.isUserInteractionEnabled = true
        view.alwaysBounceHorizontal = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = UIColor.clear
        view.font = UIFont.systemFont(ofSize: 16)
        view.delegate = context.coordinator
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
        context.coordinator.triggerUpdate(using: view)
    }
    func makeCoordinator() -> TextView.Coordinator {
        return Coordinator(host: self)
    }
}
