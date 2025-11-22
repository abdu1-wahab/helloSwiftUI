import SwiftUI

struct SettingsRowView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var item: SettingsItem
    var body: some View {
        HStack {
            Image(item.iconName)

            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .foregroundColor(themeManager.textPrimary)
                    .padding(.vertical, 2)

                Text(item.subtitle)
                    .font(.system(size: 11))
                    .fontWeight(.regular)
                    .foregroundColor(Color(hex: "A1A1AA"))
            }
            .padding(8)

            Spacer()

            if item.showToggle {
                Toggle("", isOn: $item.toggleValue)
                    .labelsHidden()
                    .tint(Color(hex: "3B82F6"))
                    .scaleEffect(0.75)
            } else if let imageName = item.trailingImageName {
                Image(imageName)
            }
        }
        .padding(15)
        .background(themeManager.backgroundSecondary)
        .cornerRadius(12)
    }
}

//#Preview {
//    SettingsRowView(iconName: "img_notification", title: "Notifcations", subtitle: "App Notifications", showToggle: true, toggleValue: true, trailingImageName: "img_arrow_right")
//}
//
