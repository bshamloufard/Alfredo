import Foundation

struct ChatMessage: Identifiable {
    let id = UUID()
    let content: String
    let isUser: Bool
    let timestamp: Date
    
    init(content: String, isUser: Bool) {
        self.content = content
        self.isUser = isUser
        self.timestamp = Date()
    }
}

enum ChatState: Equatable {
    case idle
    case toolDetection(toolType: ToolType)
    case thinking
    case responding
}

// Function to analyze message content and determine which tool to use
func detectToolFromMessage(_ message: String) -> ToolType? {
    let lowercasedMessage = message.lowercased()
    
    if lowercasedMessage.contains("gmail") || lowercasedMessage.contains("mail") {
        return .email
    } else if lowercasedMessage.contains("bank") {
        return .finances
    } else if lowercasedMessage.contains("calendar") {
        return .calendar
    } else if lowercasedMessage.contains("message") || lowercasedMessage.contains("imessage") {
        return .imessage
    } else {
        // No tool detected
        return nil
    }
}
