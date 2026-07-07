import SwiftUI

/// Bespoke palette for Patiowatch — tuned for its own domain, not shared.
enum Theme {
    static let accent = Color(red: 0.10, green: 0.42, blue: 0.32)
    static let accentSoft = Color(red: 0.35, green: 0.72, blue: 0.55)
    static let background = Color(red: 0.05, green: 0.09, blue: 0.07)
    static let card = Color(red: 0.05, green: 0.09, blue: 0.07).opacity(0.92)

    static let titleFont = Font.system(.largeTitle, design: .serif).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)
}
