import SwiftUI

struct AskAnythingTextView: View {
    @Binding var text: String
    @FocusState.Binding var isFocused: Bool
    var onSend: (String) -> Void = { _ in }
    var baseHeight: CGFloat = 44
    
    private let maxLines = 7
    private let lineHeight: CGFloat = 20
    
    private var dynamicHeight: CGFloat {
        let lineCount = max(1, text.components(separatedBy: .newlines).count)
        let clampedLines = min(lineCount, maxLines)
        
        if lineCount == 1 && text.isEmpty {
            return baseHeight // Match plus button height when empty
        } else {
            let calculatedHeight = CGFloat(clampedLines) * lineHeight + 24 // 24 for padding
            return max(baseHeight, calculatedHeight)
        }
    }
    
    var body: some View {
        TextEditor(text: $text)
            .foregroundColor(.white)
            .font(.body)
            .focused($isFocused)
            .scrollContentBackground(.hidden)
            .background(Color.clear)
            .overlay(
                // Placeholder text
                VStack {
                    HStack {
                        if text.isEmpty {
                            Text("Ask anything")
                                .foregroundColor(.gray)
                                .font(.body)
                                .allowsHitTesting(false)
                        }
                        Spacer()
                    }
                    Spacer()
                }
                .padding(.top, 8)
                .padding(.leading, 4)
            )
            .onSubmit {
                // Handle return key - do nothing, let it create new line
            }
    }
    

}

// Helper extension for placeholder
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

#Preview {
    @Previewable @FocusState var focused: Bool
    @Previewable @State var text = ""
    return AskAnythingTextView(text: $text, isFocused: $focused, baseHeight: 44)
        .background(Color.black)
}
