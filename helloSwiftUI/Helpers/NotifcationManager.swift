import Foundation

import UserNotifications

final class NotificationManager {
    
    static let shared = NotificationManager()
    private init() {}

    // MARK: - Request Permission
    func requestAuthorizationIfNeeded() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard settings.authorizationStatus != .authorized else { return }
            
            UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert, .sound, .badge]
            ) { granted, error in
                if let error = error {
                    print("Notification permission error: \(error)")
                } else {
                    print(granted ? "Notification permission granted" : "Notification permission denied")
                }
            }
        }
    }

    // MARK: - Schedule Notification
    func scheduleNotification(id: String, title: String, listId: String, date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Task Reminder"
        content.body = title
        content.sound = .default
        content.interruptionLevel = .timeSensitive
        content.userInfo = [
            "taskId": id,
            "listId": listId,
            "title": title
        ]

        let triggerDate = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: date
        )

        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("🔴 Failed to schedule notification for task \(id): \(error.localizedDescription)")
            } else {
                print("✅ Notification scheduled for task \(id) in list \(listId)")
            }
        }
    }

    // MARK: - Cancel Notification
    func cancelNotification(id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
        print("Cancelled notification for \(id)")
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let userInfo = response.notification.request.content.userInfo
        if let taskId = userInfo["taskId"] as? String,
           let listId = userInfo["listId"] as? String {
            // Call navigation logic here
            //DeepLinkHandler.shared.openTask(with: taskId, inList: listId)
        }
        completionHandler()
    }

}
