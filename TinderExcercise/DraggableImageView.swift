//
//  DraggableImageView.swift
//  TinderExcercise
//
//  Created by Developer on 11/9/16.
//  Copyright © 2016 Developer. All rights reserved.
//

import UIKit

protocol DraggableImageViewDelegate: class {

    func userDidDrag(x:Float, y:Float)
    func userFinishedDrag()
    func userDidTap()
    
    func userStartedPinch()
    func userPinch(scale:CGFloat, velocity:CGFloat)
    func userFinishPinchWithMomentun()
    func userFinishPinchWithCancel()
    var view:UIView! {get}
}




class DraggableImageView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet var contentView: UIView!
    
    weak var delegate:DraggableImageViewDelegate?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initSubviews()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        
        // standard initialization logic
        let nib = UINib(nibName: "DraggableImageView", bundle: nil)
        
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        
            // custom initialization logic
        
        let panGensture = UIPanGestureRecognizer(target: self, action: #selector(userDidPan(sender:)))
        self.addGestureRecognizer(panGensture)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(userDidTap(sender:)))
        self.addGestureRecognizer(tapGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(userDidPinch(sender:)))
        self.addGestureRecognizer(pinchGesture)
    }
    
    func userDidPan(sender:UIPanGestureRecognizer) {
    
        let panGesture = sender
        let translation = sender.translation(in: delegate?.view)
    
        switch panGesture.state {
        
        case .began:
            break
        case .changed:
            self.delegate?.userDidDrag(x: Float(translation.x), y: Float(translation.y))
        case .ended:
            self.delegate?.userFinishedDrag()
        default:
            break
        }
    
    }
    
    func userDidTap(sender:UITapGestureRecognizer) {
            
        self.delegate?.userDidTap()
    }
    
    func userDidPinch(sender:UIPinchGestureRecognizer) {
        
        let pinchRecognizer = sender
        let scale = pinchRecognizer.scale
        let velocity = pinchRecognizer.velocity
        
        switch pinchRecognizer.state {
        case .began:
            self.delegate?.userStartedPinch()
        case .changed:
            self.delegate?.userPinch(scale: scale, velocity: velocity)
        case .ended:
            if velocity > 0 {
                self.delegate?.userFinishPinchWithMomentun()
            }
            else {
                self.delegate?.userFinishPinchWithCancel()
            }
            
        default:
            break
        }
    
    }
    

    
    var image: UIImage? {
        
        get {return imageView.image}
        
        set {
            self.imageView.image = newValue
        }
    }
    
    
    
}
