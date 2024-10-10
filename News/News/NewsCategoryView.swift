//
//  NewsCategoryView.swift
//  News
//
//  Created by Momo on 21/8/2567 BE.
//

import SwiftUI

struct NewsCategoryView: View {
    
    var article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let urlString = article.urlToImage, let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } placeholder: {
                    ProgressView()
                }
            } else {
                Color.gray
                    .frame(width: 120, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            Text(article.title ?? "")
                .font(.system(size: 12, weight: .bold))
                .lineLimit(3)
            if let date = article.publishedAt {
                let formatter = RelativeDateTimeFormatter()
                Text(formatter.localizedString(for: date, relativeTo: Date()))
                    .font(.system(size: 12))
            }
        }
        .frame(width: 120)
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
    
    return NewsCategoryView(article: article)
}
