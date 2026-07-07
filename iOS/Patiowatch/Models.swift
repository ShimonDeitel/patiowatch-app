import Foundation

struct PatioItem: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var itemName: String = ""
    var lastCleaned: Date = Date()
    var stored: Bool = false
}
