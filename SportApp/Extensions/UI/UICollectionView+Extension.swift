import UIKit
import Foundation

// MARK: - extension for register view as Cell.

extension UICollectionView {

    func register(_ cell: UICollectionViewCell.Type) {
        register(cell, forCellWithReuseIdentifier: cell.reuseID)
    }
}
