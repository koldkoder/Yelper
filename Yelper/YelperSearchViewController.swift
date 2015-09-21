//
//  YelperSearchViewController.swift
//  Yelper
//
//  Created by Kushal Bhatt on 9/19/15.
//  Copyright © 2015 Kushal Bhatt. All rights reserved.
//

import UIKit
import AFNetworking

class YelperSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, YelperFilterViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    var searchSettings = YelpSearchSettings()
    var repos:[YelperRepo] = []
    var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barTintColor = UIColor.redColor()
        //navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 230, height: 30))
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        let useButton = UIButton(type: UIButtonType.Custom)
        useButton.frame = CGRectMake(0, 0, 60, 25);
        useButton.layer.masksToBounds = false;
        useButton.layer.cornerRadius = 5;
        useButton.layer.shadowOffset = CGSizeZero
        useButton.layer.shadowRadius = 1.0;
        useButton.layer.shadowOpacity = 1.0;
        useButton.layer.shadowColor = UIColor.whiteColor().CGColor
        useButton.backgroundColor = UIColor.redColor()
        useButton.setTitle("Filter", forState: UIControlState.Normal)
        useButton.titleLabel?.font = UIFont(name: "Helvetica", size:12)
        useButton.addTarget(self, action: "filter", forControlEvents: .TouchUpInside)
        let filterButton = UIBarButtonItem(customView: useButton)
        
        filterButton.setTitleTextAttributes(
            [NSForegroundColorAttributeName: UIColor.whiteColor()],
            forState: UIControlState.Normal
        )
        
        navigationItem.leftBarButtonItem = filterButton
        
        doSearch(nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    private func doSearch(searchTerm: String?) {
        //MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        if let searchTerm = searchTerm {
            searchSettings.searchString = searchTerm
        }
        
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
    
    func filter() {
        performSegueWithIdentifier("filterSegue", sender: nil)
        //doSearch(searchBar.text)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let navigationController = segue.destinationViewController as! UINavigationController
        let yelperFitlerViewController = navigationController.topViewController as! YelperFilterViewController
        yelperFitlerViewController.delegate = self
    }
    
    func filterViewController(filterViewController: YelperFilterViewController, didUpdateFilters filters: [String : AnyObject]) {
     
        let categories = filters["categories"] as? [String]
        let category_filter =  categories?.joinWithSeparator(",")
        searchSettings.categories = category_filter
        doSearch(nil)
        tableView.reloadData()
    }


}
