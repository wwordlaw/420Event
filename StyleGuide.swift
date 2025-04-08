import SwiftUI

// MARK: - Color Definitions
extension Color {
    // Initialize Color from Hex String (Required)
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0) // Default to black on error
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: Double(a) / 255)
    }

    // Style Guide Colors
    static let eggHuntPink = Color(hex: "#F4C5C3")
    static let eggHuntYellow = Color(hex: "#F9F0C0")
    static let eggHuntMint = Color(hex: "#D3F9E7")
    static let eggHuntLavender = Color(hex: "#D5D0FF")
    static let eggHuntOrchid = Color(hex: "#F0CAEA")
    static let eggHuntOlive = Color(hex: "#B5AE7A")
    static let eggHuntDarkBlue = Color(hex: "#1E5175")
    static let mint = Color(hex: "D2FFE7")
    static let dark = Color(hex: "85AEZA")
    // Note: Original hex #85AEZA might be a typo for #B5AE7A (Olive) or maybe #85AE7A? Using Olive for now.
    // If #85AE7A is correct, the 'Z' needs to be a digit/letter A-F. Assuming Olive intended:
    static let darkGreen = Color.eggHuntOlive // Color(hex: "#85AE7A")

    // Usage-specific Colors
    // static let sheetBackground = Color.eggHuntMint // << REMOVED - Replaced by gradient
    static let mainText = Color.eggHuntDarkBlue // Assumption based on visual guide
}

// MARK: - Gradient Definitions
extension LinearGradient {
    static var mainBackground: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [.eggHuntPink, .eggHuntLavender]),
            startPoint: .top,
            endPoint: .bottom
        )
    }

    // --- NEW GRADIENT for Sheet Backgrounds ---
    // Creates a vertical gradient, e.g., from Mint to Lavender.
    // Adjust the colors array as desired using your defined palette colors.
    static var sheetBackgroundGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [.mint, .dark]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
    // --- END NEW GRADIENT ---
}

// MARK: - Font Definitions
extension Font {
    private static func appFont(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        return .system(size: size, weight: weight)
    }

    // Style Guide Fonts (adjust sizes based on actual design needs)
    static let heading = appFont(size: 28, weight: .regular) // Example Size
    static let subheading = appFont(size: 22, weight: .regular) // Example Size
    static let body = appFont(size: 17, weight: .regular) // Example Size
    static let caption = appFont(size: 12, weight: .regular) // Example Size for smaller text
}

// MARK: - Style Modifiers (Example)
struct MainBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(LinearGradient.mainBackground.ignoresSafeArea())
    }
}

// --- UPDATED SheetBackground ViewModifier ---
// Now applies the new sheetBackgroundGradient
struct SheetBackground: ViewModifier {
     func body(content: Content) -> some View {
         content
            // Apply the new gradient and ignore safe area by default
            .background(LinearGradient.sheetBackgroundGradient.ignoresSafeArea())
     }
}
// --- END UPDATED ViewModifier ---
