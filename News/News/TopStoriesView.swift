//
//  TopStoriesView.swift
//  News
//
//  Created by Momo on 4/8/2567 BE.
//

import SwiftUI

struct TopStoriesView: View {
    
    @State var highlightArticle: Article?
    @State var articles: [Article] = []
    
    @State var articleUrl: WebViewURL?
    
    @State var errorMessage: String = ""
    @State var isShowAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if let highlightArticle {
                        HighlightNewsView(article: highlightArticle)
                            .onTapGesture {
                                if let urlString = highlightArticle.url, let url = URL(string: urlString) {
                                    articleUrl = WebViewURL(url: url)
                                }
                            }
                    }
                    
                    ForEach(articles) { article in
                        NewsView(article: article)
                            .onTapGesture {
                                if let urlString = article.url, let url = URL(string: urlString) {
                                    articleUrl = WebViewURL(url: url)
                                }
                            }
                    }
                }
            }
            .navigationTitle("Today")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await loadTopHeadlines()
            }
            .fullScreenCover(item: $articleUrl) { articleUrl in
                SFSafariWebView(url: articleUrl.url)
                    .ignoresSafeArea()
            }
            .alert("An Error Occurred", isPresented: $isShowAlert) {
                Button("OK") { }
            } message: {
                Text(errorMessage)
            }

        }
    }
    
    func loadTopHeadlines() async {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=4ab80a57dcd1405f8fdbd016bc0e2957") else { return }
        
        do {
            let (data, httpResponse) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            guard let httpResponse = httpResponse as? HTTPURLResponse else { return }
            
            switch httpResponse.statusCode {
            case 200...299:
                let response = try decoder.decode(News.self, from: data)
                
                if let news = response.articles, !news.isEmpty {
                    highlightArticle = news.first
                    articles = news
                    articles.removeFirst()
                }
            default:
                let error = try decoder.decode(ErrorResponse.self, from: data)
                errorMessage = error.message
                isShowAlert = true
            }
            

        } catch {
            print("Error: \(error)")
        }
    }
}

#Preview {
    TopStoriesView()
}
