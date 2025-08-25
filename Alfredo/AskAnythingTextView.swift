import SwiftUI

struct AskAnythingTextView: View {
    @State private var text = ""
    @FocusState.Binding var isFocused: Bool
    
    var body: some View {
        HStack {
            TextField("Ask anything", text: $text)
                .foregroundColor(.white)
                .font(.body)
                .textFieldStyle(PlainTextFieldStyle())
                .focused($isFocused)
                .placeholder(when: text.isEmpty) {
                    Text("Ask anything")
                        .foregroundColor(.gray)
                        .font(.body)
                }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
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
    @FocusState var focused: Bool
    return AskAnythingTextView(isFocused: $focused)
        .background(Color.black)
}
