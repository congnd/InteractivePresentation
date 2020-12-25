//
//  ViewController.swift
//  CustomPresentation
//
//  Created by Nguyen, Cong on 2020/12/22.
//

import UIKit

class ViewController: UIViewController {
  lazy var transitioningCoordinator: TransitioningCoordinator = {
    return TransitioningCoordinator(view: view)
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .cyan

    let image = UIImageView()
    image.image = UIImage(named: "main")
    view.addSubview(image)

    image.translatesAutoresizingMaskIntoConstraints = false
    image.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    image.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    image.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    image.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

    transitioningCoordinator.interactionController.begin = { [unowned self] in
      self.present()
    }
  }

  @IBAction func onTapOpen(_ sender: Any) {
    present()
  }

  func present() {
    let vc = PresentedVC()
    vc.modalPresentationStyle = .custom
    vc.transitioningDelegate = transitioningCoordinator

    show(vc, sender: nil)
  }
}


class PresentedVC: UIViewController {
  override func viewDidLoad() {
    view.backgroundColor = .systemTeal
    let image = UIImageView()
    image.image = UIImage(named: "side")
    view.addSubview(image)

    image.translatesAutoresizingMaskIntoConstraints = false
    image.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    image.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    image.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    image.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }
  @IBAction func onTapClose(_ sender: Any) {
    dismiss(animated: true)
  }
}
