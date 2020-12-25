//
//  adf.swift
//  CustomPresentation
//
//  Created by Nguyen, Cong on 2020/12/25.
//

import UIKit

class AnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
  let isPresenting: Bool

  init(isPresenting: Bool) {
    self.isPresenting = isPresenting
    super.init()
  }

  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.3
  }

  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    if isPresenting {
      let presented = transitionContext.viewController(forKey: .to)!
      let presenting = transitionContext.viewController(forKey: .from)!
      let containerView = transitionContext.containerView

      containerView.addSubview(presented.view)
      presented.view.frame = transitionContext.viewController(forKey: .to)!.presentationController!.frameOfPresentedViewInContainerView
      presented.view.frame.origin.x = -presented.view.frame.width
      UIView.animate(withDuration: 0.3, animations: {
        presented.view.frame.origin.x = 0
        presenting.view.frame.origin.x = presented.view.frame.width
      }) { _ in
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      }
    } else {
      let presented = transitionContext.viewController(forKey: .from)!
      let presenting = transitionContext.viewController(forKey: .to)!

      UIView.animate(withDuration: 0.3, animations: {
        presented.view.frame.origin.x = -presented.view.frame.width
        presenting.view.frame.origin.x = 0
      }) { _ in
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      }
    }
  }
}
