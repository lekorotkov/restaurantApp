//
//  MMSampleTableViewController.swift
//  MMGooglePlayNewsStand
//
//  Created by mukesh mandora on 25/08/15.
//  Copyright (c) 2015 madapps. All rights reserved.
//

import UIKit

@objc protocol scrolldelegateForYAxis{
    
    @objc optional func scrollYAxis(offset:CGFloat , translation:CGPoint)              // If the skipRequest(sender:) action is connected to a button, this function is called when that button is pressed.
    
    @objc optional func getframeindexpathOfController()->CGRect
}

struct Section {
    var name: String!
    var items: [String]!
    var costs: [String]!
    var collapsed: Bool!
    
    init(name: String, items: [String], costs: [String], collapsed: Bool = true) {
        self.name = name
        self.costs = costs
        self.items = items
        self.collapsed = collapsed
    }
}

class MMSampleTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,MMPlayPageScroll ,UIScrollViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    let header: UIView!
    var sections = [Section]()
    let headerImage: UIImageView!
    var trans:CGPoint
    var imageArr:[UIImage]!
    var transitionManager : TransitionModel!
    var preventAnimation = Set<NSIndexPath>()
    
    //     weak var scrolldelegate:scrolldelegateForYAxis?
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var tag = 0 as Int
    override func viewDidLoad() {
        
        transitionManager = TransitionModel()
        super.viewDidLoad()
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        self.tableView.decelerationRate=UIScrollViewDecelerationRateFast
        header.frame=CGRectMake(0, 0, self.view.frame.width, 200);
        headerImage.frame=CGRectMake(header.center.x-30, header.center.y-30, 60, 60)
        headerImage.layer.cornerRadius=headerImage.frame.width/2
        
        
       
        headerImage.tintColor=UIColor.whiteColor()
        
        
        header.backgroundColor=UIColor.clearColor()
        
        //        header.addSubview(headerImage)
        initHeadr()
        self.view.addSubview(headerImage)
        self.tableView.tableHeaderView=header;
        // Do any additional setup after loading the view.
        self.setNeedsStatusBarAppearanceUpdate()
        
        
        switch self.tag {
        case 2: tableView.contentInset = UIEdgeInsetsMake(80, 0, 0, 0)
        default:
            break
        }
        
        switch self.tag {
        case 0:
            imageArr.append(UIImage(named: "ironman.jpg")!)
            imageArr.append(UIImage(named: "worldbg.jpg")!)
            imageArr.append(UIImage(named: "sportsbg.jpg")!)
            imageArr.append(UIImage(named: "applebg.png")!)
            imageArr.append(UIImage(named: "businessbg.jpg")!)
        case 1:
            imageArr.append(UIImage(named: "ironman.jpg")!)
        case 2:
            imageArr.append(UIImage(named: "ironman.jpg")!)
            imageArr.append(UIImage(named: "worldbg.jpg")!)
            imageArr.append(UIImage(named: "sportsbg.jpg")!)
            imageArr.append(UIImage(named: "applebg.png")!)
            imageArr.append(UIImage(named: "businessbg.jpg")!)
        default:
            imageArr.append(UIImage(named: "ironman.jpg")!)
        }
        
        sections = [
            Section(name: "Стрижкa", items: ["Мужская Стрижка", "Стрижка Машинкой"], costs: ["300000", "200000"]),
            Section(name: "Бритьё", items: ["Королевское бритьё", "Коррекция усов и бороды"], costs: ["250000", "200000"])
        ]
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if self.tag == 2 {
            return 20
        }
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        header=UIView()
        headerImage=UIImageView()
        headerImage.backgroundColor=UIColor(hexString: "109B96")
        headerImage.contentMode=UIViewContentMode.Center
        headerImage.clipsToBounds=true
        trans=CGPointMake(0, 0)
        imageArr = Array()
        super.init(coder: aDecoder)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func initHeadr(){
        //header Color
  
        switch ( tag){
        case 1:
             headerImage.backgroundColor=UIColor(hexString: "E18E59")
            headerImage.image=UIImage(named: "buy")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            break
            
        case 2:
             headerImage.backgroundColor=UIColor(hexString: "E18E59")
              headerImage.image=UIImage(named: "list_32x28")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            break
            
        case 3:
             headerImage.backgroundColor=UIColor(hexString: "E18E59")
              headerImage.image=UIImage(named: "book_alt2_32x24")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            break
            
        case 4:
             headerImage.backgroundColor=UIColor(hexString: "E18E59")
              headerImage.image=UIImage(named: "tech")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            break
            
        case 5:
             headerImage.backgroundColor=UIColor(hexString: "E18E59")
              headerImage.image=UIImage(named: "business")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            break
            
        default:
             headerImage.backgroundColor=UIColor(hexString: "4caf50")
              headerImage.image=UIImage(named: "world")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            break
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tag == 2 {
            return sections.count
        }
        return 1;
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if !preventAnimation.contains(indexPath) {
            preventAnimation.insert(indexPath)
            TipInCellAnimator.animate(cell)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tag == 2) {
            return sections[section].items.count
        }
        return imageArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tag == 1 {
            let cell:QRTableViewCell = tableView.dequeueReusableCellWithIdentifier("qrcell") as! QRTableViewCell
            
            return cell
        }
        
        if tag == 3 {
            let cell:InfoTableViewCell = tableView.dequeueReusableCellWithIdentifier("InfoCell") as! InfoTableViewCell
            
            return cell
        }
        
        if tag == 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier("DetailTableViewCell") as! DetailTableViewCell? ?? DetailTableViewCell(style: .Value1, reuseIdentifier: "DetailTableViewCell")
//            cell.backgroundColor = UIColor.whiteColor()
            cell.mainLabel.text = sections[indexPath.section].items[indexPath.row]
            cell.detailLabel.text = sections[indexPath.section].costs[indexPath.row] + " руб."
            return cell
        }
        
        let cell:NewsCellTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as! NewsCellTableViewCell
        
        cell.headerImage.image=imageArr[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tag == 1 {
            return 400
        } else if tag == 3 {
            return 400
        } else if tag == 2 {
            return sections[indexPath.section].collapsed! ? 0 : 44.0
        }
        return 44
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tag == 2 {
            let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier("header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
            
            header.titleLabel.text = sections[section].name
            header.arrowLabel.text = ">"
            header.setCollapsed(sections[section].collapsed)
            
            header.section = section
            header.delegate = self
            
            return header
        }
        return nil
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tag == 2 {
            return 44.0
        }
        return 0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tag == 0 {
            let detail = self.storyboard?.instantiateViewControllerWithIdentifier("detail") as! DetailViewController
            detail.modalPresentationStyle = UIModalPresentationStyle.Custom;
            detail.transitioningDelegate = transitionManager;
            appDelegate.walkthrough?.presentViewController(detail, animated: true, completion: nil)
        }
        
//        self.presentViewController(detail, animated: true, completion: nil)

    }
    
    //MARK:  - Scroll delegate
    
    func walkthroughDidScroll(position:CGFloat, offset:CGFloat) {
        //        NSLog("In controller%f %f", offset,position)
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        trans = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y);
        appDelegate.walkthrough!.scrollYAxis(scrollView.contentOffset.y, translation: trans)
    }
    
    
    
    
}

extension MMSampleTableViewController: CollapsibleTableViewHeaderDelegate {
    
    func toggleSection(header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !sections[section].collapsed
        
        // Toggle collapse
        sections[section].collapsed = collapsed
        header.setCollapsed(collapsed)
        
        // Adjust the height of the rows inside the section
        tableView.beginUpdates()
        for i in 0 ..< sections[section].items.count {
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: i, inSection: section)], withRowAnimation: .Automatic)
        }
        tableView.endUpdates()
    }
    
}

