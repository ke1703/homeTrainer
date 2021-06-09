import UIKit
// настройка внешнего вида коллекции
final class CarouselCollectionViewFlowLayout: UICollectionViewFlowLayout {

    // MARK: - Properties.

    var space: CGFloat = 0

    // MARK: - Initialization.

    init(itemSize: CGSize, leftInset: CGFloat = 16, rightInset: CGFloat = 0, minLineSpacing: CGFloat = 16, space: CGFloat = 0) {
        super.init()
        self.space = space
        self.itemSize = itemSize
        minimumLineSpacing = minLineSpacing
        minimumInteritemSpacing = minLineSpacing
        scrollDirection = .horizontal
        sectionInset = UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {

        guard let collectionView = self.collectionView else {
            let latestOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
            return latestOffset
        }

        // Page width used for estimating and calculating paging.
        let pageWidth = self.itemSize.width + space

        // Make an estimation of the current page position.
        let approximatePage = collectionView.contentOffset.x / pageWidth

        // Determine the current page based on velocity.
        let currentPage = velocity.x == 0 ? round(approximatePage) : (velocity.x < 0.0 ? floor(approximatePage) : ceil(approximatePage))
        // Create custom flickVelocity.
        let flickVelocity: CGFloat = 1.0

        // Check how many pages the user flicked, if <= 1 then flickedPages should return 0.
        let flickedPages = (abs(round(flickVelocity)) <= 1) ? 0 : round(flickVelocity)

        // Calculate newHorizontalOffset.
        let newHorizontalOffset = ((currentPage + flickedPages) * pageWidth) - collectionView.contentInset.left

        return CGPoint(x: newHorizontalOffset, y: proposedContentOffset.y)
    }
}
