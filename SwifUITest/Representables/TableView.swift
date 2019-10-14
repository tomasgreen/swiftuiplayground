//
//  TableView.swift
//  SwifUITest
//
//  Created by Tomas Green on 2019-10-14.
//  Copyright © 2019 Evry AB. All rights reserved.
//

import SwiftUI
import UIKit

private func calculateNewsHeight(article:ArticleViewModel,width:CGFloat = 375) -> CGFloat {
    let swiftUIView = NewsListItem(article: article).frame(width: width)
    let vc = UIHostingController(rootView: swiftUIView)
    return vc.view.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize,withHorizontalFittingPriority: UILayoutPriority.defaultHigh, verticalFittingPriority: UILayoutPriority.defaultHigh).height
}

struct ArticleTableView: UIViewRepresentable {
    class Coordinator: NSObject, UITableViewDelegate,UITableViewDataSource {
        @ObservedObject var model = ArticleListViewModel()
        var template:NewsListItem?
        var host:UIHostingController<NewsListItem>?
        init(model: ArticleListViewModel) {
            self.model = model
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let v = NewsListItem(article: model.articles[indexPath.row])
            return UITableViewCell()
        }
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return model.articles.count
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return calculateNewsHeight(article: model.articles[indexPath.row], width: tableView.frame.size.width)
        }
    }
    func makeCoordinator() -> ArticleTableView.Coordinator {
        return Coordinator(model: model)
    }
    let view = UITableView()
    @ObservedObject var model = ArticleListViewModel()
    func makeUIView(context: Context) -> UITableView {
        view.delegate = context.coordinator
        view.dataSource = context.coordinator
        return  view
    }
    func updateUIView(_ uiView: UITableView, context: Context) {

    }
    func makeCoordinator() -> ArticleTableView.Coordinator {
        return Coordinator(model: model)
    }
}
