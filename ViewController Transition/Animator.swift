//
//  Animator.swift
//  ViewController Transition
//
//  Created by Iyin Raphael on 1/10/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit

class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? ViewController,
            let toVC = transitionContext.viewController(forKey: .to) as? RedViewController,
            let toView = transitionContext.view(forKey: .to) else {
                return
        }
        let containerView = transitionContext.containerView
        
        let destinationViewFrame = transitionContext.finalFrame(for: toVC)
        containerView.addSubview(toView)
        toView.frame = destinationViewFrame
        toView.alpha = 0
        
        let sourceLabel = fromVC.label!
        let destinationLabel = toVC.label!
        sourceLabel.alpha = 0
        destinationLabel.alpha = 0
        
        let labelInitialFrame = containerView.convert(sourceLabel.bounds, from: sourceLabel)
        
        let animationLabel = UILabel()
        animationLabel.frame = labelInitialFrame
        animationLabel.text = destinationLabel.text
        animationLabel.font = destinationLabel.font
        containerView.addSubview(animationLabel)
        
        toView.layoutIfNeeded()
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            animationLabel.frame = containerView.convert(destinationLabel.bounds, from: destinationLabel)
            toView.alpha = 1
            
        }) { (success) in
            destinationLabel.alpha = 1
            sourceLabel.alpha = 1
            animationLabel.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
