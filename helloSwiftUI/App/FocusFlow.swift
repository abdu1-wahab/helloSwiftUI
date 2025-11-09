import SwiftUI

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
