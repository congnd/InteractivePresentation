//
//  PresentationController.swift
//  CustomPresentation
//
//  Created by Nguyen, Cong on 2020/12/25.
//

import UIKit

class PresentationController: UIPresentationController {
  var dimmingView: UIView?

  var interactionController: SwipeInteractionController?

  override var frameOfPresentedViewInContainerView: CGRect {
    guard let containerView = containerView else { return .zero }
    let size = CGSize(width: 320, height: containerView.bounds.height)
    return CGRect(origin: .zero, size: size)
  }

  override func presentationTransitionWillBegin() {
    if dimmingView == nil {
      let dimmingView = UIView()
      dimmingView.frame = containerView!.bounds
      dimmingView.backgroundColor = .black
      dimmingView.alpha = 0
      self.dimmingView = dimmingView
      containerView!.addSubview(dimmingView)
    }

    let transitionCoordinator = presentingViewController.transitionCoordinator!
    transitionCoordinator.animate(alongsideTransition: { _ in
      self.dimmingView?.alpha = 0.5
    })
  }

  override func presentationTransitionDidEnd(_ completed: Bool) {
    if completed {
      let interactionController = SwipeInteractionController(view: containerView!)
      self.interactionController = interactionController
      interactionController.begin = { [unowned self] in
        self.presentingViewController.dismiss(animated: true)
      }
    }
  }

  override func dismissalTransitionWillBegin() {
    let transitionCoordinator = presentingViewController.transitionCoordinator!
    transitionCoordinator.animate(alongsideTransition: { _ in
      self.dimmingView?.alpha = 0
    })
  }
}

