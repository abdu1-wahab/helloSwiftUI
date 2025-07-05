import SwiftUI

import SwiftUI

struct TasksStatusView: View {
    let title: String
    let startDate: Date
    let endDate: Date
    let isCompleted: Bool

    private var timeRangeString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let start = formatter.string(from: startDate)
        let end = formatter.string(from: endDate)
        return "\(start) - \(end)"
    }

    private var statusText: String {
        isCompleted ? "Done" : "Pending"
    }

    private var statusColor: Color {
        isCompleted ? Color.green : Color.orange
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)

                Text(timeRangeString)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }

            Spacer()

            Text(statusText)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(statusColor)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(statusColor.opacity(0.15))
                .clipShape(Capsule())
        }
        .padding(25)
        .background(Color(hex: "#1B1B1D"))
        .cornerRadius(12)
    }
}



#Preview {
    TasksStatusView(title: "Design Meeting",
                    startDate: Date(),
                    endDate: Calendar.current.date(byAdding: .hour, value: 1, to: Date())!,
                    isCompleted: false
    )
}
