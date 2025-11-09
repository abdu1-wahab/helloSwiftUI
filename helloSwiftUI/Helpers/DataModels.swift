import Foundation
import SwiftUICore


struct Onboarding_Data: Identifiable {
    let id = UUID()
    var title: String
    var isSelected: Bool

    init(title: String, isSelected: Bool) {
        self.title = title
        self.isSelected = isSelected
    }
}

struct TO_DO_Data: Identifiable, Hashable{
    let id = UUID()
    var title: String
    var imageName: String
    var bg_clr: Color
    var total_tasks: Int
    
    init(title: String, imageName: String, bg_clr: Color, total_tasks: Int) {
        self.title = title
        self.imageName = imageName
        self.bg_clr = bg_clr
        self.total_tasks = total_tasks
    }
}

struct SettingsItem: Identifiable {
    let id = UUID()
    let iconName: String
    let title: String
    let subtitle: String
    let showToggle: Bool
    var toggleValue: Bool
    let trailingImageName: String?
}

class SettingsViewModel: ObservableObject {
    @Published var items: [SettingsItem] = [
        SettingsItem(iconName: "img_notification", title: "Notifications", subtitle: "App Notifications", showToggle: true, toggleValue: true, trailingImageName: nil),
        SettingsItem(iconName: "img_privacy", title: "Privacy", subtitle: "Manage Permissions", showToggle: false, toggleValue: false, trailingImageName: "img_arrow_right"),
        SettingsItem(iconName: "img_feedback", title: "Feedback", subtitle: "Help us improve", showToggle: false, toggleValue: false, trailingImageName: "img_arrow_right"),
        SettingsItem(iconName: "img_info", title: "About", subtitle: "App Version, Info", showToggle: false, toggleValue: false, trailingImageName: "img_arrow_right"),
        SettingsItem(iconName: "img_support", title: "Support", subtitle: "Contact Support", showToggle: false, toggleValue: false, trailingImageName: "img_arrow_right")
    ]
}

enum Route: Hashable {
    case settings
    case taskDetail(TaskList)
    case dashboardFilter(TaskFilterType)
}

enum TaskFilterType {
    case all
    case today
    case completed
    case upcoming
}

enum AppTheme: String, CaseIterable {
    case light
    case dark
}
