//
//  homeTableViewController.swift
//  demo
//
//  Created by Dealjava on 2/17/16.
//  Copyright © 2016 originesia. All rights reserved.
//

import UIKit

class homeTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let arrMenu = ["splitFlap","hidden object games","tiles games","circle load","Colorize","Test Arc"]
    
    @IBOutlet var tableview:tableRefreshPull!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var addarr = Array<UIView>();
        for var i = 0 ;i<5;i++ {
            let button = shapeBttn(frame: CGRect(x: 0, y: 0, width: 30, height: 30));
            addarr.append(button);
        }
        let coba1 = bttnMenu(frame: CGRect(x: 0, y: 0, width: 80, height: 30));
        coba1.title = "1";
        addarr.append(coba1)

        let bttn = expandMenu(aligment: .Center);
        bttn.listCustomBttn = addarr;
//        bttn.listBttn=["1","2","3","4","5"];
        bttn.bttnDidTap({(bttnMenu bttn)in
            print(bttn.tag);
        })
        
        let logIn = loginviewControl(frame: CGRectZero);
//        logIn.show({[unowned self](respon : AnyObject! , error : NSError!)in
//            if let code = respon.objectForKey("responseCode") as? NSString{
//                if code.integerValue == 00{
//                    logIn.hide();
//                }else{
//                    logIn.shake();
//                }
//            }
//        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrMenu.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        cell.textLabel?.text = arrMenu[indexPath.row];

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("viewController")
            self.navigationController?.pushViewController(vc!, animated: true)
        }else if indexPath.row == 1 {
            let vc = gameHiddenObjectViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 2 {
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("tilesgames");
            self.navigationController?.pushViewController(vc!, animated: true)
        }else if indexPath.row == 3 {
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("circleview");
            self.navigationController?.pushViewController(vc!, animated: true)
        }else if indexPath.row == 4{
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("colorize");
            self.navigationController?.pushViewController(vc!, animated: true);
        }else if indexPath.row == 5{
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("testarc");
            self.navigationController?.pushViewController(vc!, animated: true);
        }
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        tableview.tableRefreshPullDidScroll(scrollView)
    }

}
