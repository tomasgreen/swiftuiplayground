//
//  CommentsView.swift
//  SwifUITest
//
//  Created by Tomas Green on 2019-10-09.
//  Copyright © 2019 Evry AB. All rights reserved.
//

import SwiftUI
import URLImage
//import TextView

fileprivate func roundedAsyncImage(from url:URL) -> some View {
    return URLImage(url,incremental: true) { proxy in
        proxy.image.resizable().aspectRatio(contentMode: .fill)
    }.frame(width: 30, height: 30, alignment: .center).cornerRadius(15).padding(Edge.Set.top, 8)
}

struct CommentListItem: View {
    @State var userComment = false
    @State var comment:CommentViewModel
    var body: some View {
        HStack(alignment: .top, spacing: 5) {
            if userComment == false {
                roundedAsyncImage(from: comment.user.image)
            } else {
                Spacer().frame(width: 40, height: nil, alignment: .center)
            }
            Text(comment.content)
                .padding(16)
                .background(userComment ? Color(UIColor.blue) : Color(UIColor.systemGray5))
                .foregroundColor(userComment ? Color(UIColor.white) : Color(UIColor.label))
                .cornerRadius(16)
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: userComment ? .trailing : .leading)
    }
}


struct CommentList: View {
    @State var preventDismissal: Bool = false
    @State var text:String = "Hej hej"
    @ObservedObject var keyboard = KeyboardResponder()
    @State var textHeight:CGFloat = 100
    //@State var textViewState = TextViewState("test")
    @State var comments:[CommentViewModel]
    fileprivate func calcKeyboardHeight(_ keyboard:KeyboardResponder,_ geometry:GeometryProxy) -> CGFloat {
        return keyboard.currentHeight == 0 ? 0 : keyboard.currentHeight - geometry.safeAreaInsets.bottom
    }
    var body: some View {
        GeometryReader { geometry in
            NavigationView() {
                VStack(spacing: 0) {
                    List() {
                        ForEach(self.comments) { comment in
                            CommentListItem(comment:comment).onTapGesture {
                                self.preventDismissal = !self.preventDismissal
                            }
                        }
                    }.navigationBarTitle("Comments")
                    Divider().padding(0)
                    HStack(alignment: .bottom) {
                        //TextView(self.textViewState)
                        TextView(text: self.$text, height: self.$textHeight)
                            .frame(minHeight: self.textHeight, maxHeight: self.textHeight)
                            .padding(10)
                            .lineLimit(0)
                        Button(action: {
                            self.text = ""
                        }) {
                            Image(systemName: "arrow.right.circle.fill").resizable().frame(width: 40, height: 40, alignment: .bottom).foregroundColor(.blue)
                        }
                    }.padding(2)
                    .background(Color(UIColor.secondarySystemBackground))
                        .overlay(RoundedRectangle(cornerRadius: 21).stroke(Color(UIColor.separator), lineWidth: 1))
                    .cornerRadius(21)
                    .padding(10)
                }.padding(.bottom, self.calcKeyboardHeight(self.keyboard, geometry))
                .animation(.easeOut(duration: self.keyboard.animationDuration))
            }
        }
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentList(comments: [CommentViewModel]())
    }
}
