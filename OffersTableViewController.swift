//
//  OffersTableViewController.swift
//  JSONParser
//
//  Created by Wyatt on 9/28/16.
//  Copyright © 2016 Wyatt. All rights reserved.
//

import UIKit

class OffersTableViewController: WMParentTableViewController {
    
    var offers : [Offers]?
    
     var tableElements : Dictionary<String, [Offers]?>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerGenericTableCell()
        if let lazyMapCollection = tableElements?.keys {
            
            keys = Array(lazyMapCollection)

            print(keys)
            
            
            keys.sort()
            
            
            print(keys)
            
        }
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        
        
        return keys.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       
        
        if let offerCount = returnRetailArrayForIndexPath(WithIndex: section)?.count {
        
            return offerCount
        
        }
        return 0
    }

    
    func returnofferObjectAtIndex (indexPath : IndexPath, offerArray : [Offers]?) -> Offers? {
        
        
        if  let oArray = offerArray  {
        
            
            return oArray[indexPath.row]
        
        }
        
        return nil
    }
    
    func returnRetailArrayForIndexPath (WithIndex : Int) -> [Offers]? {

        let sectionName = keys[WithIndex]
        
        if let tE = tableElements {
            
            
            if let arr = tE[sectionName] {
                
                return arr
                
            }
            
        }
        
        return nil
    }
    
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "offerNib", for: indexPath) as? OffersTableViewCell

        
        if let arr = returnRetailArrayForIndexPath(WithIndex: indexPath.section) {
        
           if let ob = returnofferObjectAtIndex(indexPath: indexPath, offerArray: arr) {
            
            
        cell?.offersLabel?.text = ob.offerName
    
            }
        
        
        }
        
        
        // Configure the cell...

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if let arr = returnRetailArrayForIndexPath(WithIndex: indexPath.section) {
        
            if let ob = returnofferObjectAtIndex(indexPath: indexPath, offerArray: arr) {
                
                
                let detail = OfferDetailTableViewController()
                
                detail.offerElements = [Offers]()
                
                
                detail.offerElements?.append(ob)
                
                detail.title = ob.offerName
                
                detail.imageUrl = ob.iconUrl
                
                
                self.navigationController?.pushViewController(detail, animated: true)
            }
        
        
        }
    }


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
