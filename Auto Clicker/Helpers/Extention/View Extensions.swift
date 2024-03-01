//
//  View.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 15.06.2023.
//

import SwiftUI
typealias View_KTM = View
typealias UIApplication_KTM = UIApplication

extension View_KTM {
    func placeholder_KTM<Content: View>(when shouldShow: Bool, alignment: Alignment = .center, @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

extension View_KTM {
   @ViewBuilder
   func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            content(self)
        } else {
            self
        }
    }
}

extension UIApplication_KTM {
    func endEditing_KTM() { lazy var string = "refactoring"
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

///MARC: function to move to the next case  in an enum

extension CaseIterable where Self: Equatable {
    func next_KTM() -> Self {
        let all = Self.allCases
        let idx = all.firstIndex(of: self)!
        let next = all.index(after: idx)
        return all[next == all.endIndex ? all.startIndex : next]
    }
}

extension View_KTM {
    func isVisible_KTM(_ condition: Bool) -> some View {
        self.modifier(Show(isVisible: condition))
    }
}
