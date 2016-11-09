//
//  ViewController.swift
//  MMGooglePlayNewsStand
//
//  Created by mukesh mandora on 25/08/15.
//  Copyright (c) 2015 madapps. All rights reserved.
//

import UIKit

class ViewController: UIViewController,MMPlayPageControllerDelegate {
let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
   
    @IBOutlet weak var showDemoBut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        initPlayStand()
        showDemoBut.tintColor=UIColor.whiteColor()
        showDemoBut.setImage(UIImage(named: "news")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate), forState: UIControlState.Normal)
        showDemoBut.backgroundColor=UIColor(hexString: "4caf50")
        showDemoBut.layer.cornerRadius=showDemoBut.frame.size.width/2
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initPlayStand(){
        self.presentViewController(appDelegate.walkthrough!, animated: true, completion: nil)
        
        let stb = UIStoryboard(name: "Main", bundle: nil)
        
        let page_one = stb.instantiateViewControllerWithIdentifier("stand_one") as! MMSampleTableViewController
        let page_two = stb.instantiateViewControllerWithIdentifier("stand_one") as! MMSampleTableViewController
        let page_three = stb.instantiateViewControllerWithIdentifier("stand_one") as! MMSampleTableViewController
        
        //header Color
        page_one.tag=1
        page_two.tag=2
        page_three.tag=3
        
        // Attach the pages to the master
        appDelegate.walkthrough?.delegate = self
        appDelegate.walkthrough?.addViewControllerWithTitleandColor(page_one, title: "Скидки", color:UIColor(hexString: "E18E59"))
       
        appDelegate.walkthrough?.addViewControllerWithTitleandColor(page_two, title: "Стрижки", color:UIColor(hexString: "E18E59"))
        
        appDelegate.walkthrough?.addViewControllerWithTitleandColor(page_three, title: "О Нас", color:UIColor(hexString: "E18E59"))
    }

    @IBAction func showDemoAction(sender: AnyObject) {
        
        initPlayStand()
    }
    
    
}

