//
//  CategoriesView.swift
//  News
//
//  Created by Momo on 21/8/2567 BE.
//

import SwiftUI

struct CategoriesView: View {
    
    var categories = ["Business", "Entertainment", "General", "Technology"]
    @State var newsCategories: [NewsCategory] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(newsCategories, id: \.category) { category in
                        NewsCategorySectionView(category: category.category, article: category.articles)
                    }
                }
            }
            .navigationTitle("Category")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                for category in categories {
                    await loadNewsCategory(category: category)
                }
            }
        }
    }
    
    func loadNewsCategory(category: String) async {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=4ab80a57dcd1405f8fdbd016bc0e2957&category=\(category)") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let response = try decoder.decode(News.self, from: data)
            
            if let articles = response.articles {
                newsCategories.append(NewsCategory(category: category, articles: articles))
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
}

#Preview {
    CategoriesView()
}
