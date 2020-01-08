//
//  ContentView.swift
//  SwifUITest
//
//  Created by Tomas Green on 2019-10-08.
//  Copyright © 2019 Evry AB. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                NewsList()
            }.tabItem {
                Text("News")
                Image(systemName: "text.quote").imageScale(.large)
            }.tag(1)
            NavigationView {
                ChatList()
            }.tabItem {
                Text("Chats")
                Image(systemName: "bubble.middle.bottom.fill").imageScale(.large)
            }.tag(2)
        }.accentColor(Color.blue)
        .edgesIgnoringSafeArea(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
