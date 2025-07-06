import SwiftUI

// acts as main entry point for the swift ui app
@main
struct FocusFlow: App {
    @StateObject private var themeManager = ThemeManager()
    init() {
            NotificationManager.shared.requestAuthorizationIfNeeded()
            //UNUserNotificationCenter.current().delegate = MyNotificationDelegate()
        }
    var body: some Scene {
        WindowGroup {
            SplashVC()
                .environmentObject(themeManager)
        }
    }
}
