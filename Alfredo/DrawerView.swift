import SwiftUI

struct DrawerView: View {
    var body: some View {
        // Drawer content area with right border overlay
        VStack {
            // Drawer content will go here
            Text("Drawer Content")
                .foregroundColor(Color(red: 208/255, green: 208/255, blue: 208/255))
                .font(.title2)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 20/255, green: 20/255, blue: 20/255))
        .overlay(
            // Simple right border as overlay
            Rectangle()
                .fill(Color(red: 32/255, green: 32/255, blue: 32/255))
                .frame(width: 1)
                .frame(maxHeight: .infinity),
            alignment: .trailing
        )
    }
}

#Preview {
    DrawerView()
}
