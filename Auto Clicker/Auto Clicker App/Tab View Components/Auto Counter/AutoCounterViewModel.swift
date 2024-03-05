//
//  AutoCounterViewModel.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 14.06.2023.
//

import SwiftUI

class AutoCounterViewModel: ObservableObject {
   
    @Published var showAlert = false
    @Published var showSettings = false
    @Published var isShowClickDisplayView = false
    @Published var clickCounts = "0"
    @Published var textForAlert = ""
    @Published var focusedMin: Bool = false
    @Published var focusedSec: Bool = false
    @Published var focusedCount: Bool = false
    @Published var startClick: Bool = false
    
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
                if count > 599 {
                    clickDisplayViewTextFieldCount = "599"
                }
            }
        }
    }
//    @Published var shouldStartClickOptions = false
    @Published var timer: Timer?
    @Published var timeDuration = 0
    @Published var isAppMinimized = false {
        didSet {
            if isAppMinimized {
                stopTimer()
//                shouldStartClickOptions = false
            }
        }
    }

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleAppMinimized), name: UIApplication.didEnterBackgroundNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleAppRestored), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    func startStopClick() { lazy var ref = "refactoring"
        if startClick {
            starClicking()
        } else  {
            showClickDisplayView()
        }
    }
    
    func showClickDisplayView() {
        if startClick {
//            shouldStartClickOptions = false
            stopTimer()
        } else {
            isShowClickDisplayView = true
        }
    }
    
    func closeClickDisplayView() {
        isShowClickDisplayView = false
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func starClicking() {
        closeClickDisplayView()
        clickCounts = "0"
        timeDuration = 0
        getClickOptions()
    }
    
    func getClickOptions() { lazy var int = true
        
        var refactor = int
        
        if clickDisplayViewTextFieldMin == "" {
            clickDisplayViewTextFieldMin = "0"
        }
        if clickDisplayViewTextFieldSec == "" {
            clickDisplayViewTextFieldSec = "0"
        }
        
//        clickDisplayViewTextFieldMin = "\(Int(clickDisplayViewTextFieldMin) ?? 0)"
//        clickDisplayViewTextFieldSec = "\(Int(clickDisplayViewTextFieldSec) ?? 0)"
//        clickDisplayViewTextFieldCount = "\(Int(clickDisplayViewTextFieldCount) ?? 0)"
        
        guard let min = Int(clickDisplayViewTextFieldMin),
              let sec = Int(clickDisplayViewTextFieldSec),
              var countClicks = Int(clickDisplayViewTextFieldCount)
        else {
            textForAlert = "Invalid values"
            showAlert = true
            return
        }
        if countClicks < 1 {
                textForAlert = "Error2"
                showAlert = true
                startClick = false
                return
            }
        
        let sumSec = min * 60 + sec
        let clickPerSecond = Double(sumSec) / Double(countClicks)
        
        guard clickPerSecond >= 0.002 else {
            textForAlert = "Error1"
            showAlert = true
            startClick = false
            return
        }
//        shouldStartClickOptions = true
        startTimer_ATC(sumSec: sumSec)
        
        var clickCountConverter = 0 {
            didSet {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.clickCounts = clickCountConverter.description
                }
            }
        }
        
        let queue = DispatchQueue(label: "com.example.clickQueue")
        var timer = DispatchSource.makeTimerSource(queue: queue)
        
        timer.schedule(deadline: .now(), repeating: DispatchTimeInterval.microseconds(Int(clickPerSecond * 1_000_000)))
        
        timer.setEventHandler {
            if clickCountConverter < countClicks {
                if !self.startClick {
                    timer.cancel()
                    return
                }
                
                clickCountConverter += 1
                self.playClickSound()
            } else {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
//                    self.shouldStartClickOptions = false
                    self.startClick = false
                    countClicks = 0
                }
                timer.cancel()
            }
        }
        timer.resume()
    }
    func playClickSound() {
        SettingManager.shared.checkOnSound()
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func startTimer_ATC(sumSec: Int) {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            if self.timer != nil {
                if self.timeDuration < sumSec {
                    self.timeDuration += 1
                } else {
                    self.stopTimer()
                }
            } else {
                self.stopTimer()
            }
        }
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

