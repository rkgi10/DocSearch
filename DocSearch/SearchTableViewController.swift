//
//  SearchTableViewController.swift
//  DocSearch
//
//  Created by Rohit Gurnani on 15/04/16.
//  Copyright © 2016 Rohit Gurnani. All rights reserved.
//

import UIKit
import QuickLook

class SearchTableViewController: UITableViewController , UITextFieldDelegate , QLPreviewControllerDataSource{
    
    
    let quickLookController = QLPreviewController()
    var searchTextField : UITextField!
    var searchFormat : String!
    var navColor : UIColor!
    let networkingHelper = NetworkingHelper.sharedInstance
    let dataModel = DataModel.sharedInstance
    
    var formatsAllowed = [
        "All Formats" : ["png","jpg","jpeg","pdf","txt","rtf","doc","docx","ppt","pptx","xls","xlsx","xlsm","xlsb"],
        "Images":["png","jpg","jpeg"],
        "PDFs" : ["pdf","txt","rtf"],
        "MS-Office Documents" : ["doc","docx","ppt","pptx","xls","xlsx","xlsm","xlsb"]]
    var tempResults : [Document] = []
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barTintColor = navColor
        self.tableView.separatorColor = networkingHelper.darkerColorForColor(navColor)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting up textfield search
        setupTextFields()
        
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //self.navigationController?.navigationBar.backgroundColor = navColor
        self.view.backgroundColor = networkingHelper.darkerColorForColor(navColor)
        //setting up custom back button for navbar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "filter2"), style: .Plain, target: self, action: "filterButtonPressed")
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "searchResultsLoaded", name: "SearchResultsLoaded", object: nil)
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //dismiss keyboard
        
       
        quickLookController.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tempResults.count
    }
    
   

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ResultCell", forIndexPath: indexPath) as! ResultTableViewCell
        
        cell.document = tempResults[indexPath.row]

        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("click registered")
        
        if QLPreviewController.canPreviewItem(NSURL(
            scheme: "http", host: "127.0.0.1:8080", path: tempResults[indexPath.row].url
            )!) {
            quickLookController.currentPreviewItemIndex = indexPath.row
            navigationController?.pushViewController(quickLookController, animated: true)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Setting up text fields
    func setupTextFields()
    {
        let frame = CGRect(x: 0, y: 0, width: (self.navigationController?.navigationBar.frame.width)!-150, height: 40)
        searchTextField = UITextField(frame: frame )
        searchTextField.textColor = UIColor.whiteColor()
        searchTextField.font = UIFont(name: "AvenirNext-Medium", size: 18.0)
        searchTextField.returnKeyType = .Search
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Type To Search", attributes: [NSForegroundColorAttributeName : UIColor(white: 1.0, alpha: 0.60),NSFontAttributeName : UIFont(name: "AvenirNext-Regular", size: 18.0)!])
        self.navigationItem.titleView = searchTextField
        searchTextField.delegate = self
        searchTextField.enablesReturnKeyAutomatically = true
        searchTextField.becomeFirstResponder()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
//        print("searching for query \(searchTextField.text!)")
//        networkingHelper.searchDocSearch(searchTextField.text!)
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        networkingHelper.searchDocSearch(searchTextField.text!)
        
        return true
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    func filterButtonPressed()
    {
        print("filter pressed")
    }
    
    func searchResultsLoaded(){
        print("reloading table view")
        tempResults = []
        for doc in dataModel.searchResultFiles {
            if ((formatsAllowed[searchFormat]?.contains(doc.format)) == true) {
                tempResults.append(doc)
            }
        }
        tableView.reloadData()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if searchTextField.isFirstResponder() {
            searchTextField.resignFirstResponder()
        }
    }
    
    
    //MARK: Setting up quicklook
    func numberOfPreviewItemsInPreviewController(controller: QLPreviewController) -> Int {
        return tempResults.count
    }
    
    func previewController(controller: QLPreviewController, previewItemAtIndex index: Int) -> QLPreviewItem {
        
        let fileUrl = NSURL(
            scheme: "http", host: "127.0.0.1:8080", path: tempResults[index].url
        )
        print("http://127.0.0.1:8080" + tempResults[index].url)
        print(fileUrl)
        return fileUrl!
    }
    
    
    

}
