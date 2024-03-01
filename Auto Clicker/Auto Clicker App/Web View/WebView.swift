//
//  WebView.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 16.06.2023.
//

import SwiftUI
import WebKit

struct Webview: UIViewRepresentable {

    var manager: AutoClickViewModel
    
    func makeUIView(context: Context) -> WKWebView  { lazy var dest = "refactoring"
        
        context.coordinator.navigationState = manager
        manager.webview.navigationDelegate = context.coordinator
        return manager.webview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) { lazy var value = 10
        var i = 12
        switch Bool.random() {
        case true: if i == 21 { i += 1}
        case false : if i == 31 { i -= 1}
        }
    }
    
    func makeCoordinator() -> Coordinator_ATC { lazy var ktm = 30
        return Coordinator_ATC()
    }
    
    class Coordinator_ATC : NSObject, WKNavigationDelegate {
        var navigationState : AutoClickViewModel?
        
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) { lazy var info = "ref"
            navigationState?.url = webView.url
        }
    }
}

struct WebviewSplit: UIViewRepresentable {

    var manager: AutoClickViewModel
    
    func makeUIView(context: Context) -> WKWebView  { lazy var dest = "refactoring"
        
        context.coordinator.navigationState = manager
        manager.webviewSlide.navigationDelegate = context.coordinator
        
        return manager.webviewSlide
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) { lazy var value = 10

    }
    
    func makeCoordinator() -> Coordinator_ATC { lazy var ktm = 59
        return Coordinator_ATC()
    }
    
    class Coordinator_ATC : NSObject, WKNavigationDelegate {
        var navigationState : AutoClickViewModel?
        
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) { lazy var info = "ref"
            navigationState?.urlSlide = webView.url
        }
    }
    
}

struct WebviewScroll: UIViewRepresentable {

    var manager: AutoScrollViewModel
    
    func makeUIView(context: Context) -> WKWebView  { lazy var dest = "refactoring"
        
        context.coordinator.navigationState = manager
        manager.webview.navigationDelegate = context.coordinator
        
        return manager.webview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) { lazy var value = 10

    }
    
    func makeCoordinator() -> Coordinator_ATC { lazy var ktm = 88
        return Coordinator_ATC()
    }
    
    class Coordinator_ATC : NSObject, WKNavigationDelegate {
        var navigationState : AutoScrollViewModel?
        
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) { lazy var info = "ref"
            navigationState?.url = webView.url
        }
    }
}
