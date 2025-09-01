import SwiftUI
import RiveRuntime

struct ThinkingAnimationView: View {
    var body: some View {
        RiveViewModel(fileName: "Loading", animationName: "Timeline 1")
            .view()
            .frame(width: 40, height: 40)
    }
}

#Preview {
    ThinkingAnimationView()
        .background(Color.black)
}
