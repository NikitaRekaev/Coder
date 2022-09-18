import UIKit

final class TopTabsCollectionView: UICollectionView {
    
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
