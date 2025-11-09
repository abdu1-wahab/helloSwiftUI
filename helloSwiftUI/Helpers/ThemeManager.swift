import Foundation
import SwiftUI

final class ThemeManager: ObservableObject {
    
    @Published var currentTheme: AppTheme {
        didSet {
            UserDefaults.standard.set(currentTheme.rawValue, forKey: "AppTheme")
        }
    }
    
    init() {
        if let saved = UserDefaults.standard.string(forKey: "AppTheme"),
           let theme = AppTheme(rawValue: saved) {
            self.currentTheme = theme
        } else {
            self.currentTheme = .dark
        }
    }
    
    var backgroundPrimary: Color {
        switch currentTheme {
        case .dark: return Color(hex: "#000000")
        case .light: return Color(hex: "#F1F1F1")
        }
    }
    
    var backgroundSecondary: Color {
        switch currentTheme {
        case .dark: return Color(hex: "#1B1B1D")
        case .light: return Color(hex: "#FFFFFF")
        }
    }
    
    var textPrimary: Color {
        switch currentTheme {
        case .dark: return Color.white
        case .light: return Color(hex: "1B1B1D")
        }
    }
    
    var textSecondary: Color {
        switch currentTheme {
        case .dark: return Color(hex: "7E7E7E")
        case .light: return Color(hex: "7E7E7E")
        }
    }
    
    var accent: Color {
        Color(hex: "#3B82F6")
    }
}

