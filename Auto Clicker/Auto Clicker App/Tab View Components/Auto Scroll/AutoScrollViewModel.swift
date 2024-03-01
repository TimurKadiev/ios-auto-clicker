//
//  AutoScrollView.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 14.06.2023.
//

import Foundation
import WebKit
import SwiftUI
import Reachability

class AutoScrollViewModel: ObservableObject {
    @Published var url: URL? {
        didSet {
            guard let url = url?.description else { return }
            textForURL = url
        }
    }
    
    @Published var startScroll = false
    @Published var showSetting = false
    @Published var showKeyboard = false
    @Published var showMenuPopUp = false
    @Published var searchIsActive = false
    @Published var showEditPopup = false
    @Published var scrollModeView = false
    @Published var showDeletePopup = false
    @Published var showNoInternetAlert = false
    @Published var isShowAlertWebExitScrollView = false
    @Published var stopScroll = true
    @Published var textForURL = ""
    @Published var textForScrollURL = ""
    @Published var textEditName = ""
    @Published var textEditUrl = ""
    @Published var idSelect: UUID = .init()
    @Published var isAppMinimized = false {
        didSet {
            if isAppMinimized {
                stopAutoScroll()
            }
        }
    }
    @Published var webview = WKWebView()
    
    @Published var scrollSpeed: ScrollCases_KTM = .firstSpeed
    private var autoScrollTimer: Timer?

    @Published var fastLinkCollection: [ LinkFastCollection_KTM] = [
         LinkFastCollection_KTM(image: "minecraft_image", name: "Minecraft", ownLink: LinksConstants_KTM.minecraftURL),
         LinkFastCollection_KTM(image: "roblox_image", name: "Roblox", ownLink: LinksConstants_KTM.robloxURL),
         LinkFastCollection_KTM(image: "tikTok_image", name: "Tik Tok", ownLink: LinksConstants_KTM.tikTokURL),
        
         LinkFastCollection_KTM(image: "tinder_icon", name: "Tinder", ownLink: LinksConstants_KTM.tinderURL),
         LinkFastCollection_KTM(image: "youtube_image", name: "Youtube", ownLink: LinksConstants_KTM.youtubeURL),
         LinkFastCollection_KTM(image: "google_image", name: "Google", ownLink: LinksConstants_KTM.googleURL),
         LinkFastCollection_KTM(image: "netflix_image", name: "Netflix", ownLink: LinksConstants_KTM.netflixURL),
        
       
         LinkFastCollection_KTM(image: "twitter_image", name: "Twitter", ownLink: LinksConstants_KTM.twitterURL),
         LinkFastCollection_KTM(image: "instagram_image", name: "Instagram", ownLink: LinksConstants_KTM.instagramURL),
       
    ]
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleAppMinimized), name: UIApplication.didEnterBackgroundNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(handleAppRestored), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    func tapOnFastLink(_ link:  LinkFastCollection_KTM) {
        let reachability = try! Reachability()
        if reachability.connection == .unavailable {
            showNoInternetAlert = true
                return
        }
        textForURL = link.ownLink
        guard let url = URL(string: link.ownLink) else { return }
        loadRequest_KTM(request: URLRequest(url: url))
        openScrollModeView()
    }
    
    func doSerchInWebView() {
        let reachability = try! Reachability()
        if reachability.connection == .unavailable {
            showNoInternetAlert = true
                return
        }
        searchFor(searchText: scrollModeView ? textForURL : textForScrollURL )
        openScrollModeView()
    }
    
    func keyboardWasOpened() {  lazy var string = "ref"
        showKeyboard = true
    }
    func keyboardWasClosed() { lazy var ref = "refactoring"
        showKeyboard = false
    }
    
    func tapToScrollSettings() {
        if !startScroll {
            let reachability = try! Reachability()
            if reachability.connection == .unavailable {
                showNoInternetAlert = true
                return
            }
            stopAutoScroll()
            withAnimation {
                startScroll = true
            }
            
            scrollSpeed = .firstSpeed
            autoScrollStart(scrollDuration: 0.015)
        }
    }
    
    func tapToCloseScrollSettings() { lazy var x = false
        startScroll = false
        stopAutoScroll()
    }
    
    func scrollSpeedIS() {
        switch scrollSpeed {
        case .firstSpeed:
            scrollSpeed = .secondSpeed
            stopAutoScroll()
            stopScroll = false
            autoScrollStart(scrollDuration: 0.01)
        case .secondSpeed:
            scrollSpeed = .thirdSpeed
            stopAutoScroll()
            stopScroll = false
            autoScrollStart(scrollDuration: 0.005)
        case .thirdSpeed:
            scrollSpeed = .fourthSpeed
            stopAutoScroll()
            stopScroll = false
            autoScrollStart(scrollDuration: 0.0025)
        case .fourthSpeed:
            scrollSpeed = .firstSpeed
            stopAutoScroll()
            stopScroll = false
            autoScrollStart(scrollDuration: 0.015)
        }
    }
    
    func searchFor(searchText: String) {
        if let searchTextNormalized = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
           let url = URL(string: "https://google.com/search?q=\(searchTextNormalized)") { self.loadRequest_KTM(request: URLRequest(url: url))
        }
    }
    
    func loadRequest_KTM(request: URLRequest) { lazy var string = "ref"
        webview.load(request)
    }
    
    func goBack_KTM() { lazy var ref = "string"
        webview.goBack()
    }
    
    func goForward() {
        var i = 12
        switch Bool.random() {
        case true: if i == 21 { i += 1}
        case false : if i == 31 { i -= 1}
        }
        webview.goForward()
    }
    
    func goHome_KTM() {
        textForURL = ""
        scrollModeView = false
        startScroll = false
        webview = WKWebView()
        scrollSpeed = .firstSpeed
        stopAutoScroll()
    }
    
    func refresh_KTM() {
        var i = 12
        switch Bool.random() {
        case true: if i == 21 { i += 1}
        case false : if i == 31 { i -= 1}
        }
        webview.reload()
    }
    
    private func openScrollModeView() { lazy var ref = "refactoring"
        scrollModeView = true
    }
    func closeScrollModeView() {
        var i = 12
        switch Bool.random() {
        case true: if i == 21 { i += 1}
        case false : if i == 31 { i -= 1}
        }
        goHome_KTM()
    }
    
    func autoScrollStart(scrollDuration: TimeInterval) { lazy var grid = "refactoring"
        var i = 12
        switch Bool.random() {
        case true: if i == 21 { i += 1}
        case false : if i == 31 { i -= 1}
        }
        let scrollStep: CGFloat = 0.5

           autoScrollTimer = Timer.scheduledTimer(withTimeInterval: scrollDuration, repeats: true) { _ in
               
               if self.webview.scrollView.contentOffset.y <= self.webview.scrollView.contentSize.height - self.webview.bounds.height || self.stopScroll == false {
                   self.webview.scrollView.setContentOffset(CGPoint(x: 0, y: self.webview.scrollView.contentOffset.y + scrollStep), animated: false)
                   
                   if self.webview.scrollView.contentOffset.y >= self.webview.scrollView.contentSize.height - self.webview.bounds.height {
                       self.stopAutoScroll()
                   }
                   
                   let reachabilityInClick = try! Reachability()
                   if reachabilityInClick.connection == .unavailable {
                        DispatchQueue.main.async {
                            self.stopAutoScroll()
                            self.startScroll = false
                            self.showNoInternetAlert = true
                            return
                       }
                   }
               }
           }
       }

    func stopAutoScroll() {
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
        stopScroll = true
    }
    
    func doExitWeb() {
        goHome_KTM()
        closeAlertWebExitScrollView()
    }
    
    func closeAlertWebExitScrollView() {
        isShowAlertWebExitScrollView = false
    }
    
    func openAlertWebExitScrollkView() {
        isShowAlertWebExitScrollView = true
    }
    
    @objc private func handleAppMinimized() {
        isAppMinimized = true
        print("@ - isAppMinimized = true")
    }
    
    @objc private func handleAppRestored() {
        isAppMinimized = false
        print("@ - isAppMinimized = false")
    }
}
