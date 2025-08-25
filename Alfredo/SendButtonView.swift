import SwiftUI

struct SendButtonView: View {
    var body: some View {
        Button(action: {
            // Future functionality - send button action
            print("Send button tapped")
        }) {
            Image(systemName: "arrow.up")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)
        }
        .frame(width: 30, height: 30)
        .background(
            Circle()
                .fill(Color(red: 208/255, green: 208/255, blue: 208/255))
        )
        .padding(.trailing, 8)
    }
}

#Preview {
    SendButtonView()
        .background(Color.black)
}
