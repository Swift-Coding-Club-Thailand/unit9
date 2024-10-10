//
//  SFSafariWebView.swift
//  News
//
//  Created by Momo on 8/9/2567 BE.
//

import SwiftUI
import SafariServices

struct SFSafariWebView: UIViewControllerRepresentable {
    
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let vc = SFSafariViewController(url: url)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
    
}

struct WebViewURL: Identifiable {
    let id = UUID()
    var url: URL
}
