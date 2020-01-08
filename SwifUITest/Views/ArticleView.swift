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
    @State var article:ArticleViewModel
    @State var showReactionsModal: Bool = false
    
    var body: some View {
        VStack(alignment: .leading,spacing: 0) {
            VStack(alignment: .leading,spacing: 5) {
                URLImage(article.image,incremental: true) { proxy in
                    proxy.image.resizable().aspectRatio(contentMode: .fill)
                }.frame(width: nil, height: 200, alignment: Alignment.center).clipped()
                VStack(alignment: .leading,spacing:0) {
                    Text(article.title).font(.title).padding(.bottom, 5).lineLimit(nil)
                    Text(article.body).font(.body).lineLimit(nil)
                }.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                VStack(alignment: .leading,spacing:10) {
                    Divider()
                    ArticleReactions(showReactionsModal: showReactionsModal)
                }.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            }
            Divider()
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .background(Color(UIColor.secondarySystemGroupedBackground))
    }
}

struct ArticleView: View {
    @State var article:ArticleViewModel
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
               List() {
                    VStack() {
                        ArticleListViewItem(article: self.article)
                        Spacer(minLength: 20)
                    }.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    ForEach(self.article.topComments) { comment in
                        CommentListItem(comment:comment)
                    }
                    Spacer(minLength: 20)
               }
               .listStyle(DefaultListStyle())
                BottomTextView(geometry: geometry)//.background(Color(UIColor.systemGray6))
            }.navigationBarTitle("", displayMode: .inline)
        }
    }
}

/*struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(article: ArticleViewModel())
    }
}
*/
