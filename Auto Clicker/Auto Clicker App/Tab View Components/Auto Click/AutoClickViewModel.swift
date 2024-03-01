//
//  AutoClickViewModel.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 14.06.2023.
//

import SwiftUI
import WebKit
import Combine
import Reachability

class AutoClickViewModel: ObservableObject {
    @Published var url: URL? {
        didSet {
            guard let url = url?.description else { return }
            textForURL = url
        }
    }
    @Published var urlSlide: URL? {
        didSet {
            guard let url = urlSlide?.description else { return }
            textForSplitURL = url
        }
    }
    @Published var topScreenShow = true
    @Published var bottomScreenShow = true
    
    @Published var tVView = false
    @Published var showAlert = false
    @Published var focusedMin = false
    @Published var focusedSec = false
    @Published var focusedCount = false
    @Published var showSettings = false
    @Published var showMenuPopUp = false
    @Published var clickingNow = false
    @Published var showKeyboard = false
    @Published var clickModeView = false
    @Published var showSettingView = false
    @Published var webViwIsShowing = false
    @Published var clickingNowSplit = false
    @Published var isClickModeMulti = false
    @Published var isClickModeSplit = false
    @Published var tuchedSplitMouse = false
    @Published var isAutoRefreshMode = false
    @Published var isClickModeSingle = false
    @Published var slideCounterButton = true
    @Published var doClickInSplitView = false
    @Published var safariClickModeView = false
    @Published var webViwIsShowingSlide = false
    @Published var multiClickTextMin = "0"
    @Published var multiClickTextSec = "1"
    @Published var isShowClickDisplayView = false
    @Published var shouldStartClickOptions = false
    @Published var slideCounterBottomButton = true
    @Published var isShowAlertWebExitClikView = false
    @Published var isShowMultiClickDisplayView = false
    @Published var shouldStartClickOptionsSplit = false
    @Published var shouldStartClickOptionsMulti = false
    @Published var title = ""
    @Published var textForURL = ""
    @Published var textForSplitURL = ""
    @Published var textEditName = ""
    @Published var textEditURL = ""
    @Published var textForAlert = ""
    
    @Published var clickCounts = "0" {
        didSet {
            let filteredString = clickCounts.filter { $0.isNumber }
            if filteredString != clickCounts {
                clickCounts = filteredString
            }
        }
    }
    @Published var multiRepeat = "1" {
        didSet {
            let filteredString = multiRepeat.filter { $0.isNumber }
            if filteredString != multiRepeat {
                multiRepeat = filteredString
            }
        }
    }
    @Published var multiRepeatForSave = "1" {
        didSet {
            let filteredString = multiRepeatForSave.filter { $0.isNumber }
            if filteredString != multiRepeatForSave {
                multiRepeatForSave = filteredString
            }
        }
    }
    @Published var clickDisplayViewTextFieldMin = "" {
        didSet {
            let filteredString = clickDisplayViewTextFieldMin.filter { $0.isNumber }
            if filteredString != clickDisplayViewTextFieldMin {
                clickDisplayViewTextFieldMin = filteredString
            }
            
            if let min = Int(clickDisplayViewTextFieldMin) {
                if min > 59 {
                    clickDisplayViewTextFieldMin = "59"
                }
            }
        
        }
    }
    @Published var clickDisplayViewTextFieldSec = "1" {
        didSet {
            let filteredString = clickDisplayViewTextFieldSec.filter { $0.isNumber }
            if filteredString != clickDisplayViewTextFieldSec {
                clickDisplayViewTextFieldSec = filteredString
            }
            if let seconds = Int(clickDisplayViewTextFieldSec) {
                if seconds > 59 {
                    clickDisplayViewTextFieldSec = "59"
                }
            }
        }
    }
    @Published var clickDisplayViewTextFieldCount = "1" {
        didSet {
            let filteredString = clickDisplayViewTextFieldCount.filter { $0.isNumber }
            if filteredString != clickDisplayViewTextFieldCount {
                clickDisplayViewTextFieldCount = filteredString
            }
            
            if let count = Int(clickDisplayViewTextFieldCount) {
                if count > 500 {
                    clickDisplayViewTextFieldCount = "500"
                }
            }
            
        }
    }
    
    @Published var splitOffset = CGSize.zero
    
    @Published var circleOffset = CGSize.zero
    @Published var circleSplitOffset = CGSize.zero
    
    @Published var safariTab: SafariTabModel = .firstStep
    
    @Published var idSelect: UUID = .init()

    @Published var webview = WKWebView()
    @Published var webviewSlide = WKWebView()
    
    @Published var multiClickModel: [MultiClickModel] = []
    @Published var multiClickModelForSave: [MultiClickModel] = []
    
    @Published var isAppMinimized = false {
        didSet {
            if isAppMinimized {
                shouldStartClickOptions = false
                shouldStartClickOptionsSplit = false
                shouldStartClickOptionsMulti = false
            }
        }
    }
    
    private var cancellable: AnyCancellable?
    
    var safariTabModel: [SafariTabModel] = SafariTabModel.allCases
    
    var autoClickCells: [AutoClickCellsModel] = [
        AutoClickCellsModel(name: "SingleID", description: "SingleDescription", isUnlocked: true, image: "instance_image"),
        AutoClickCellsModel(name: "MultiID", description: "MultiDescription", isUnlocked: true, image: "layers_image"),
        AutoClickCellsModel(name: "RefreshID", description: "RefreshDescription", isUnlocked: true, image: "arrows-reload_image"),
        AutoClickCellsModel(name: "SplitID", description: "SplitDescription", isUnlocked: false, image: "main-component_image"),
        AutoClickCellsModel(name: "SafariID", description: "SafariDescription", isUnlocked: false, image: "globe_image"),
    ]
    
    var fastLinkCollection: [ LinkFastCollection_KTM] = [
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
        
    func keybordShow() -> Bool {
        if focusedMin || focusedSec || focusedCount {
            return true
        } else {
            return false
        }
    }
    
    func openCellsFullScreen(_ cell:  AutoClickCellsModel) {
        
        title = cell.name
        if cell.name == "SafariID" {
            openSafariClickModeView(1)
        } else if cell.name == "TV Remote" {
            openTVView(1)
        } else {
            openClickModeView(cell)
        }
    }
    
    private func openSafariClickModeView(_ index: Int) {
        let value = index
        safariClickModeView = true
    }
    private func openTVView(_ index: Int) {
        var index = index
        tVView = true
    }
    private func openClickModeView(_ cell:  AutoClickCellsModel) {
        clickModeView = true
        if cell.name == "SingleID" {
            isClickModeSingle = true
        } else if cell.name == "MultiID" {
            isClickModeMulti = true
        } else if cell.name == "SplitID" {
            isClickModeSplit = true
        } else {
            isAutoRefreshMode = true
        }
    }
    
    func closeClickModeView() {
        clickModeView = false
        
        webViwIsShowing = false
        isClickModeSingle = false
        isClickModeMulti = false
        isClickModeSplit = false
        isAutoRefreshMode = false
        
        webViwIsShowingSlide = false
        textForURL = ""
        webview = WKWebView()
        textForSplitURL = ""
        webviewSlide = WKWebView()
        multiClickModelDelateAllElement()
        shouldStartClickOptions = false
        shouldStartClickOptionsSplit = false
        topScreenShow = true
        bottomScreenShow = true
    }
    func closeSafariClickModeView() { lazy var status = false
        safariClickModeView = false
    }
    func closeTVView_KTM() { lazy var value = 1
        value += 5
        tVView = false
    }
    
    
    func tapOnFastLink(_ link:  LinkFastCollection_KTM) {
        let reachability = try! Reachability()
        if reachability.connection == .unavailable {
            textForAlert = "InternetError"
            showAlert = true
            return
        }
        textForURL = link.ownLink
        guard let url = URL(string: link.ownLink) else { return }
        loadRequest_KTM(request: URLRequest(url: url))
        webViwIsShowing = true
    }
    
    func tapOnFastLinkSlide(_ link:  LinkFastCollection_KTM) {
        let reachability = try! Reachability()
        if reachability.connection == .unavailable {
            textForAlert = "InternetError"
            showAlert = true
            return
        }
        textForSplitURL = link.ownLink
        guard let url = URL(string: link.ownLink) else { return }
        loadRequestSlide(request: URLRequest(url: url))
        webViwIsShowingSlide = true
    }
    
    
    func doSerchInWebView() {
        let reachability = try! Reachability()
        if reachability.connection == .unavailable {
            textForAlert = "InternetError"
            showAlert = true
            return
        }
        searchFor(searchText: textForURL)
        webViwIsShowing = true
    }
    
    func doSerchInWebViewSlide() {
        let reachability = try! Reachability()
        if reachability.connection == .unavailable {
            textForAlert = "InternetError"
            showAlert = true
            return
        }
        searchForSlide(searchText: textForSplitURL)
        webViwIsShowingSlide = true
    }
    
    func keyboardWasOpened() { lazy var string = "ref"
        showKeyboard = true
    }
    func keyboardWasClosed() { lazy var ref = "refactoring"
        showKeyboard = false
    }
    
    func showClickDisplayView(_ isSplitView: Bool) {
        if isSplitView {
            doClickInSplitView = true
            if shouldStartClickOptionsSplit {
                shouldStartClickOptionsSplit = false
            } else {
                isShowClickDisplayView = true
            }
        } else {
            if shouldStartClickOptions {
                shouldStartClickOptions = false
            } else {
                isShowClickDisplayView = true
            }
        }
    }
    
    func closeClickDisplayView() {
        doClickInSplitView = false
        isShowClickDisplayView = false
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func showMultiClickDisplayView() { lazy var string = "ref"
        isShowMultiClickDisplayView = true
    }
    
    func closeMultiClickDisplayView() {
        multiClickModel = multiClickModelForSave
        multiRepeat = multiRepeatForSave
        isShowMultiClickDisplayView = false
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func starClicking() { lazy var string = "false"
        closeClickDisplayView()
        getClickOptions()
    }
    func starClickingSplit() {  lazy var fer5 = "refactoring"
        closeClickDisplayView()
        getClickOptionsSplit()
    }
    
    func searchFor(searchText: String) {
        if let searchTextNormalized = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
           let url = URL(string: "https://google.com/search?q=\(searchTextNormalized)") { self.loadRequest_KTM(request: URLRequest(url: url))
        }
    }
    
    func loadRequest_KTM(request: URLRequest) {
        var i = 12
        switch Bool.random() {
        case true: if i == 21 { i += 1}
        case false : if i == 31 { i -= 1}
        }
        webview.load(request)
    }
    
    func goBack_KTM() { lazy var ref = "String"
        var i = 12
        switch Bool.random() {
        case true: if i == 21 { i += 1}
        case false : if i == 31 { i -= 1}
        }
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
        webViwIsShowing = false
        shouldStartClickOptions = false
        shouldStartClickOptionsMulti = false
        webview = WKWebView()
    }
    
    func refresh_KTM() { lazy var refactoring = true
        webview.reload()
    }
    
    func searchForSlide(searchText: String) {
        if let searchTextNormalized = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
           let url = URL(string: "https://google.com/search?q=\(searchTextNormalized)") { self.loadRequestSlide(request: URLRequest(url: url))
        }
    }
    
    func loadRequestSlide(request: URLRequest) { lazy var ref = "KTM"
        webviewSlide.load(request)
    }
    
//    func goBackSlide() {
//        webviewSlide.goBack()
//    }
    
//    func goForwardSlide() {
//        webviewSlide.goForward()
//    }
    
    func goHomeSlide() {
        textForSplitURL = ""
        webViwIsShowingSlide = false
        shouldStartClickOptionsSplit = false
        webviewSlide = WKWebView()
    }
    
//    func refreshSlide() {
//        webviewSlide.reload()
//    }
    
    func hideSlideCounterButton() { lazy var refactor = false
        slideCounterButton = false
        topScreenShow = false
        bottomScreenShow = true
    }
    func showSlideCounterButton() { lazy var refactor  = true
        slideCounterButton = true
    }
    func hideSlideBottomCounterButton() { lazy var bool = false
        slideCounterBottomButton = false
        topScreenShow = true
        bottomScreenShow = false
    }
    func showSlideBottomCounterButton() { lazy var string = "Refactoring"
        slideCounterBottomButton = true
    }
    
    func getClickOptions() { lazy var ref = "String"
        var refactor = ref
        let reachability = try! Reachability()
        if reachability.connection == .unavailable {
            textForAlert = "InternetError"
            showAlert = true
            return
        }
        if clickDisplayViewTextFieldMin == "" {
            clickDisplayViewTextFieldMin = "0"
        }
        if clickDisplayViewTextFieldSec == "" {
            clickDisplayViewTextFieldSec = "0"
        }
        
        guard let min = Int(clickDisplayViewTextFieldMin),
              let sec = Int(clickDisplayViewTextFieldSec),
              let countClicks = Int(clickDisplayViewTextFieldCount)
        else {
            textForAlert = "valueEror"
            showAlert = true
            return
        }
        guard countClicks >= 1 else { return }
        
        let sumSec = min * 60 + sec
        let clickPerSecond = Double(sumSec) / Double(countClicks)
        
        guard clickPerSecond >= 0.002 else {
            textForAlert = "Error1"
            showAlert = true
            return
        }
        shouldStartClickOptions = true
        
        var clickCountConverter = 0 {
            didSet {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.clickCounts = clickCountConverter.description
                    if self.isAutoRefreshMode {
                        self.refresh_KTM()
                    } else {
                        self.simulateTap(at: CGPoint(x: self.circleOffset.width, y: self.circleOffset.height), false)
                        self.clickingNow = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            self.clickingNow = false
                        }
                    }
                }
            }
        }
        
        let queue = DispatchQueue(label: "com.example.clickQueue")
        let timer = DispatchSource.makeTimerSource(queue: queue)
        
        timer.schedule(deadline: .now(), repeating: DispatchTimeInterval.microseconds(Int(clickPerSecond * 1_000_000)))
        var currentClicks = 0
        
        timer.setEventHandler {
            if currentClicks < countClicks {
                if !self.shouldStartClickOptions {
                    timer.cancel()
                    return
                }
                
                let reachabilityInClick = try! Reachability()
                if reachabilityInClick.connection == .unavailable {
                    timer.cancel()
                    DispatchQueue.main.async {
                        self.textForAlert = "InternetError"
                        self.shouldStartClickOptions = false
                        self.showAlert = true
                        return
                    }
                }
                
                clickCountConverter += 1
                currentClicks += 1
                self.playClickSound()
            } else {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.shouldStartClickOptions = false
                }
                timer.cancel()
            }
        }
        timer.resume()
    }
    
    func getClickOptionsSplit() {
        let reachability = try! Reachability()
        if reachability.connection == .unavailable {
            textForAlert = "InternetError"
            showAlert = true
            return
        }
        if clickDisplayViewTextFieldMin == "" {
            clickDisplayViewTextFieldMin = "0"
        }
        if clickDisplayViewTextFieldSec == "" {
            clickDisplayViewTextFieldSec = "0"
        }
        
        guard let min = Int(clickDisplayViewTextFieldMin),
              let sec = Int(clickDisplayViewTextFieldSec),
              let countClicks = Int(clickDisplayViewTextFieldCount)
        else {
            textForAlert = "valueEror"
            showAlert = true
            return
        }
        
        let sumSec = min * 60 + sec
        let clickPerSecond = Double(sumSec) / Double(countClicks)
        
        guard clickPerSecond >= 0.002 else {
            textForAlert = "Error1"
            showAlert = true
            return
        }
        
        shouldStartClickOptionsSplit = true
        
        var clickCountConverter = 0 {
            didSet {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.clickCounts = clickCountConverter.description
                    
                    self.simulateTapSplit(at: CGPoint(x: self.circleSplitOffset.width, y: self.circleSplitOffset.height), true)
                    self.clickingNowSplit = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.clickingNowSplit = false
                        
                    }
                }
            }
        }
        
        let queue = DispatchQueue(label: "com.example.clickQueue")
        let timer = DispatchSource.makeTimerSource(queue: queue)
        
        timer.schedule(deadline: .now(), repeating: DispatchTimeInterval.microseconds(Int(clickPerSecond * 1_000_000)))
        var currentClicks = 0
        
        timer.setEventHandler {
            if currentClicks < countClicks {
                if !self.shouldStartClickOptionsSplit {
                    timer.cancel()
                    return
                }
                
                let reachabilityInClick = try! Reachability()
                if reachabilityInClick.connection == .unavailable {
                    timer.cancel()
                    DispatchQueue.main.async {
                        self.textForAlert = "InternetError"
                        self.shouldStartClickOptionsSplit = false
                        self.showAlert = true
                        return
                    }
                }
                
                clickCountConverter += 1
                currentClicks += 1
                self.playClickSound()
            } else {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.shouldStartClickOptionsSplit = false
                }
                timer.cancel()
            }
        }
        timer.resume()
    }
    
    func playClickSound() {
        SettingManager.shared.checkOnSound()
    }
    
    func simulateTap(at point: CGPoint,_ isSplitViewClick: Bool) {
        let javascript = """
            var elem = document.elementFromPoint(\(point.x + ScreenSize_KTM.KTM_width / 2 ), \(point.y + ScreenSize_KTM.KTM_height * 0.48));
            var event = new MouseEvent('click', {
                'view': window,
                'bubbles': true,
                'cancelable': true
            });
            elem.dispatchEvent(event);
        """
        if isSplitViewClick {
            webviewSlide.evaluateJavaScript(javascript, completionHandler: nil)
        } else {
            webview.evaluateJavaScript(javascript, completionHandler: nil)
        }
    }
    
    func simulateTapSplit(at point: CGPoint,_ isSplitViewClick: Bool) {
        let javascript = """
            var elem = document.elementFromPoint(\(point.x + ScreenSize_KTM.KTM_width / 2 ), \(point.y + ScreenSize_KTM.KTM_height * 0.35 - 28));
            var event = new MouseEvent('click', {
                'view': window,
                'bubbles': true,
                'cancelable': true
            });
            elem.dispatchEvent(event);
        """
        if isSplitViewClick {
            webviewSlide.evaluateJavaScript(javascript, completionHandler: nil)
        } else {
            webview.evaluateJavaScript(javascript, completionHandler: nil)
        }
    }
    
    func onEndedCircleOffset(_ value: GestureStateGesture<DragGesture, CGSize>.Value) {
        tuchedSplitMouse = false
        let newWidth = circleOffset.width + value.translation.width
        let newHeight = circleOffset.height + value.translation.height
        circleOffset.width = min(max(newWidth, -ScreenSize_KTM.KTM_width / 2 + 22), ScreenSize_KTM.KTM_width / 2 + 5)
        circleOffset.height = min(max(newHeight, -ScreenSize_KTM.KTM_height * 0.45 - 5), ScreenSize_KTM.KTM_height * 0.35 + 5)
    }
    
    func onEndedSplitOffset(_ value: GestureStateGesture<DragGesture, CGSize>.Value) {
        splitOffset.height += value.translation.height
        if splitOffset.height <= ScreenSize_KTM.KTM_height * 0.15 {
            splitOffset.height = ScreenSize_KTM.KTM_height * 0.1
            hideSlideCounterButton()
            showSlideBottomCounterButton()
        } else if splitOffset.height >= ScreenSize_KTM.KTM_height * 0.8 {
            splitOffset.height = ScreenSize_KTM.KTM_height * 0.7
            hideSlideBottomCounterButton()
            showSlideCounterButton()
            //            showSlideBottomCounterButton()
            //            topScreenShow = true
            //            bottomScreenShow = true
        } else {
            showSlideCounterButton()
            showSlideBottomCounterButton()
            topScreenShow = true
            bottomScreenShow = true
        }
    }
    
    
    
    func onEndedcircleSplitOffset(_ value: GestureStateGesture<DragGesture, CGSize>.Value) {
        tuchedSplitMouse = true
        let newWidth = circleSplitOffset.width + value.translation.width
        let newHeight = circleSplitOffset.height + value.translation.height
        circleSplitOffset.width = min(max(newWidth, -ScreenSize_KTM.KTM_width / 2 + 22), ScreenSize_KTM.KTM_width / 2 + 5)
        circleSplitOffset.height = min(max(newHeight, -ScreenSize_KTM.KTM_height * 0.35 - 5), ScreenSize_KTM.KTM_height * 0.35 + 5)
    }
    
    func saveMultiClickOptions() {
        multiClickModelForSave = multiClickModel
        multiRepeatForSave = multiRepeat
        
        closeMultiClickDisplayView()
    }
    
    func playOrStopMultiClicking() {
        if shouldStartClickOptionsMulti {
            shouldStartClickOptionsMulti = false
        } else {
            startClickingMultiClickMode()
        }
    }
    
    func startClickingMultiClickMode() {
        guard let repeats = Int(multiRepeat)
        else {
            textForAlert = "valueEror"
            showAlert = true
            shouldStartClickOptionsMulti = false
            return
        }
        
        var currentClickIndex = 0
        var currentRepeat = 0
        
        let reachability = try! Reachability()
        if reachability.connection == .unavailable {
            textForAlert = "InternetError"
            showAlert = true
            return
        }
        
        shouldStartClickOptionsMulti = true
        
        func playNextClick() {
            guard shouldStartClickOptionsMulti else { return }
            let reachabilityInClick = try! Reachability()
            if reachabilityInClick.connection == .unavailable {
                DispatchQueue.main.async {
                    self.textForAlert = "InternetError"
                    self.shouldStartClickOptionsMulti = false
                    self.showAlert = true
                    return
                }
            }
            let click = multiClickModel[currentClickIndex]
            
            guard let min = Int(click.min),
                  let sec = Int(click.sec)
            else {
                textForAlert = "valueEror"
                showAlert = true
                shouldStartClickOptionsMulti = false
                return
            }
            let sumSecDelay = min * 60 + sec
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(sumSecDelay)) {
                if !self.shouldStartClickOptionsMulti { return }
                
                let clickPoint: CGPoint = CGPoint(x: click.offsetWidth, y: click.offsetHeight)
                self.simulateTap(at: clickPoint, false)
                self.playClickSound()
                
                for index in self.multiClickModel.indices {
                    if self.multiClickModel[index].id == click.id {
                        self.multiClickModel[index].clickingNow = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    for index in self.multiClickModel.indices {
                        if self.multiClickModel[index].id == click.id {
                            self.multiClickModel[index].clickingNow = false
                        }
                    }
                }
                
                currentClickIndex += 1
                if currentClickIndex >= self.multiClickModel.count {
                    currentClickIndex = 0
                    currentRepeat += 1
                    if currentRepeat >= repeats {
                        self.shouldStartClickOptionsMulti = false
                        return
                    }
                }
                playNextClick()
            }
        }
        playNextClick()
    }
    
    func multiClickModelCreateElement() {
        let numberOfElementsToAdd = 1 + multiClickModel.count
        let newElement = MultiClickModel(tapNumber: numberOfElementsToAdd, offsetWidth: CGFloat(numberOfElementsToAdd) * 10 - ScreenSize_KTM.KTM_width * 0.3)
        multiClickModel.append(newElement)
        multiClickModelForSave.append(newElement)
        shouldStartClickOptionsMulti = false
    }
    func multiClickModelDelateLastElement() {
        if multiClickModel.count > 0 {
            self.multiClickModel.removeLast()
            self.multiClickModelForSave.removeLast()
            shouldStartClickOptionsMulti = false
        }
    }
    func multiClickModelDelateAllElement() {
        if multiClickModel.count > 0 {
            self.multiClickModel.removeAll()
            self.multiClickModelForSave.removeAll()
            shouldStartClickOptionsMulti = false
        }
    }
    
    func doExitWeb() {
        closeAlertWebExitClikView()
        if topScreenShow && bottomScreenShow {
            if webViwIsShowing {
                goHome_KTM()
            } else {
                goHomeSlide()
            }
        } else if topScreenShow {
            goHome_KTM()
        } else if bottomScreenShow {
            goHomeSlide()
        }
    }
    
    func closeAlertWebExitClikView() {
        isShowAlertWebExitClikView = false
    }
    
    func openAlertWebExitClikView() {
        isShowAlertWebExitClikView = true
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


