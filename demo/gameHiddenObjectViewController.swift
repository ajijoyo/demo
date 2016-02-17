//
//  gameHiddenObjectViewController.swift
//  layerMask
//
//  Created by Dealjava on 2/17/16.
//  Copyright © 2016 oirignesia. All rights reserved.
//

import UIKit

class gameHiddenObjectViewController: UIViewController {
    
    let defaultMask : CGFloat  = 75;
    
    var startDate : NSDate!
    
    private var bgImg : UIImageView!
    let mask = CALayer();
    
    let maxImg = 6;
    
    var score : Int = 0;
    var scoreLabel : UILabel!
    var timerLabel : UILabel!
    private var bttn1 : UIButton!
    var locatedObject : NSMutableArray!
    
    var timer : NSTimer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locatedObject = NSMutableArray()
        bgImg = UIImageView(image: UIImage(named: "image.jpg"));
        bgImg.frame = CGRect(x: 0, y: 64, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height - 64);
        bgImg.contentMode = .ScaleAspectFill;
        
        let pan = UIPanGestureRecognizer(target: self, action: "panGesture:");
        view.addGestureRecognizer(pan);
        view.backgroundColor = UIColor(patternImage: UIImage(named: "Wallpaper-686.jpg")!)
        view.addSubview(bgImg);
        
        scoreLabel = UILabel(frame: CGRect(x: 10, y: 64, width: 150, height: 20))
        scoreLabel.font = UIFont.boldSystemFontOfSize(17);
        scoreLabel.textColor = UIColor.whiteColor();
        self.view.addSubview(scoreLabel);
        
        timerLabel = UILabel(frame: CGRect(x: 10, y: 84, width: 150, height: 20))
        timerLabel.font = UIFont.systemFontOfSize(15);
        timerLabel.textColor = UIColor.whiteColor();
        self.view.addSubview(timerLabel);
        
        reset();
        
        masking(bgImg);
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func timerListener(){
        
        let currentDate = NSDate()
        
        let formatter = NSDateFormatter();
        formatter.dateFormat = "mm:ss.SSS"
        formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0);
        
        let interval = currentDate.timeIntervalSinceDate(startDate)
        timerLabel.text = formatter.stringFromDate(NSDate(timeIntervalSince1970: interval));
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func panGesture(pan : UIPanGestureRecognizer){
        let point = pan.locationInView(bgImg)
        mask.frame = CGRectMake(point.x - (defaultMask / 2), point.y - (defaultMask / 2), defaultMask, defaultMask);
        
        pan.setTranslation(CGPoint(x: 0, y: 0), inView: self.view)
    }
    
    func bttnPlanet(sender : UIButton){
        print("\(sender.frame) - \(mask.frame)")
        if checkRadius(sender){
            score -= 1;
            sender.removeFromSuperview();
            scoreLabel.text = "\(score) remaining";
            print("remove bttn : \(sender.tag)")
            if score == 0 {
                timer.invalidate()
                finish()
            }
        }
    }
    
    func checkRadius(sender : UIButton) -> Bool{
        let offsetXA = mask.frame.origin.x
        let offsetXB = mask.frame.origin.x + mask.frame.width
        
        let offsetYA = mask.frame.origin.y
        let offsetYB = mask.frame.origin.y + mask.frame.height
        
        let checkXA = sender.frame.origin.x
        let checkXB = sender.frame.origin.x + sender.frame.width
        
        let checkYA = sender.frame.origin.y
        let checkYB = sender.frame.origin.y + sender.frame.height
        
        if offsetXA < checkXA && offsetXB > checkXB && offsetYA < checkYA &&  offsetYB > checkYB {
            return true;
        }
        
        return false;
    }
    
    func finish(){
        let alert = UIAlertController(title: "success", message: "celamadh", preferredStyle: .Alert)
        let alertbttn = UIAlertAction(title: "OK", style: .Default, handler: {(action :UIAlertAction) in
            self.reset()
        })
        alert.addAction(alertbttn)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func reset(){
        score = maxImg;
        scoreLabel.text = "\(score) remaining";
        
        startDate = NSDate()
        locatedObject.removeAllObjects()
        var i = 0;
        repeat{
            
            let rect = CGRectMake(randomisWidth(true), randomisWidth(false), 40, 40)
            
            if checkAlreadyAdd(rect){
                let bttn = UIButton()
                bttn.frame = rect
                bttn.setImage(UIImage(named: "roundedLogo"), forState: .Normal);
                bttn.addTarget(self, action: "bttnPlanet:", forControlEvents: .TouchUpInside)
                bttn.tag = i;
                bgImg.userInteractionEnabled = true;
                locatedObject.addObject(contentXYBA(rect: bttn.frame))
                bgImg.addSubview(bttn)
                i++;
            }
        }while i < maxImg
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "timerListener", userInfo: nil, repeats: true)
    }
    
    func masking(img : UIImageView){
        
        let maskImage = UIImage(named: "circle.png");
        mask.contents = maskImage?.CGImage;
        mask.frame = CGRectMake(150, 150,defaultMask, defaultMask);
        
        img.layer.mask = mask;
        img.layer.masksToBounds = true;
    }
    
    func randomisWidth(isW : Bool) -> CGFloat {
        var hasil :CGFloat!
        if isW {
            hasil = CGFloat(arc4random_uniform(UInt32(UIScreen.mainScreen().bounds.width) - UInt32(defaultMask)) + UInt32(defaultMask / 3))
        }else{
            hasil = CGFloat(arc4random_uniform(UInt32(UIScreen.mainScreen().bounds.width) - UInt32(defaultMask)) + UInt32(defaultMask / 3))
        }
        
        return hasil;
        
    }

    
    func checkAlreadyAdd(rect : CGRect) -> Bool{
        let check  = contentXYBA(rect: rect)
        print(locatedObject)
        for var anyRect in locatedObject {
            print("\nanyRect.XA  \(anyRect.XA) < check.XA \(check.XA)")
            print("anyRect.XB  \(anyRect.XB) > check.XB \(check.XB)")
            print("anyRect.YA  \(anyRect.YA) < check.YA \(check.YA)")
            print("anyRect.YB  \(anyRect.YB) > check.YB \(check.YB)\n")
            if anyRect.XA - 80 < check.XA &&
                anyRect.XB + 80 > check.XB &&
                anyRect.YA - 80 < check.YA &&
                anyRect.YB + 80 > check.YB {
                print("false")
                return false;
            }
        }
        print("true")
        return true;
    }
}

class contentXYBA :NSObject {
    var XA:CGFloat = 0;
    var XB:CGFloat = 0;
    var YA:CGFloat = 0;
    var YB:CGFloat = 0;
    init(rect : CGRect){
        XA = rect.origin.x ;
        XB = rect.origin.x + rect.width
        
        YA = rect.origin.y
        YB = rect.origin.y + rect.height
    }
}

