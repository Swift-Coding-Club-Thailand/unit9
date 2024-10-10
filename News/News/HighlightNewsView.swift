//
//  HighlightNewsView.swift
//  News
//
//  Created by Momo on 4/8/2567 BE.
//

import SwiftUI

struct HighlightNewsView: View {
    
    var article: Article
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 12) {
                if let urlString = article.urlToImage, let url = URL(string: urlString) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width - 24, height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    } placeholder: {
                        ProgressView()
                    }
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text(article.source?.name ?? "-")
                        .font(.system(size: 12, weight: .medium))
                    Text(article.title ?? "-")
                        .font(.system(size: 18, weight: .bold))
                    if let date = article.publishedAt {
                        let formatter = RelativeDateTimeFormatter()
                        let formatText = formatter.localizedString(for: date, relativeTo: Date())
                        Text(formatText)
                            .font(.system(size: 12))
                    }
                }
            }
            .padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12))
            Divider()
        }
    }
}

#Preview {
    let article = Article(
        author: "John Doe",
        title: "Understanding SwiftUI: A Comprehensive Guide",
        description: "This article provides an in-depth look at SwiftUI, exploring its components, advantages, and how to get started.",
        url: "https://www.swiftnewsdaily.com/articles/swiftui-comprehensive-guide",
        urlToImage: "https://picsum.photos/200",
        publishedAt: Date().addingTimeInterval(-50000),
        content: "",
        source: Source(id: "swift-news", name: "Swift News Daily")
    )
    
    return HighlightNewsView(article: article)
}
