//
//  ViewController.swift
//  TipsCalculator
//
//  Created by admin on 8/8/15.
//  Copyright (c) 2015 hoang. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController, UITableViewDelegate {
    
    var currency:Int!
    var tipsType:Int!
    
    @IBOutlet var tableConfig: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var path = NSBundle.mainBundle().pathForResource("TipsTypeAndCurrency", ofType: "plist")
        if var dict = NSMutableDictionary(contentsOfFile: path!) {
            currency = dict.objectForKey("Currency")?.integerValue
            tipsType = dict.objectForKey("TipsType")?.integerValue
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        if let visibleIndexPaths = tableConfig.indexPathsForVisibleRows() as? [NSIndexPath] {
            for eachPath in visibleIndexPaths {
                if(eachPath.section == 1){
                    if(self.tableView.cellForRowAtIndexPath(eachPath)?.tag == currency){
                        self.tableView.selectRowAtIndexPath(eachPath, animated: true, scrollPosition: UITableViewScrollPosition.Bottom)
                    }
                } else if(eachPath.section == 0){
                    if(self.tableView.cellForRowAtIndexPath(eachPath)?.tag == tipsType){
                        self.tableView.selectRowAtIndexPath(eachPath, animated: true, scrollPosition: UITableViewScrollPosition.Bottom)
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Write to plist
        var path = NSBundle.mainBundle().pathForResource("TipsTypeAndCurrency", ofType: "plist")
        if var dict = NSMutableDictionary(contentsOfFile: path!) {
            dict.setValue(currency, forKey: "Currency")
            dict.setValue(tipsType, forKey: "TipsType")
            dict.writeToFile(path!, atomically: false)
        }
    }
    
    override func tableView(_tableView: UITableView,
        didSelectRowAtIndexPath indexPath: NSIndexPath){
           var selectedRow = indexPath
            if let visibleIndexPaths = _tableView.indexPathsForVisibleRows() as? [NSIndexPath] {
                for eachPath in visibleIndexPaths {
                    if(selectedRow.section == eachPath.section){
                        _tableView.deselectRowAtIndexPath(eachPath, animated: true)
                    }
                }
            }
            _tableView.selectRowAtIndexPath(selectedRow, animated: true, scrollPosition: UITableViewScrollPosition.Bottom)
            // store
            if(selectedRow.section == 0){
                tipsType = _tableView.cellForRowAtIndexPath(selectedRow)?.tag
            } else {
                currency = _tableView.cellForRowAtIndexPath(selectedRow)?.tag
            }
    }
    
}
