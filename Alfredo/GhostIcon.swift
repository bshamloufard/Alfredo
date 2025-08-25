import SwiftUI

struct GhostIconView: View {
    var body: some View {
        Button(action: {
            // Future functionality - person icon action
            print("Person icon tapped")
        }) {
            Image(systemName: "person.crop.circle")
                .font(.title2)
                .foregroundColor(Color(red: 208/255, green: 208/255, blue: 208/255))
        }
        .frame(width: 44, height: 44)
    }
}

#Preview {
    GhostIconView()
        .background(Color.black)
}
