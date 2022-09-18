import UIKit

final class TopTabsCollectionView: UICollectionView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        static let spaceBetweenElements: CGFloat = 8
    }
    
    // MARK: - UICollectionView
    
    convenience init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        self.init(frame: .zero, collectionViewLayout: layout)
        setupUI()
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Private Methods

private extension TopTabsCollectionView {
    
    func setupUI() {
        showsHorizontalScrollIndicator = false
    }
}
