import SwiftUI

struct PlusButtonView: View {
    var body: some View {
        Button(action: {
            // Future functionality - plus button action
            print("Plus button tapped")
        }) {
            Image(systemName: "plus")
                .font(.title3)
                .fontWeight(.medium)
                .foregroundColor(Color(red: 208/255, green: 208/255, blue: 208/255))
        }
        .frame(width: 44, height: 44)
        .background(
            Circle()
                .fill(Color(red: 26/255, green: 26/255, blue: 26/255))
        )
    }
}

#Preview {
    PlusButtonView()
        .background(Color.black)
}
