//
//  Extensions.swift
//  MusicApp
//
//  Created by Akbarshah Jumanazarov on 3/23/23.
//

import UIKit
import Hero

extension UIView {
    public var width: CGFloat {
        return self.frame.size.width
    }
    
    public var height: CGFloat {
        return self.frame.size.height
    }
    
    public var top: CGFloat {
        return self.frame.origin.y
    }
    
    public var bottom: CGFloat {
        return self.frame.size.height + self.frame.origin.y
    }
    
    public var left: CGFloat {
        return self.frame.origin.x
    }
    
    public var right: CGFloat {
        return self.frame.size.width + self.frame.origin.x
    }
}

extension UIColor {
    static var mainBgColor = UIColor(red: 82/255, green: 171/255, blue: 90/255, alpha: 1)
}

//Time Formatting
extension UIViewController {
    func timeFormatter(interval: Double) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        let formattedString = formatter.string(from: TimeInterval(interval))!
        return "\(formattedString)"
    }
}

//Hero
extension UIViewController {
    ///Call this in ViewWillDisappear()
    func disableHero() {
        view?.hero.isEnabled = false
    }
    
    ///Call this in ViewWillAppear()
    func enableHero() {
        view?.hero.isEnabled = true
    }
    
    func showHero(_ vc: UIViewController, navAnimationType: HeroDefaultAnimationType = .autoReverse(presenting: .slide(direction: .leading))) {
        vc.hero.isEnabled = true
        view?.hero.isEnabled = true
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
}

//blur
extension UIViewController {
    func blur(_ view: UIView, style: UIBlurEffect.Style = .prominent) {
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
          blurView.topAnchor.constraint(equalTo: view.topAnchor),
          blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
          blurView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
}





//extension UIViewController {
//    ///Call this in ViewWillDisappear()
//    func disableHero() {
//        navigationController?.hero.isEnabled = false
//    }
//
//    ///Call this in ViewWillAppear()
//    func enableHero() {
//        navigationController?.hero.isEnabled = true
//    }
//
//    func showHero(_ vc: UIViewController, navAnimationType: HeroDefaultAnimationType = .autoReverse(presenting: .slide(direction: .leading))) {
//        vc.hero.isEnabled = true
//        navigationController?.hero.isEnabled = true
//        navigationController?.hero.navigationAnimationType = navAnimationType
//        navigationController?.pushViewController(vc, animated: true)
//    }
//}
//
//extension UINavigationController {
//    ///Hero
//    func show(_ vc: UIViewController, navAnimationType: HeroDefaultAnimationType = .autoReverse(presenting: .slide(direction: .leading))) {
//        vc.hero.isEnabled = true
//        hero.isEnabled = true
//        hero.navigationAnimationType = navAnimationType
//        pushViewController(vc, animated: true)
//    }
//}

