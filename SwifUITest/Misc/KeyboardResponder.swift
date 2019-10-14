//
//  KeyoardResponder.swift
//  SwifUITest
//
//  Created by Tomas Green on 2019-10-10.
//  Copyright © 2019 Evry AB. All rights reserved.
//

import SwiftUI
import Combine

final class KeyboardResponder: ObservableObject {
    let didChange = PassthroughSubject<CGFloat, Never>()
    @Published var currentHeight: CGFloat = 0
    @Published var animationDuration: Double = 0
    @Published var animationCurve: UInt = 0
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyBoardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        if let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            currentHeight = keyboardSize.height
        }
        if let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt {
            self.animationCurve = curve
        }
        if let animationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue {
            self.animationDuration = animationDuration
        }
    }

    @objc func keyBoardWillHide(notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        if let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt {
            self.animationCurve = curve
        }
        if let animationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue {
            self.animationDuration = animationDuration
        }
        currentHeight = 0
    }
}
//UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
//    self.frame.origin.y += deltaY
//}, completion: nil)
