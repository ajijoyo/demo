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
    let Image = UIImageView(image: UIImage(named: "Wallpaper-686.jpg"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loading.autoresizingMask = [.FlexibleHeight , .FlexibleWidth]
        loading.progress = 0;
        
        let timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "loadingProgress", userInfo: nil, repeats: true)
        
        Image.frame = CGRectMake(0, 0, 200, 200);
        Image.contentMode = .ScaleAspectFit;
        Image.addSubview(loading)
        
        loading.center = Image.center;
        view.addSubview(Image)
        
        loading.circleLoadDidFinish({
            timer.invalidate()
            print("finish")
        })
    }
    
    override func viewWillLayoutSubviews() {
        Image.center = self.view.center;
    }
    
    func loadingProgress(){
        loading.progress += 0.1;
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
