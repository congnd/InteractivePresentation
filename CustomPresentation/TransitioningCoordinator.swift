//
//  ViewController.swift
//  CustomPresentation
//
//  Created by Nguyen, Cong on 2020/12/22.
//

import UIKit

class TransitioningCoordinator: NSObject, UIViewControllerTransitioningDelegate {
  let interactionController: SwipeInteractionController
  var presentationController: PresentationController!

  var dimissalInteractionController: SwipeInteractionController? {
    presentationController.interactionController
  }

  init(view: UIView) {
    interactionController = .init(view: view)
  }

  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return AnimatedTransitioning(isPresenting: true)
  }

  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return AnimatedTransitioning(isPresenting: false)
  }

  func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    guard let interactionController = dimissalInteractionController else { return nil }

    if interactionController.isInteracting {
      let transition = UIPercentDrivenInteractiveTransition()
      func toPercent(_ moved: CGFloat) -> CGFloat {
        let width = presentationController.frameOfPresentedViewInContainerView.width
        return -(moved / width)
      }
      interactionController.update = { moved in
        transition.update(toPercent(moved))
      }
      interactionController.end = { moved in
        if toPercent(moved) > 0.5 {
          transition.finish()
        } else {
          transition.cancel()
        }
      }
      return transition
    }

    return nil
  }

  func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    if interactionController.isInteracting {
      let transition = UIPercentDrivenInteractiveTransition()
      func toPercent(_ moved: CGFloat) -> CGFloat {
        let width = presentationController.frameOfPresentedViewInContainerView.width
        return moved / width
      }
      interactionController.update = { moved in
        transition.update(toPercent(moved))
      }
      interactionController.end = { moved in
        if toPercent(moved) > 0.5 {
          transition.finish()
        } else {
          transition.cancel()
        }
      }
      return transition
    }

    return nil
  }

  func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    let presentation = PresentationController(presentedViewController: presented, presenting: presenting)
    presentationController = presentation
    return presentation
  }
}

