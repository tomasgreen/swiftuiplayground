//
//  ArticleView.swift
//  SwifUITest
//
//  Created by Tomas Green on 2019-10-08.
//  Copyright © 2019 Evry AB. All rights reserved.
//

import SwiftUI
import URLImage

struct ArticleListViewItem: View {
    fileprivate func roundedImage(with name:String) -> some View {
        return Image(name).resizable().aspectRatio(contentMode: .fill).frame(width: 26, height: 26, alignment: .center).cornerRadius(13).overlay(RoundedRectangle(cornerRadius: 13).stroke(Color.white, lineWidth: 1))
    }
    fileprivate func roundedAsyncImage(from url:URL) -> some View {
        return URLImage(url,incremental: true) { proxy in
            proxy.image.resizable().aspectRatio(contentMode: .fill)
        }.frame(width: 26, height: 26, alignment: .center).cornerRadius(13).overlay(RoundedRectangle(cornerRadius: 13).stroke(Color.white, lineWidth: 1))
    }
    //https://stackoverflow.com/questions/56756318/swiftui-presentationbutton-with-modal-that-is-full-screen
    @State var article:ArticleViewModel
    @State var showReactionsModal: Bool = false
    @State var showCommentsModal: Bool = false
    @GestureState var isLongPressed = false
    @State var buttonBg = Color.white
    @State var text:String? = nil
    @State var numRows:Int? = 2
    
    var body: some View {
        return VStack(alignment: .leading,spacing: 0) {
            if showReactionsModal == false && self.showCommentsModal == false {
                NavigationLink(destination: ArticleView(article: article)) {
                    EmptyView()
                }.frame(width: 0, height: 0, alignment: .bottom)
            }
            VStack(alignment: .leading,spacing: 5) {
                URLImage(article.image,incremental: true) { proxy in
                    proxy.image.resizable().aspectRatio(contentMode: .fill)
                }.frame(width: nil, height: 200, alignment: Alignment.center).clipped()
                //Image("test.png").resizable().aspectRatio(contentMode: .fill).frame(width: nil, height: 200, alignment: Alignment.center).clipped()
                VStack(alignment: .leading,spacing:0) {
                    Text(article.title).font(.title).padding(.bottom, 5).lineLimit(self.numRows)
                    Text(text ?? article.body).font(.body).lineLimit(self.numRows)
                }.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))//.frame(minHeight: 100, idealHeight: 150, maxHeight: 200)
                VStack(alignment: .leading,spacing:10) {
                    Divider()
                    ArticleReactions(showReactionsModal: showReactionsModal)
                    Divider()
                    CommentFaceList(comments: article.topComments, numComments: article.numComments,showCommentsModal: showCommentsModal)
                }.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            }.background(Color(UIColor.secondarySystemGroupedBackground))
            Divider()
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
        .background(Color(UIColor.systemGroupedBackground))
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}

struct ArticleView: View {
    @State var article:ArticleViewModel
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
               List() {
                    NewsListItem(article: self.article, numRows: nil)
                    ForEach(self.article.topComments) { comment in
                        CommentListItem(comment:comment)
                    }
               }
               BottomTextView(geometry: geometry)
            }
        }
    }
}

/*struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(article: ArticleViewModel())
    }
}
*/
