import SwiftUI

struct BottomTextView: View {
    @FocusState.Binding var isTextFieldFocused: Bool
    var onSend: (String) -> Void = { _ in }
    @State private var textInput = ""
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 12) {
            // Plus button component - stays at bottom
            PlusButtonView()
            
            // Chat input area with text field and send button
            HStack(alignment: .bottom, spacing: 8) {
                // Text input that grows naturally
                ZStack(alignment: .topLeading) {
                    TextField("", text: $textInput, axis: .vertical)
                        .foregroundStyle(Color(red: 208/255, green: 208/255, blue: 208/255))
                        .font(.body)
                        .focused($isTextFieldFocused)
                        .textFieldStyle(PlainTextFieldStyle())
                        .tint(Color(red: 208/255, green: 208/255, blue: 208/255))
                        .lineLimit(1...7)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .onSubmit {
                            // Don't handle submit here - let return key create new lines
                        }
                    
                    // Custom placeholder text with exact color control
                    if textInput.isEmpty {
                        Text("Ask anything")
                            .foregroundColor(Color(red: 208/255, green: 208/255, blue: 208/255))
                            .font(.body)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .allowsHitTesting(false) // Allow taps to pass through to TextField
                    }
                }
                
                // Send button inside the container
                Button(action: handleSend) {
                    Image(systemName: "arrow.up")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(width: 28, height: 28)
                        .background(Circle().fill(Color(red: 208/255, green: 208/255, blue: 208/255)))
                }
                .padding(.trailing, 12)
                .padding(.bottom, 12)
            }
            .background(
                RoundedRectangle(cornerRadius: 22)
                    .fill(Color(red: 26/255, green: 26/255, blue: 26/255))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 22)
                    .stroke(Color(red: 32/255, green: 32/255, blue: 32/255), lineWidth: 1)
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
