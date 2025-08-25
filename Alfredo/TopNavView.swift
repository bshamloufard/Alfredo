import SwiftUI

struct TopNavView: View {
    let toggleDrawer: () -> Void
    
    var body: some View {
        HStack {
            // Left side - Hamburger menu
            HamburgerMenuView(action: toggleDrawer)
            
            Spacer()
            
            Spacer()
            
            // Right side - Ghost icon
            GhostIconView()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(red: 20/255, green: 20/255, blue: 20/255))
    }
}

#Preview {
    TopNavView(toggleDrawer: {})
        .background(Color.black)
}
