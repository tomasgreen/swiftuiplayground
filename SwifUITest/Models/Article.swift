//
//  News.swift
//  SwifUITest
//
//  Created by Tomas Green on 2019-10-08.
//  Copyright © 2019 Evry AB. All rights reserved.
//

import Foundation
import UIKit
import Combine

//N https://medium.com/@azamsharp/mvvm-in-swiftui-8a2e9cc2964a
struct Article : Codable {
    let id:UUID
    let title:String
    let body:String
    let created:String
    let image:URL
    let user:User
    let numComments:Int
    let topComments:[Comment]
}


class ArticleViewModel : Identifiable {
    let id = UUID()
    let article:Article
    let height:CGFloat = 0
    let topComments:[CommentViewModel]
    init(article:Article) {
        self.article = article
        self.topComments = article.topComments.map(CommentViewModel.init)
    }
    var title:String {
        return article.title
    }
    var body:String {
        return article.body
    }
    var image:URL {
        return article.image
    }
    var numComments:Int {
        return article.numComments
    }
}

class ArticleListViewModel: ObservableObject {
    let didChange = PassthroughSubject<ArticleListViewModel,Never>()
    init() {
        fetch()
    }
    init(data:Data) {
        if let articles = try? JSONDecoder().decode([Article].self, from: data){
            self.articles = articles.map(ArticleViewModel.init)
        }
    }
    
    @Published var articles = [ArticleViewModel]()
    
    private func fetch() {
        API.shared.getArticles { (articles) in
            if let articles = articles {
                self.articles = articles.map(ArticleViewModel.init)
//                self.articles.forEach { (article) in
//                    calculateHeight2(article: article)
//                }
            }
        }
    }
}

//https://gist.githubusercontent.com/tomasgreen/c1c970641603699c16758d618f8a3acc/raw/147d20ba0d38b36d3fa59be5688eb08397753f43/vsts-testarticles.json

//API.shared.getArticles { (articles) in
//    if let articles = articles {
//        var art = [ArticleViewModel]()
//        for a in articles {
//            let article = ArticleViewModel.init(article: a)
//            article.height = calculateHeight(article: article, width: 375)
//            art.append(article)
//        }
//        //self.articles = articles.map(ArticleViewModel.init)
//        self.articles = art
//    }
//}
