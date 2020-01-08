//
//  BottomTextView.swift
//  SwifUITest
//
//  Created by Tomas Green on 2019-10-15.
//  Copyright © 2019 Evry AB. All rights reserved.
//

import SwiftUI

struct BottomTextView : View {
    @State var geometry:GeometryProxy
    @ObservedObject var keyboard = KeyboardResponder()
    @State var text:String = ""
    @State var textHeight:CGFloat = 20
    fileprivate func calcKeyboardHeight(_ keyboard:KeyboardResponder,_ geometry:GeometryProxy) -> CGFloat {
        
        return keyboard.currentHeight == 0 ? 0 : keyboard.currentHeight - geometry.safeAreaInsets.bottom
    }
    var body: some View {
        VStack(spacing: 0) {
            Divider().padding(0)
            HStack(alignment: .bottom) {
                TextView(text: self.$text, height: self.$textHeight,viewHeight: geometry.size.height)
                    .frame(minHeight: self.textHeight, maxHeight: self.textHeight)
                    .padding(10)
                Button(action: {
                    self.text = ""
                    UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.endEditing(true)
                }) {
                    Image(systemName: "arrow.right.circle.fill").resizable().frame(width: 40, height: 40, alignment: .bottom).foregroundColor(.blue)
                }
            }
            .padding(2)
            .background(Color(UIColor.secondarySystemBackground))
            .overlay(RoundedRectangle(cornerRadius: 21).stroke(Color(UIColor.separator), lineWidth: 1))
            .cornerRadius(21)
            .padding(10)
            .animation(.easeOut(duration: self.keyboard.animationDuration))
        }.padding(.bottom, self.calcKeyboardHeight(self.keyboard, geometry))
    }
}
