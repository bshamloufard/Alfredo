import SwiftUI

struct HamburgerMenuView: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 3) {
                Rectangle()
                    .fill(Color(red: 208/255, green: 208/255, blue: 208/255))
                    .frame(width: 20, height: 2)
                
                Rectangle()
                    .fill(Color(red: 208/255, green: 208/255, blue: 208/255))
                    .frame(width: 20, height: 2)
                
                Rectangle()
                    .fill(Color(red: 208/255, green: 208/255, blue: 208/255))
                    .frame(width: 20, height: 2)
            }
        }
        .frame(width: 44, height: 44)
    }
}

#Preview {
    HamburgerMenuView(action: {})
        .background(Color.black)
}
