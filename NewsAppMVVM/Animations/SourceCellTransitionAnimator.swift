//
//  ZoomTransitionAnimator.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 23.12.2021.
//

import UIKit

class SourceCellTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let isPresenting: Bool
    let presentationStartCell: UICollectionViewCell
    
    init(presentationStartCell: UICollectionViewCell, isPresenting: Bool){
        self.isPresenting = isPresenting
        self.presentationStartCell = presentationStartCell
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch isPresenting {
        case true:
            present(using: transitionContext)
        case false:
            dismiss(using: transitionContext)
        }
        
                
    }
    public func present(using transitionContext: UIViewControllerContextTransitioning){
        
        let containerView = transitionContext.containerView
        guard let presentedViewController = transitionContext.viewController(forKey: .to),
              let presentedView = transitionContext.view(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
              }
        
        let finalFrame = transitionContext.finalFrame(for: presentedViewController)
        // 1 Переворот ячейки
        
        
        AnimationHelper.perspectiveTransform(for: containerView)
        containerView.addSubview(presentationStartCell)
        
        presentedViewController.view.isHidden = true
        presentedView.layer.transform = AnimationHelper.yRotation(.pi/2)
        presentedView.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        containerView.addSubview(presentedView)
        
        
//
        UIView.animateKeyframes(withDuration: transitionDuration(using: transitionContext),
                                delay: 0,
                                options: .calculationModeCubic) { [weak self] in
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/2) {
                
                self?.presentationStartCell.layer.transform = AnimationHelper.yRotation(.pi/2)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 1/2, relativeDuration: 1/2) {
                
                presentedView.transform = CGAffineTransform(scaleX: 1, y: 1)
                presentedView.layer.transform = AnimationHelper.yRotation(0)
                presentedView.frame = finalFrame
            }
        } completion: { [weak self] finished in
            self?.presentationStartCell.removeFromSuperview()
            presentedViewController.view.isHidden = false
            transitionContext.completeTransition(finished)
            
        }

        
        // 2 отображение презентуемого контроллера в ячейке
        // 3 зум на полный экран 
        
    }

    private func dismiss(using transitionContext: UIViewControllerContextTransitioning){
        
    }
}
