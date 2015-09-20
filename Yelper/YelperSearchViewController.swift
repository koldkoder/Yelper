//
//  YelperSearchViewController.swift
//  Yelper
//
//  Created by Kushal Bhatt on 9/19/15.
//  Copyright © 2015 Kushal Bhatt. All rights reserved.
//

import UIKit
import AFNetworking

class YelperSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var searchSettings = YelpSearchSettings()
    var repos:[YelperRepo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        doSearch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    private func doSearch() {
        //MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        YelpClient().search(searchSettings, successCallback: { (repos:[YelperRepo]) -> Void in
            self.repos = repos
            self.tableView.reloadData()
            }, error: { (error) -> Void in
                print(error)
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let businessCell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! YelperBusinessTableViewCell
        let business = repos[indexPath.row]
        businessCell.business = business
        return businessCell
        
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
