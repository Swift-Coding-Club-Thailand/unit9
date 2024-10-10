//
//  SearchNewsView.swift
//  News
//
//  Created by Momo on 22/9/2567 BE.
//

import SwiftUI

struct SearchNewsView: View {
    
    @State var searchArticles: [Article] = []
    @State var searchKeyword: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(searchArticles) { article in
                        NewsView(article: article)
                    }
                }
            }
            .navigationTitle("Search News")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchKeyword)
        }
        .onChange(of: searchKeyword) { oldValue, newValue in
            if searchKeyword.isEmpty {
                searchArticles.removeAll()
            } else {
                if searchKeyword.count > 2 {
                    Task {
                        await searchNews()
                    }
                }
            }
        }
        .overlay {
            if searchArticles.isEmpty {
                ContentUnavailableView.search
            }
        }
    }
    
    func searchNews() async {
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=\(searchKeyword)&apiKey=4ab80a57dcd1405f8fdbd016bc0e2957&pageSize=20") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let response = try decoder.decode(News.self, from: data)
            if let articles = response.articles {
                searchArticles = articles
            }
            
        } catch {
            print("Error: \(error)")
        }
    }
    
}

#Preview {
    SearchNewsView()
}
