//
//  test.swift
//  helloSwiftUI
//
//  Created by Abdul Wahab on 31/10/2025.
//
import SwiftUI
import Combine

/// A global keyboard observer that publishes keyboard height changes
final class KeyboardResponder: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    private var cancellables: Set<AnyCancellable> = []

    init() {
        let willShow = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
            .map { $0.height }

        let willHide = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }

        Publishers.Merge(willShow, willHide)
            .assign(to: \.keyboardHeight, on: self)
            .store(in: &cancellables)
    }
}


