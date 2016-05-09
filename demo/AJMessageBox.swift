//
//  AJMessageBox.swift
//  getstagram
//
//  Created by Dealjava on 5/9/16.
//  Copyright © 2016 prototype. All rights reserved.
//

import UIKit

typealias handlerMessage = () -> Void

class AJMessageBox: UIView {

    internal var duration : Double = 8.0;
    
    private var cancelBttn : UIButton!;
    private var confirmBttn : UIButton!;
    private var title : UILabel!;
    private var message : UITextView!;
    private var mainView : UIView!;
    private var timer : NSTimer!;
    private let shape = CAShapeLayer()
    private var action : handlerMessage? = nil;
    private var confirmAction : handlerMessage? = nil;
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(withTitle : String , message : String , cancelTitle : String , okTitle : String) {
        super.init(frame: UIScreen.mainScreen().bounds)
        self.backgroundColor = UIColor(white: 0.8, alpha: 0.5)
        mainView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width - 60, height: 200))
        mainView.autoresizingMask = [.FlexibleWidth,.FlexibleHeight,.FlexibleTopMargin,.FlexibleBottomMargin,.FlexibleLeftMargin,.FlexibleRightMargin]
        mainView.backgroundColor = UIColor.whiteColor()
        self.addSubview(mainView)
        
        title = UILabel(frame: CGRect(x: 3, y: 0, width: mainView.bounds.width - 6, height: 40))
        title.text = withTitle;
        title.numberOfLines = 1;
        title.font = UIFont.boldSystemFontOfSize(17)
        title.textAlignment = .Center
        let line = CALayer()
        line.frame = CGRect(x: 0, y: 39, width: mainView.bounds.width, height: 1)
        line.backgroundColor = UIColor.groupTableViewBackgroundColor().CGColor
        title.layer.addSublayer(line)
        
        mainView.addSubview(title)
        
        self.message = UITextView(frame: CGRect(x: 0, y: 40, width: mainView.bounds.width, height: 100))
        self.message.text = message;
        self.message.font = UIFont.systemFontOfSize(16)
        self.message.textAlignment = .Center;
        let size  = self.message.sizeThatFits(CGSizeMake(mainView.bounds.width, 250))

        self.message.frame.size.height = size.height + 16 > 250 ? 250 : size.height + 16
        mainView.addSubview(self.message)
        
        mainView.frame.size.height = 80 + self.message.bounds.height
        
        cancelBttn = UIButton(type: .Custom)
        cancelBttn.frame = CGRect(x: 0, y: mainView.bounds.height - 40, width: mainView.bounds.width / 2, height: 40)
        cancelBttn.autoresizingMask = [.FlexibleRightMargin,.FlexibleLeftMargin,.FlexibleWidth,.FlexibleTopMargin]
        cancelBttn.titleEdgeInsets = UIEdgeInsetsMake(-4, 0, 4, 0)
        cancelBttn.backgroundColor = UIColor.redColor()
        cancelBttn.setTitle(cancelTitle, forState: .Normal)
        cancelBttn.addTarget(self, action: #selector(self.cancelDidTap), forControlEvents: .TouchUpInside)
        
        mainView.addSubview(cancelBttn)
        
        confirmBttn = UIButton(type: .Custom)
        confirmBttn.frame = CGRect(x: mainView.bounds.width / 2, y: mainView.bounds.height - 40, width: mainView.bounds.width / 2, height: 40)
        confirmBttn.autoresizingMask = [.FlexibleRightMargin,.FlexibleLeftMargin,.FlexibleWidth,.FlexibleTopMargin]
        confirmBttn.titleEdgeInsets = cancelBttn.titleEdgeInsets
        confirmBttn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        confirmBttn.setTitle(okTitle, forState: .Normal)
        confirmBttn.addTarget(self, action: #selector(self.confirmDidTap), forControlEvents: .TouchUpInside)
        
        let ln = CALayer()
        ln.frame = CGRect(x: 0, y: 0, width: confirmBttn.bounds.width, height: 1)
        ln.backgroundColor = UIColor.groupTableViewBackgroundColor().CGColor
        confirmBttn.layer.addSublayer(ln)
        
        mainView.addSubview(confirmBttn)
        
        
        shape.frame = mainView.bounds
        shape.path = CGPathCreateRoundRect(mainView.bounds, cornerRadius: 15)
        shape.strokeColor = UIColor.greenColor().CGColor
        shape.lineWidth = 10;
        shape.fillColor = UIColor.clearColor().CGColor
        shape.strokeEnd = 1
        
        mainView.layer.cornerRadius = 15;
        mainView.layer.masksToBounds = true
        mainView.layer.addSublayer(shape)
    }
    
    func CGPathCreateRoundRect( r : CGRect , cornerRadius : CGFloat  ) -> CGPathRef
    {
        let p = CGPathCreateMutable() ;
        
        CGPathMoveToPoint( p, nil, r.origin.x + cornerRadius, r.origin.y ) ;
        
        let  maxX = CGRectGetMaxX( r )  ;
        let  maxY = CGRectGetMaxY( r ) ;
        
        CGPathAddArcToPoint( p, nil, maxX, r.origin.y, maxX, r.origin.y + cornerRadius, cornerRadius ) ;
        CGPathAddArcToPoint( p, nil, maxX, maxY, maxX - cornerRadius, maxY, cornerRadius ) ;
        
        CGPathAddArcToPoint( p, nil, r.origin.x, maxY, r.origin.x, maxY - cornerRadius, cornerRadius ) ;
        CGPathAddArcToPoint( p, nil, r.origin.x, r.origin.y, r.origin.x + cornerRadius, r.origin.y, cornerRadius ) ;
        
        return p ;
    }
    
    func show(didCancel : handlerMessage , didConfirm : handlerMessage){
        action = didCancel; confirmAction = didConfirm;
        mainView.center = self.center;
        UIApplication.sharedApplication().keyWindow?.addSubview(self)
        self.endEditing(true)
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(self.stepDuration), userInfo: nil, repeats: true)
    }
    
    func stepDuration(){
        
        var dur = shape.strokeStart + CGFloat(0.1 / duration)
        if dur <= 0 {
            dur = 0
        }else if dur >= 1 {
            dur = 1
        }
        if dur <= 0.5 {
            shape.strokeColor = UIColor.greenColor().CGColor
        }else if dur >= 0.5 && dur <= 0.8 {
            shape.strokeColor = UIColor.orangeColor().CGColor
        }else{
            shape.strokeColor = UIColor.redColor().CGColor
        }
        
        shape.strokeStart = dur;
        print(shape.strokeStart)
        if dur == 1 {
            cancelDidTap()
        }
    }
    
    func cancelDidTap(){
        hide()
        action?()
    }
    func confirmDidTap(){
        hide()
        confirmAction?()
    }
    
    func hide(){
        timer.invalidate()
        timer = nil;
        self.removeFromSuperview()
    }
    
}
