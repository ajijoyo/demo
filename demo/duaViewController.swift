//
//  duaViewController.swift
//  demo
//
//  Created by Dealjava on 11/24/15.
//  Copyright © 2015 originesia. All rights reserved.
//

import UIKit

class duaViewController: UIViewController ,UIGestureRecognizerDelegate{

    private var panToBack : UIPanGestureRecognizer!
    private var rightToBack : UIPanGestureRecognizer!
    private var leftBezel : CGFloat = 20.0
    
    private var lastSnapShoot : UIView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        panToBack = UIPanGestureRecognizer(target: self, action: "handleBackGesture:")
        panToBack.delegate = self;
        view.addGestureRecognizer(panToBack)
        
        rightToBack = UIPanGestureRecognizer(target: self, action: "handleRightGesture:")
        rightToBack.delegate = self;
        view.addGestureRecognizer(rightToBack)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getsnapshoot(){
        let vclast = navigationController?.viewControllers as [UIViewController]?
        lastSnapShoot = vclast![(vclast?.count)! - 2].view.snapshotViewAfterScreenUpdates(true)
        lastSnapShoot?.frame = self.view.bounds
        self.view.addSubview(lastSnapShoot!)
    }
    
    func handleRightGesture(sender : UIPanGestureRecognizer){
        
        switch sender.state {
        case UIGestureRecognizerState.Began :
            print("began ")
            
            break;
        case UIGestureRecognizerState.Changed:
            print("changed ")
            getsnapshoot()
            lastSnapShoot?.frame = applytranslate(sender.translationInView(sender.view), toRect: lastSnapShoot!.frame)
            break;
        case UIGestureRecognizerState.Ended:
            print("ended ")
            break;
        default :
            break;
        }
    }
    
    func applytranslate(translate : CGPoint , var toRect : CGRect) -> CGRect {
        var  newOrigin: CGFloat = toRect.origin.x
        newOrigin += translate.x
        
        let minOrigin: CGFloat = self.view.bounds.width
        let maxOrigin: CGFloat = self.view.bounds.width - self.view.bounds.width
        var newFrame: CGRect = toRect
        
        if newOrigin > minOrigin {
            newOrigin = minOrigin
        } else if newOrigin < maxOrigin {
            newOrigin = maxOrigin
        }
        
        newFrame.origin.x = newOrigin
        return newFrame
    }
    
    func handleBackGesture(sender : UIPanGestureRecognizer){
        print(sender.state)
        
        switch sender.state {
        case UIGestureRecognizerState.Began :
            print("began ")
            print(sender.locationInView(sender.view))
            break;
        case UIGestureRecognizerState.Changed:
            print("changed ")
            print(sender.locationInView(sender.view))
            break;
        case UIGestureRecognizerState.Ended:
            print("ended ")
            print(sender.locationInView(sender.view))
            break;
        default :
            break;
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
        if gestureRecognizer == panToBack {
            print("left \(isLeftPointContainedWithinBezelRect(touch.locationInView(self.view)))")
            return isLeftPointContainedWithinBezelRect(touch.locationInView(self.view))
        }else if gestureRecognizer == rightToBack {
            print("right \(isRightPointContainedWithinBezelRect(touch.locationInView(self.view)))")
            return isRightPointContainedWithinBezelRect(touch.locationInView(self.view))
        }
        return true
    }
    
    private func isRightPointContainedWithinBezelRect(point: CGPoint) -> Bool{
        var leftBezelRect: CGRect = CGRectZero
        var tempRect: CGRect = CGRectZero
        let bezelWidth: CGFloat = self.view.frame.width - leftBezel
        
        CGRectDivide(view.bounds, &leftBezelRect, &tempRect, bezelWidth, CGRectEdge.MinXEdge)
        return CGRectContainsPoint(tempRect, point)
    }
    
    private func isLeftPointContainedWithinBezelRect(point: CGPoint) -> Bool{
        var leftBezelRect: CGRect = CGRectZero
        var tempRect: CGRect = CGRectZero
        let bezelWidth: CGFloat = leftBezel
        
        CGRectDivide(view.bounds, &leftBezelRect, &tempRect, bezelWidth, CGRectEdge.MinXEdge)
        return CGRectContainsPoint(leftBezelRect, point)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
