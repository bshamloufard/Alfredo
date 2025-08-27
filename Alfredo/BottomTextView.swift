import SwiftUI

struct BottomTextView: View {
    @FocusState.Binding var isTextFieldFocused: Bool
    var onSend: (String) -> Void = { _ in }
    @State private var textInput = ""
    
    private var containerHeight: CGFloat {
        let lineCount = max(1, textInput.components(separatedBy: .newlines).count)
        let clampedLines = min(lineCount, 7) // Max 7 lines
        
        if lineCount == 1 && textInput.isEmpty {
            return 44 // Exactly match plus button height when empty
        } else {
            let calculatedHeight = CGFloat(clampedLines) * 18 + 20 // 18 per line + minimal padding
            return max(44, calculatedHeight)
        }
    }
    
    private var textEditorHeight: CGFloat {
        return containerHeight - 24 // Subtract padding for text editor
    }
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 12) {
            // Plus button component - stays at bottom
            PlusButtonView()
            
            // Chat input area with controlled height
            HStack(alignment: .bottom) {
                // Ask anything text input
                AskAnythingTextView(
                    text: $textInput,
                    isFocused: $isTextFieldFocused,
                    onSend: { _ in handleSend() }
                )
                .frame(height: textEditorHeight)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                
                // Send button - stays at bottom
                SendButtonView(onSend: handleSend)
                    .padding(.trailing, 8)
                    .padding(.bottom, 12)
            }
            .frame(height: containerHeight)
            .background(
                RoundedRectangle(cornerRadius: 22) // Match plus button's circular appearance
                    .fill(Color(red: 26/255, green: 26/255, blue: 26/255))
            )
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
    
    private func handleSend() {
        let trimmedText = textInput.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedText.isEmpty {
            onSend(trimmedText)
            textInput = ""
        }
    }
}

#Preview {
    @FocusState var focused: Bool
    return BottomTextView(isTextFieldFocused: $focused)
        .background(Color.black)
}
