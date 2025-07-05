import SwiftUI


struct CalenderVC: View {
    
    @Environment(\.dismiss) var dismiss
    //@ObservedObject var taskViewModel: TaskViewModel
    
    
    var currentDate: Date {
        Calendar.current.date(byAdding: .month, value: currentMonthOffset, to: Date())!
    }
    @State private var currentMonthOffset = 0
    @State private var showMonthYearPicker = false
    @State private var selectedDate = Date()
    @State private var selectedMonth = Calendar.current.component(.month, from: Date())
    @State private var selectedYear = Calendar.current.component(.year, from: Date())
    
    var currentYear: Int { Calendar.current.component(.year, from: Date()) }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                
                // top Bar
                HStack {
                    Button(action: {
                        dismiss()
                    })  {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(Color(hex: "7C7C7C"))
                            .frame(width: 4, height: 4)
                            .padding()
                            .background(Color(hex: "#1B1B1D"))
                            .clipShape(Circle())
                            .shadow(radius: 1)
                    }
                    
                    Spacer()
                    
                    Text("Calender")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    Color.clear.frame(width: 48, height: 48)
                }
                .padding(.horizontal, 2)
                .padding(.bottom,10)
                
                // Calender View
                VStack() {
                    
                    // Top calender view
                    HStack {
                        Button(action: swipeToPreviousMonth) {
                            Image("calender_backward_img")
                        }
                        
                        Spacer()
                        
                        Text(currentDate.formatted(.dateTime.month().year()))
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .onTapGesture {
                                withAnimation {
                                    showMonthYearPicker = true
                                }
                            }
                        
                        Spacer()
                        
                        Button(action: swipeToNextMonth) {
                            Image("calender_forward_img")
                        }
                    }
                    .padding(.top,20)
                    
                    // Weekdays header
                    HStack {
                        ForEach(Date.capitalizedShortWeekdays, id: \.self) { day in
                            Text(day)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    
                    TabView(selection: $currentMonthOffset) {
                        ForEach(-120...120, id: \.self) { offset in
                            CalendarGridView(
                                referenceDate: Calendar.current.date(byAdding: .month, value: offset, to: Date())!,
                                selectedDate: $selectedDate
                            )
                                .tag(offset)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .frame(height: 250)
                    
                    
                }
                .padding(.horizontal, 10)
                .background(Color(hex: "#1B1B1D"))
                .cornerRadius(16)
                
                HStack {
                    Text("Mon,June 2,2025")
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    Spacer()
                    
                    Image("tasks_status_img")
                    Text("3 tasks")
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    
                }
                .padding(.horizontal, 10)
                .padding(.top, 8)
                
                
                
                Spacer()
            }
        }
    }
    
    private func swipeToNextMonth() {
        if currentMonthOffset < 120 {
            currentMonthOffset += 1
        }
    }

    
    private func swipeToPreviousMonth() {
        if currentMonthOffset > -120 {
            currentMonthOffset -= 1
        }
    }
}

#Preview {
    CalenderVC()
}
