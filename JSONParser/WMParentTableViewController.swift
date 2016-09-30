//
//  WMParentTableViewController.swift
//  JSONParser
//
//  Created by Wyatt on 9/28/16.
//  Copyright © 2016 Wyatt. All rights reserved.
//

import UIKit


/// Genric parent class to be inherited from childern that may inherit.

class WMParentTableViewController: UITableViewController {

       var keys = [String]()
    
        var searchArray : [Retail]?
    
    
    var tableViewRowHieght : CGFloat?
    
  let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    
    func registerGenericTableCell () {
        
        
        
        registerTableViewCell(nib:   UINib(nibName: "OffersTableViewCell", bundle: nil), identifier: "offerNib")
        

        
        
    }
    
    
    func prepareAttributedString (s : String , f : UIFont, color : UIColor) -> NSAttributedString {
     
        var attr:NSDictionary?
     
          
    
        attr = [
            NSFontAttributeName : f
            ,   NSForegroundColorAttributeName : color,NSBackgroundColorAttributeName : UIColor.clear
        ]

        let attrString = NSAttributedString (string: s, attributes: attr as? [String : AnyObject])
        
        return attrString
        
    }
    
    
    
    func returnCache () -> NSCache<AnyObject, AnyObject>? {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        return appDelegate?.dataCache
        
        
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        if keys.count > 3 {
            
            return keys
            
        }
        
        return nil
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if searchController.isActive {
            
            
            return "Results:"
            
            
        }
        
        
        if keys.count > 0 {
        return keys[section]
            
        }
        
        
        return ""
    }
    
    
    func registerTableViewCell(nib : UINib?, identifier : String?) {
        
        if let n = nib, let id = identifier {
        
            self.tableView.register(n, forCellReuseIdentifier: id)
  
        }
        
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
   
     
    
        return UITableViewAutomaticDimension
    }

    
 func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
    
    URLSession.shared.dataTask(with: url) {
        (data, response, error) in
       
        print(url)
        print(data)
        
        print(error)
        
        completion(data, response, error)
        }.resume()
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
