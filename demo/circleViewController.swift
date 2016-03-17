//
//  circleViewController.swift
//  demo
//
//  Created by Dealjava on 2/19/16.
//  Copyright © 2016 originesia. All rights reserved.
//

import UIKit


class circleViewController: UIViewController {
    
    let loading = circleLoadView(frame: CGRect(x: 100, y: 200, width: 200, height: 200))
    var Image : UIImageView? = nil;
    
    let rectLo = rectangleLoadView(frame: CGRect(x: 100, y: 200, width: 30, height: 30))
    let rectInfit = rectangleLoadView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    @IBOutlet weak var bttn :shapeBttn!
    
    var timer : NSTimer!;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rectLo.startAnimationonComplete({
            print("finish");
            self.timer.invalidate();
            self.rectInfit.stopAnimation();
        })
        rectLo.center = self.view.center;
        self.view.addSubview(rectLo);
        
        rectInfit.startAnimation();
        rectInfit.center = self.view.center;
        rectInfit.center.y += 50;
        self.view.addSubview(rectInfit);
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "loadingProgress", userInfo: nil, repeats: true);
        
        bttn.addTarget(self, action: "plusClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    @IBAction func plusClicked(sender:shapeBttn){
        sender.selected = !sender.selected;
    }
    
    override func viewWillLayoutSubviews() {
        Image?.center = self.view.center;
    }
    
    func loadingProgress(){
        rectLo.progress += 0.1;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
