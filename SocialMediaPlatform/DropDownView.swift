//
//  DropDownView.swift
//  SocialMediaPlatform
//
//  Created by Arron Mollet on 10/14/16.
//  Copyright © 2016 Arron Mollet. All rights reserved.
//

import UIKit

class DropDownView: UIView {

    @IBOutlet weak var dropDownArrow: UIImageView!
    
    //MARK: Properties
    var offset = CGPoint.zero
    var animator : UIDynamicAnimator!
    var container : UICollisionBehavior!
    var slidingAttachment : UIAttachmentBehavior! //Or say container
    var snap : UISnapBehavior!
    var dynamicItem : UIDynamicItemBehavior!
    var gravity : UIGravityBehavior!
    var panGestureReconizer : UIPanGestureRecognizer!
    //MARK: Functions
    func setup () {
        self.panGestureReconizer = UIPanGestureRecognizer(target: self, action: #selector(DropDownView.handlePan(_:)))
        panGestureReconizer.cancelsTouchesInView = false
        
        self.addGestureRecognizer(panGestureReconizer)
        
        self.animator = UIDynamicAnimator(referenceView: self.superview!)
        
        self.dynamicItem = UIDynamicItemBehavior(items:  [self])
        self.dynamicItem.allowsRotation = false
        self.dynamicItem.elasticity = 0
        snap = UISnapBehavior(item: self, snapTo: CGPoint(x: self.superview!.frame.size.width / 2, y: -200))
        animator.addBehavior(snap)
        self.gravity = UIGravityBehavior(items: [self])
        self.gravity.gravityDirection = CGVector(dx: 0, dy: -1)
        
        let heightOfSubview = self.superview?.frame.size.height
        //let widthOfSubView = self.superview?.frame.size.width
        self.slidingAttachment = UIAttachmentBehavior.slidingAttachment(with: self, attachmentAnchor: CGPoint(x: 0, y: -self.frame.size.height / 2 + 66), axisOfTranslation: CGVector(dx: 0, dy: 1))
        self.slidingAttachment.attachmentRange = UIFloatRange(minimum:  heightOfSubview!, maximum: heightOfSubview! / 2)
        //animator.addBehavior(self.slidingAttachment)
        
        self.container = UICollisionBehavior(items: [self])
        
        configureContainer()
        //container.translatesReferenceBoundsIntoBoundary = true
        
        animator.addBehavior(gravity)
        animator.addBehavior(dynamicItem)
        animator.addBehavior(container)
        //self.animator.setValue(true, forKey: "debugEnabled")
        
    }
    func configureContainer(){
        let boundaryWidth = UIScreen.main.bounds.size.width - 400
        container.addBoundary(withIdentifier: "upper" as NSCopying, from: CGPoint(x: 0, y: -self.frame.size.height + 145), to: CGPoint(x: boundaryWidth, y: -self.frame.size.height + 145))
        let boundaryHeight = UIScreen.main.bounds.size.height - 146
        container.addBoundary(withIdentifier: "lower" as NSCopying, from: CGPoint(x: 0, y: boundaryHeight ), to: CGPoint(x: boundaryWidth, y: boundaryHeight))
    }
    func handlePan(_ pan : UIPanGestureRecognizer) {
        let velocity = pan.velocity(in: self.superview).y
        var location = pan.location(in: self.superview!)
        var movement = self.frame
        movement.origin.x = 0
        movement.origin.y = movement.origin.y + (velocity * 0.05)
        //        snap = UISnapBehavior(item: self, snapToPoint: CGPointMake(CGRectGetMidX(movement), CGRectGetMidY(movement)))
        //        animator.addBehavior(snap)
        if pan.state == .ended{
            panGestureEnded()
        }else if pan.state == .began {
            let center = self.center
            offset.y = location.y - center.y
            snapToBottom()
        }else{
            animator.removeBehavior(snap)
            //snap = UISnapBehavior(item: self, snapToPoint: CGPointMake(CGRectGetMidX(movement), CGRectGetMidY(movement)))
            
            
            //let referenceBounds = self.superview!.bounds
            //let referenceHeight = referenceBounds.height
            
            // Get item bounds.
            //let itemBounds = self.bounds
            //let itemHalfHeight = itemBounds.height / 2.0
            
            // Apply the initial offset.
            location.x -= offset.x
            location.y -= offset.y
            
            // Bound the item position inside the reference view.
            location.x = UIScreen.main.bounds.size.width / 2
            //location.y = max(itemHalfHeight, location.y)
            //location.y = min(referenceHeight - itemHalfHeight, location.y)
            // Apply the resulting item center.
            snap = UISnapBehavior(item: self, snapTo: location)
            
            animator.addBehavior(snap)
        }
        
    }
    func panGestureEnded(){
        animator.removeBehavior(snap)
        
        let velocity = dynamicItem.linearVelocity(for: self)
        
        if fabsf(Float(velocity.y)) > 250 {
            if velocity.y < 0{
                snapToTop()
                rotateArrowDown()
            }else{
                snapToBottom()
                rotateArrowUp()
            }
        }else{
            if let superViewHeight = self.superview?.bounds.size.height{
                if self.frame.origin.y > superViewHeight / 2{
                    snapToBottom()
                }else{
                    snapToTop()
                }
            }
        }
    }
    func snapToBottom(){
        gravity.gravityDirection  = CGVector(dx: 0, dy: 2.5)
        
    }
    func snapToTop(){
        gravity.gravityDirection  = CGVector(dx: 0, dy: -2.5)
    }
    
    func rotateArrowUp() {
        dropDownArrow.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    func rotateArrowDown() {
        dropDownArrow.transform = CGAffineTransform(rotationAngle: 0)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.tintColor = UIColor.clear
    }
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
}



