//
//  FormatChooserTableViewController.swift
//  
//
//  Created by Rohit Gurnani on 14/04/16.
//
//

import UIKit
import Alamofire

class FormatChooserTableViewController: UITableViewController {
    
    let netoworkingHelper = NetworkingHelper.sharedInstance
    var formats = ["All Formats","Images","PDFs","MS-Office Documents"]
    var bgcolors = [
        UIColor(red: 37/255, green: 198/255, blue: 218/255, alpha: 1.0),
        UIColor(red: 76/255, green: 182/255, blue: 172/255, alpha: 1.0),
        UIColor(red: 129/255, green: 198/255, blue: 131/255, alpha: 1.0),
        UIColor(red: 174/255, green: 213/255, blue: 130/255, alpha: 1.0)
    ]
    var selectedRow = 0
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 83/255, green: 110/255, blue: 121/255, alpha: 1.0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = (self.view.frame.height - (self.navigationController?.navigationBar.frame.height)!-20)/4.0
        
        
        self.navigationController?.navigationBar.titleTextAttributes =
        ([NSForegroundColorAttributeName : UIColor(white: 1.0, alpha: 1.0), NSFontAttributeName : UIFont(name: "GillSans-Bold", size: 15.0)!])
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
         self.netoworkingHelper.testApi()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return formats.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FormatCell", forIndexPath: indexPath) as! FormatTableViewCell
        
        cell.formatString = formats[indexPath.row]
        cell.backgroundColor = bgcolors[indexPath.row]

        

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedRow = indexPath.row
        performSegueWithIdentifier("ShowResults", sender: indexPath)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowResults" {
            let vc = segue.destinationViewController as! SearchTableViewController
            vc.searchFormat = formats[(sender!.row)]
            vc.navColor = bgcolors[sender!.row]
            
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
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
    
    

}
