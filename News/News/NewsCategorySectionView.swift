//
//  NewsCategorySectionView.swift
//  News
//
//  Created by Momo on 21/8/2567 BE.
//

import SwiftUI

struct NewsCategorySectionView: View {
    
    var category: String
    var article: [Article]
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 12) {
                Text(category)
                    .font(.system(size: 18, weight: .bold))
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 12) {
                        ForEach(article) { article in
                            NewsCategoryView(article: article)
                        }
                    }
                }
            }
            .padding()
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
    
    return NewsCategorySectionView(category: "Business", article: [article, article])
}
