//
//  aaa.swift
//  CustomPresentation
//
//  Created by Nguyen, Cong on 2020/12/25.
//

import UIKit

class SwipeInteractionController {
  var isInteracting: Bool = false

  var begin: () -> () = {}
  var update: (CGFloat) -> () = { _ in }
  var end: (CGFloat) -> () = { _ in }

  init(view: UIView) {
    prepareGestureRecognizer(in: view)
  }

  private func prepareGestureRecognizer(in view: UIView) {
    let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
    view.addGestureRecognizer(gesture)
  }

  @objc func handleGesture(_ gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
    let translation = gestureRecognizer.translation(in: nil).x

    switch gestureRecognizer.state {
    case .began:
      isInteracting = true
      begin()
    case .changed:
      update(translation)
    case .cancelled, .ended:
      isInteracting = false
      end(translation)
    default:
      break
    }
  }
}
