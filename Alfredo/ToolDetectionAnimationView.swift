import SwiftUI

struct ToolDetectionAnimationView: View {
    let toolType: ToolType
    @State private var showRiveAnimation = true
    @State private var showToolCard = false
    @State private var currentToolType: ToolType?
    
    var body: some View {
        VStack {
            if showRiveAnimation {
                // Rive animation
                ThinkingAnimationView()
            }
            
            if showToolCard {
                ToolCardView(toolType: toolType)
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .onAppear {
            // Reset state when view appears
            resetAnimation()
        }
        .onChange(of: toolType) {
            // Reset animation when tool type changes
            resetAnimation()
        }
    }
    
    private func resetAnimation() {
        // Reset to initial state
        showRiveAnimation = true
        showToolCard = false
        currentToolType = toolType
        
        // After 3 seconds, hide rive animation and show tool card
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            withAnimation(.easeInOut(duration: 0.3)) {
                showRiveAnimation = false
            }
            
            // Show tool card after brief delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    showToolCard = true
                }
            }
        }
    }
}

#Preview {
    VStack(spacing: 40) {
        ToolDetectionAnimationView(toolType: .email)
        ToolDetectionAnimationView(toolType: .imessage)
    }
    .padding()
    .background(Color.black)
}
