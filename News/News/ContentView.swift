//
//  ContentView.swift
//  News
//
//  Created by Momo on 27/6/2567 BE.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            TopStoriesView()
                .tabItem {
                    Label("Today", systemImage: "house")
                }
            CategoriesView()
                .tabItem {
                    Label("Category", systemImage: "square.grid.2x2")
                }
            SearchNewsView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
    
}

#Preview {
    ContentView()
}
