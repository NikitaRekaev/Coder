import UIKit

final class BottomSheetPresentationController: UIPresentationController {
    
    // MARK: - Views
    
    private lazy var backdropView: UIView = {
        let view = UIView()
        view.backgroundColor = sheetBackdropColor
        view.alpha = .zero
        return view
    }()
    
    let bottomSheetInteractiveDismissalTransition = BottomSheetInteractiveDismissalTransition()
    
    //MARK: - Properties
    
    let sheetTopInset: CGFloat
    let sheetCornerRadius: CGFloat
    let sheetSizingFactor: CGFloat
    let sheetBackdropColor: UIColor
    
    private(set) lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
        gesture.cancelsTouchesInView = false
        return gesture
    }()
    
    private lazy var panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan))
    var panToDismissEnabled: Bool = true
    
    // MARK: - Initialization
    
    init(
        presentedViewController: UIViewController,
        presenting presentingViewController: UIViewController?,
        sheetTopInset: CGFloat,
        sheetCornerRadius: CGFloat,
        sheetSizingFactor: CGFloat,
        sheetBackdropColor: UIColor
    ) {
        self.sheetTopInset = sheetTopInset
        self.sheetCornerRadius = sheetCornerRadius
        self.sheetSizingFactor = sheetSizingFactor
        self.sheetBackdropColor = sheetBackdropColor
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    // MARK: UIPresentationController
    
    override func presentationTransitionWillBegin() {
        guard let presentedView = presentedView else {
            return
        }
        
        presentedView.addGestureRecognizer(panGestureRecognizer)
        
        presentedView.layer.cornerRadius = sheetCornerRadius
        presentedView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        
        guard let containerView = containerView else {
            return
        }
        
        containerView.addGestureRecognizer(tapGestureRecognizer)
        
        containerView.addSubview(backdropView)
        
        backdropView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backdropView.topAnchor.constraint(
                equalTo: containerView.topAnchor
            ),
            backdropView.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor
            ),
            backdropView.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor
            ),
            backdropView.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor
            ),
        ])
        
        containerView.addSubview(presentedView)
        
        presentedView.translatesAutoresizingMaskIntoConstraints = false
        
        let preferredHeightConstraint = presentedView.heightAnchor.constraint(
            equalTo: containerView.heightAnchor,
            multiplier: sheetSizingFactor
        )
        
        preferredHeightConstraint.priority = .fittingSizeLevel
        
        let topConstraint = presentedView.topAnchor.constraint(
            greaterThanOrEqualTo: containerView.safeAreaLayoutGuide.topAnchor,
            constant: sheetTopInset
        )
        
        // Prevents conflicts with the height constraint used by the animated transition
        topConstraint.priority = .required - 1
        
        let heightConstraint = presentedView.heightAnchor.constraint(
            equalToConstant: .zero
        )
        
        let bottomConstraint = presentedView.bottomAnchor.constraint(
            equalTo: containerView.bottomAnchor
        )
        
        NSLayoutConstraint.activate([
            topConstraint,
            presentedView.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor
            ),
            presentedView.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor
            ),
            bottomConstraint,
            preferredHeightConstraint
        ])
        
        bottomSheetInteractiveDismissalTransition.bottomConstraint = bottomConstraint
        bottomSheetInteractiveDismissalTransition.heightConstraint = heightConstraint
        
        guard let transitionCoordinator = presentingViewController.transitionCoordinator else {
            return
        }
        
        transitionCoordinator.animate { context in
            self.backdropView.alpha = 0.3
        }
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            backdropView.removeFromSuperview()
            presentedView?.removeGestureRecognizer(panGestureRecognizer)
            containerView?.removeGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    override func dismissalTransitionWillBegin() {
        guard let transitionCoordinator = presentingViewController.transitionCoordinator else {
            return
        }
        
        transitionCoordinator.animate { context in
            self.backdropView.alpha = .zero
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            backdropView.removeFromSuperview()
            presentedView?.removeGestureRecognizer(panGestureRecognizer)
            containerView?.removeGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        panGestureRecognizer.isEnabled = false // This will cancel any ongoing pan gesture
        coordinator.animate(alongsideTransition: nil) { context in
            self.panGestureRecognizer.isEnabled = true
        }
    }
}

// MARK: - Actions

@objc
private extension BottomSheetPresentationController {
    
    func onTap(_ gestureRecognizer: UITapGestureRecognizer) {
        guard
            let presentedView = presentedView,
            let containerView = containerView,
            !presentedView.frame.contains(gestureRecognizer.location(in: containerView))
        else {
            return
        }
        
        presentingViewController.dismiss(animated: true)
    }
    
    func onPan(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard let presentedView = presentedView else {
            return
        }
        
        let translation = gestureRecognizer.translation(in: presentedView)
        
        let progress = translation.y / presentedView.frame.height
        
        switch gestureRecognizer.state {
        case .began:
            bottomSheetInteractiveDismissalTransition.start(
                moving: presentedView, interactiveDismissal: panToDismissEnabled
            )
        case .changed:
            if panToDismissEnabled && progress > 0 && !presentedViewController.isBeingDismissed {
                presentingViewController.dismiss(animated: true)
            }
            bottomSheetInteractiveDismissalTransition.move(
                presentedView, using: translation.y
            )
        default:
            let velocity = gestureRecognizer.velocity(in: presentedView)
            bottomSheetInteractiveDismissalTransition.stop(
                moving: presentedView, at: translation.y, with: velocity
            )
        }
    }
}
