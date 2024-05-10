import Foundation

// The Note class represents a note entity with text, last updated date, and computed properties for title and description.
class Note {
    // Unique identifier for the note
    let id = UUID()
    
    // The text content of the note
    var text: String = ""
    
    // The last updated date of the note
    var lastUpdated: Date = Date()
    
    // Computed property to extract the title from the text, which is the first line of the note
    var title: String {
        return text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).first ?? ""
    }
    
    // Computed property to extract the description from the text, which is the second line along with the last updated date
    var desc: String {
        var lines = text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
        lines.removeFirst()
        return "\(lastUpdated.format()) \(lines.first ?? "")"
    }
}
