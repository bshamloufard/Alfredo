import SwiftUI

enum ToolType: CaseIterable, Equatable {
    case calendar
    case finances
    case email
    case imessage
    
    var symbolName: String {
        switch self {
        case .calendar:
            return "calendar"
        case .finances:
            return "creditcard.fill"
        case .email:
            return "envelope.fill"
        case .imessage:
            return "bubble.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .calendar:
            return Color(red: 255/255, green: 169/255, blue: 83/255) // FFA953
        case .finances:
            return Color(red: 83/255, green: 255/255, blue: 129/255) // 53FF81
        case .email:
            return Color(red: 235/255, green: 66/255, blue: 54/255) // EB4236
        case .imessage:
            return Color(red: 31/255, green: 140/255, blue: 255/255) // 1F8CFF
        }
    }
    
    var displayText: String {
        switch self {
        case .calendar:
            return "Changing\nSchedule"
        case .finances:
            return "Fetching\nBanking Info"
        case .email:
            return "Generating\nEmail"
        case .imessage:
            return "Generating\nMessage"
        }
    }
}

struct ToolCardView: View {
    let toolType: ToolType
    @State private var isAnimating = false
    
    var body: some View {
        HStack(spacing: 16) {
            // SF Symbol on the left
            Image(systemName: toolType.symbolName)
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(toolType.color)
                .symbolEffect(.bounce.up.byLayer, options: .repeat(.periodic(delay: 1.0)), isActive: isAnimating)
            
            // Text on the right
            Text(toolType.displayText)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(toolType.color.opacity(0.15))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(toolType.color, lineWidth: 2)
                )
        )
        .onAppear {
            isAnimating = true
            // Stop animation after a few seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                isAnimating = false
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        ToolCardView(toolType: .email)
        ToolCardView(toolType: .imessage)
        ToolCardView(toolType: .finances)
        ToolCardView(toolType: .calendar)
    }
    .padding()
    .background(Color.black)
}
