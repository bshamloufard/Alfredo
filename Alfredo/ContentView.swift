import SwiftUI

struct ContentView: View {
    // Customizable bottom component Y-axis position (distance from bottom)
    @State private var bottomComponentOffset: CGFloat = 0
    
    // Two-page layout state management
    @State private var isLeftPageVisible: Bool = false
    @State private var dragOffset: CGFloat = 0
    @FocusState private var isTextFieldFocused: Bool
    
    private let leftPageWidth: CGFloat = 280 // Width of the left page
    private let openThreshold: CGFloat = 100 // Threshold for auto-open
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                // Left Page (Drawer)
                DrawerView()
                    .frame(width: leftPageWidth)
                
                // Right Page (Main content) - EXACT original layout restored
                ZStack {
                    // Background color
                    Color(red: 20/255, green: 20/255, blue: 20/255)
                        .ignoresSafeArea()
                    
                    VStack(spacing: 0) {
                        // Top Navigation
                        TopNavView(toggleDrawer: togglePages)
                        
                        Spacer()
                        
                        // Bottom Text Input Area
                        BottomTextView(isTextFieldFocused: $isTextFieldFocused)
                            .padding(.bottom, bottomComponentOffset)
                            .gesture(
                                // Vertical gestures ONLY on the text input component
                                DragGesture()
                                    .onEnded { value in
                                        if !isLeftPageVisible { // Only when drawer is closed
                                            let verticalMovement = value.translation.height
                                            
                                            if verticalMovement < -50 { // Swipe up on component
                                                isTextFieldFocused = true
                                            } else if verticalMovement > 50 { // Swipe down on component
                                                isTextFieldFocused = false
                                            }
                                        }
                                    }
                            )
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .allowsHitTesting(!isLeftPageVisible) // Block interaction when drawer is open
                .contentShape(Rectangle()) // Make entire area tappable
                .onTapGesture {
                    if isLeftPageVisible {
                        // Tap visible main page area to close drawer
                        togglePages()
                    } else if isTextFieldFocused {
                        // Tap anywhere to dismiss keyboard when it's active
                        isTextFieldFocused = false
                    }
                }

            }
            .offset(x: isLeftPageVisible ? 0 + dragOffset : -leftPageWidth + dragOffset)
            .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isLeftPageVisible)
            .gesture(
                // Horizontal gestures for drawer control (anywhere on screen)
                DragGesture()
                    .onChanged { value in
                        handleDragChanged(value: value)
                    }
                    .onEnded { value in
                        handleDragEnded(value: value)
                    }
            )
        }
    }
    
    // MARK: - Page Functions
    private func togglePages() {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            isLeftPageVisible.toggle()
        }
        
        // Haptic feedback
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
    }
    
    private func handleDragChanged(value: DragGesture.Value) {
        let translation = value.translation.width
        
        if isLeftPageVisible {
            // Left page is visible, allow closing with left swipe (anywhere on screen)
            dragOffset = max(-leftPageWidth, min(0, translation))
        } else {
            // Left page is hidden, allow opening with right swipe (anywhere on screen)
            dragOffset = max(0, min(leftPageWidth, translation))
        }
    }
    
    private func handleDragEnded(value: DragGesture.Value) {
        let translation = value.translation.width
        let velocity = value.predictedEndTranslation.width
        
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            if isLeftPageVisible {
                // Left page is visible, decide whether to close
                if translation < -openThreshold || velocity < -500 {
                    // Close left page
                    isLeftPageVisible = false
                    
                    // Haptic feedback for close
                    let impactFeedback = UIImpactFeedbackGenerator(style: .light)
                    impactFeedback.impactOccurred()
                }
            } else {
                // Left page is hidden, decide whether to open
                if translation > openThreshold || velocity > 500 {
                    // Open left page
                    isLeftPageVisible = true
                    
                    // Haptic feedback for open
                    let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
                    impactFeedback.impactOccurred()
                }
            }
            
            // Reset drag offset
            dragOffset = 0
        }
    }
}

#Preview {
    ContentView()
}
