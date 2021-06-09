import UIKit

extension UIFont {

    // MARK: - Regular.
    ///Footnote Regular 14
    static let footnoteRegular = UIFont.systemFont(ofSize: 14, weight: .regular)
    static let textRegular = UIFont.systemFont(ofSize: 16, weight: .regular)
    static let textRegular18 = UIFont.systemFont(ofSize: 18, weight: .regular)
    static let textRegular20 = UIFont.systemFont(ofSize: 20, weight: .regular)
    static let textRegular22 = UIFont.systemFont(ofSize: 22, weight: .regular)
    static let textRegular24 = UIFont.systemFont(ofSize: 24, weight: .regular)
    
    // MARK: - Bold.
    ///Squad-Heavy  32
    static let squadHeavy = UIFont.init(name: "Squad-Heavy", size: 32) ?? UIFont.systemFont(ofSize: 32, weight: .bold)
    static let squadHeavy28 = UIFont.init(name: "Squad-Heavy", size: 28) ?? UIFont.systemFont(ofSize: 28, weight: .bold)
    ///Text Bold 16
    static let textBold16 = UIFont.systemFont(ofSize: 16, weight: .bold)
    ///Text Bold 20 /Lead Bold
    static let textBold20 = UIFont.systemFont(ofSize: 20, weight: .bold)

    // MARK: - Semi Bold.

    static let textRegular28 = UIFont.systemFont(ofSize: 24, weight: .semibold)

    // MARK: - Heavy.

    static let textHeavy50 = UIFont.systemFont(ofSize: 50, weight: .heavy)

    // MARK: - Medium.

    static let textMedium10 = UIFont.systemFont(ofSize: 12, weight: .medium)
    static let textMedium16 = UIFont.systemFont(ofSize: 16, weight: .medium)
    static let textMedium18 = UIFont.systemFont(ofSize: 18, weight: .medium)
    static let textMedium24 = UIFont.systemFont(ofSize: 24, weight: .medium)
}
