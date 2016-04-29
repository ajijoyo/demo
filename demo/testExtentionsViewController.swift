//
//  testExtentionsViewController.swift
//  demo
//
//  Created by Dealjava on 4/29/16.
//  Copyright © 2016 originesia. All rights reserved.
//

import UIKit
import Foundation

class testExtentionsViewController: UIViewController {

    var mainscrollview : UIScrollView!;
    var labelDate : UILabel!;
    var slider : UISlider!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainscrollview = UIScrollView(frame: self.view.bounds)
        mainscrollview.autoresizingMask = [.FlexibleWidth , .FlexibleHeight]
        
        mainscrollview.contentSize = CGSize(width: self.view.bounds.width, height: 700)
        self.view.addSubview(mainscrollview)
        
        labelDate = UILabel(frame: CGRect(x: 0, y: 16, width: self.view.bounds.width, height: 20))
        labelDate.textColor = UIColor.blackColor()
        labelDate.textAlignment = .Center
        
        mainscrollview.addSubview(labelDate)
        
        slider = UISlider(frame: CGRect(x: 0, y: labelDate.getHeight, width: self.view.bounds.width - 30, height: 30))
        slider.center.x = self.view.center.x
        slider.addTarget(self, action: #selector(self.sliderchange), forControlEvents: .ValueChanged)
        mainscrollview.addSubview(slider)
        
        //test label date
        let date = "4/28/2016 10:00";
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "MM/dd/yyyy HH:mm"
        let nsdate = dateFormat.dateFromString(date)
        labelDate.text = nsdate?.toStringCurrentTime
        
    }
    
    func sliderchange() {
        print(Int(slider.value * 59))
        let date = "4/29/2016 15:\(Int(slider.value * 59))";
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "MM/dd/yyyy HH:mm"
        let nsdate = dateFormat.dateFromString(date)
        labelDate.text = nsdate?.toStringCurrentTime
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
