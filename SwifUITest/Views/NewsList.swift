//
//  NewsList.swift
//  SwifUITest
//
//  Created by Tomas Green on 2019-10-08.
//  Copyright © 2019 Evry AB. All rights reserved.
//

import SwiftUI
import URLImage

struct ArticleReactions: View {
    @State var showReactionsModal: Bool = false
    var body: some View {
        HStack() {
            Text("😀🤬🤯")
            Text(" 10 reactions").foregroundColor(.secondary)
        }.onTapGesture {
            self.showReactionsModal = true
        }.sheet(isPresented: self.$showReactionsModal) {
            Text("Reactions")
        }
    }
}

struct CommentFaceList: View {
    fileprivate func roundedAsyncImage(from url:URL) -> some View {
        return URLImage(url,incremental: true) { proxy in
            proxy.image.resizable().aspectRatio(contentMode: .fill)
        }.frame(width: 26, height: 26, alignment: .center).cornerRadius(13).overlay(RoundedRectangle(cornerRadius: 13).stroke(Color.white, lineWidth: 1))
    }
    @State var comments:[CommentViewModel]
    @State var numComments:Int
    @State var showCommentsModal: Bool = false
    var body: some View {
        HStack() {
           HStack(alignment: .center, spacing: -5) {
               ForEach(comments) { comment in
                   self.roundedAsyncImage(from: comment.user.image)
               }
           }
           Text(" and \(numComments) other has commented").foregroundColor(.secondary)
        }.onTapGesture {
            self.showCommentsModal = true
        }.sheet(isPresented: self.$showCommentsModal) {
            CommentList(comments: self.comments)
        }
    }
}

struct NewsListItem: View {
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

    
    var body: some View {
        return VStack(alignment: .leading,spacing: 0) {
            if showReactionsModal == false && self.showCommentsModal == false {
                NavigationLink(destination: ArticleView()) {
                    EmptyView()
                }.frame(width: 0, height: 0, alignment: .bottom)
            }
            VStack(alignment: .leading,spacing: 5) {
                URLImage(article.image,incremental: true) { proxy in
                    proxy.image.resizable().aspectRatio(contentMode: .fill)
                }.frame(width: nil, height: 200, alignment: Alignment.center).clipped()
                //Image("test.png").resizable().aspectRatio(contentMode: .fill).frame(width: nil, height: 200, alignment: Alignment.center).clipped()
                VStack(alignment: .leading,spacing:0) {
                    Text(article.title).font(.title).padding(.bottom, 5).lineLimit(2)
                    Text(text ?? article.body).font(.body).lineLimit(2)
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


struct NewsList: View {
    @ObservedObject var model = ArticleListViewModel()
    var body: some View {
//        List(model.articles) { article in
//            NewsListItem(article:article)
//        }
        List() {
            ForEach(model.articles) { article in
                NewsListItem(article:article)
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("News")
    }
}

struct NewsList_Previews: PreviewProvider {
    var model:ArticleListViewModel {
        let data = try! Data(contentsOf: Bundle.main.url(forResource: "articles", withExtension: "json")!)
        return ArticleListViewModel(data: data)
    }
    static var previews: some View {
        NavigationView() {
            NewsList()
        }
    }
}
