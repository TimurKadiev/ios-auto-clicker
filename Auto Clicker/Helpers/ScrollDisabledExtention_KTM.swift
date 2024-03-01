//
//  ScrollViewDisabled.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 16.06.2023.
//

import SwiftUI
import Combine

protocol KeyboardReadable_KTM {
    var keyboardPublisherKTM: AnyPublisher<Bool, Never> { get }
}

extension KeyboardReadable_KTM {
    var keyboardPublisherKTM: AnyPublisher<Bool, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .map { _ in true },
            
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in false }
        )
        .eraseToAnyPublisher()
        
    }
}
