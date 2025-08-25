import SwiftUI

struct BottomTextView: View {
    @FocusState.Binding var isTextFieldFocused: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            // Plus button component
            PlusButtonView()
            
            // Chat input area
            HStack {
                // Ask anything text input
                AskAnythingTextView(isFocused: $isTextFieldFocused)
                
                // Send button
                SendButtonView()
            }
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(red: 26/255, green: 26/255, blue: 26/255))
            )
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

#Preview {
    @FocusState var focused: Bool
    return BottomTextView(isTextFieldFocused: $focused)
        .background(Color.black)
}
