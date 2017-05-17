//
//  ViewController.swift
//  TinderExcercise
//
//  Created by Developer on 11/9/16.
//  Copyright © 2016 Developer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DraggableImageViewDelegate, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

    
    @IBOutlet weak var profileImageViewContainer: DraggableImageView!
    @IBOutlet weak var profileImageViewContainerXConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonRow: UIImageView!
    
    var imageOrigialCenter:CGFloat!

    var isPresented = false
    
    var interactiveTransit:UIPercentDrivenInteractiveTransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.profileImageViewContainer.imageView.image = UIImage(named: "ryan")
        
        
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(sender:)))
//        
//        profileImageViewContainer.addGestureRecognizer(panGesture)
        
        profileImageViewContainer.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func userDidDrag(x: Float, y: Float) {
        self.profileImageViewContainerXConstraint.constant = CGFloat(x)

//        let rotation = Double(x) * (90.degreesToRadians/160)
//
//        var transform = CATransform3DIdentity
//        transform = CATransform3DRotate(transform, CGFloat(rotation), 0, 1, 0.5)
//        profileImageViewContainer.layer.transform = transform

        print("Before drag \(profileImageViewContainer.frame)")
        profileImageViewContainer.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        print("After drag \(profileImageViewContainer.frame)")


    }
    
    func userFinishedDrag() {

        UIView.animate(withDuration:0.2, animations: {
            
            self.profileImageViewContainerXConstraint.constant = 0
        })

    }
    
    
    func userDidTap() {
            
        self.performSegue(withIdentifier: "ModalToProfile", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let profileVC = segue.destination as! ProfileViewController
        
        profileVC.profileImage = self.profileImageViewContainer.imageView.image
        
        profileVC.modalPresentationStyle = .custom
        profileVC.transitioningDelegate = self
    }
    
    func userStartedPinch() {
        self.performSegue(withIdentifier: "ModalToProfile", sender: self)
    }
    
    func userPinch(scale:CGFloat, velocity:CGFloat) {
        self.interactiveTransit.update(scale/10)
    }
    
    func userFinishPinchWithMomentun() {
        self.interactiveTransit.finish()
    }
    
    func userFinishPinchWithCancel() {
        self.interactiveTransit.cancel()
    }

    
    //MARK: Persentation Animation
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresented = true
        return self
    }
    
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresented = false
        return self
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        let toVC = transitionContext.viewController(forKey: .to)!
        let fromVC = transitionContext.viewController(forKey: .from)!
        
        if isPresented {
            containerView.addSubview(toVC.view)
            toVC.view.alpha = 0
            UIView.animate(withDuration:0.5,
                           animations: {() -> Void in
                               toVC.view.alpha = 1.0
            },
                           completion: {(finished:Bool) -> Void in
            
                                transitionContext.completeTransition(true)
            })
            
        }
        else {
            UIView.animate(withDuration: 0.5,
                           animations: {
                               fromVC.view.alpha = 0
            },
                           completion: { (completed:Bool) in
                                transitionContext.completeTransition(true)
                                fromVC.view.removeFromSuperview()
            })
        }
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    
        self.interactiveTransit = UIPercentDrivenInteractiveTransition()
        
        self.interactiveTransit.completionSpeed = 0.99
        
        return self.interactiveTransit
    }

}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
    var radiansToDegrees: Double { return Double(self) * 180 / .pi }
}
extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}

