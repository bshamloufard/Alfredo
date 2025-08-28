import SwiftUI

struct ChatAreaView: View {
    let messages: [ChatMessage]
    let chatState: ChatState
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ForEach(messages) { message in
                        ChatMessageView(message: message)
                            .id(message.id)
                    }
                    
                    // Show thinking animation when AI is thinking
                    if chatState == .thinking {
                        HStack {
                            ThinkingAnimationView()
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .id("thinking")
                    }
                }
                .padding(.vertical, 16)
            }
            .onChange(of: messages.count) {
                // Auto-scroll to latest message
                if let lastMessage = messages.last {
                    withAnimation(.easeOut(duration: 0.3)) {
                        proxy.scrollTo(lastMessage.id, anchor: .bottom)
                    }
                }
            }
            .onChange(of: chatState) {
                // Auto-scroll when thinking starts
                if chatState == .thinking {
                    withAnimation(.easeOut(duration: 0.3)) {
                        proxy.scrollTo("thinking", anchor: .bottom)
                    }
                }
            }
        }
    }
}

struct ChatMessageView: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
                // User message - right aligned with background
                Text(message.content)
                    .foregroundColor(.white)
                    .font(.body)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(red: 25/255, green: 25/255, blue: 25/255)) // #191919
                    )
                    .frame(maxWidth: .infinity * 0.8, alignment: .trailing)
            } else {
                // AI response - left aligned, no background, full width
                Text(message.content)
                    .foregroundColor(.white)
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    let sampleMessages = [
        ChatMessage(content: "Hello, how can you help me today?", isUser: true),
        ChatMessage(content: "I'm here to help you with any questions or tasks you might have. What would you like to know?", isUser: false),
        ChatMessage(content: "Can you explain quantum computing?", isUser: true)
    ]
    
    return ChatAreaView(messages: sampleMessages, chatState: .thinking)
        .background(Color(red: 20/255, green: 20/255, blue: 20/255))
}
