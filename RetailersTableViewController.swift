//
//  RetailersTableViewController.swift
//  JSONParser
//
//  Created by Wyatt on 9/28/16.
//  Copyright © 2016 Wyatt. All rights reserved.
//

import UIKit

class RetailersTableViewController: WMParentTableViewController, UISearchResultsUpdating {

    var tableElements : Dictionary<String, [Retail]?>?
    var imageCache : NSCache<AnyObject, AnyObject>?
    
    
    var searchArrayToDisplay : [Retail]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let  WmJson = WMJSON()
        
      
        searchController.searchResultsUpdater = self
        
        searchController.hidesNavigationBarDuringPresentation = false
        
        
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.placeholder = self.title
        
        
        searchController.searchBar.sizeToFit()
        
        
        //self.tableView.tableHeaderView = searchController.searchBar
        
        self.navigationItem.titleView = searchController.searchBar
        
        
        
        imageCache = returnCache()
        
        registerTableViewCell(nib:  UINib(nibName: "RetailTableViewCell", bundle: nil), identifier: "Retail")
        
        let tup = WmJson.loadRetail()
        
        if let sArray = tup.0 {
            
            
            searchArray = sArray
        }
       
        if let elements = tup.1 {
            
            
            tableElements = elements
            if let lazyMapCollection = tableElements?.keys {

            keys = Array(lazyMapCollection)
                
                print(keys)
                keys.sort()
                
                print(keys)
                
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
       
        
        if searchController.isActive == true {
            
            return 1
            
            
        }
        
        
            return keys.count
            
      
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
    
      
        
        if searchController.isActive == true {
        
            if let sCount = self.searchArrayToDisplay?.count {
            return sCount
            
                
            }
        }
        
         let index = keys[section]
      
        if let tE = tableElements {
            
            
            if let arr =   tE[index] {
            
            
            return arr!.count
            }
            
        }
        
       
        
        
        return 0
    }

    // One central method to access the search array and normal list array inside of the dictionary data structure. Also appropiately handles when search is active

    func returnRetailArrayForIndexPath (WithIndex : IndexPath) -> [Retail]? {
        
  
        if self.searchController.isActive == true {
            
            
            
          return self.searchArrayToDisplay
            
        }
        
        let sectionName = keys[WithIndex.section]
        
        if let tE = tableElements {

            
            if let arr = tE[sectionName] {
            
        return arr
            
            }
            
        }
        
        return nil
    }
    
    func returnRetailObjectForIndexPath (Withindex : IndexPath) -> Retail? {
    
        // One centralized method that can access the retail object for the array.
        
        if let arr = returnRetailArrayForIndexPath(WithIndex: Withindex) {
            
            
             let ob = arr[Withindex.row]
                
                
             return ob
 
            
        }
        
        
        return nil
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Retail", for: indexPath) as? RetailTableViewCell

        if let ob = returnRetailObjectForIndexPath(Withindex: indexPath) {

            cell?.companyLabel.text = nil
            if let company = ob.retailName {
        cell?.companyLabel.text = company
                
            }
            
            /// Regaurding the requirement of memory performant design for images, I find NSCache to be the best for that.

            if let ic = imageCache, let id = ob.id, let imgUrl = ob.iconUrl {
                
                cell?.profileImage.image = nil 
                
                if let image = ic.object(forKey: id as AnyObject) as? UIImage{
                    
                    
                    cell?.profileImage.image = image
                    
                } else {
                    
                    getDataFromUrl(url: imgUrl, completion: { (Data, Resonse, Err) in
              
                        if let imgData = Data , Err == nil {
                        
                        
                        if let img = UIImage(data: imgData) {
                            
                            ic.setObject(img, forKey: id as AnyObject)
                            
                           
                            DispatchQueue.main.sync {
                                
                                if tableView.cellForRow(at: indexPath) != nil {
                                cell?.profileImage.image = img
                                
                                
                                }
                            }
          
                            
                        }
                        
                        }
                        
                        
                    })
                    
                    
                    
                    
                }
                

                
            }
            
            
        
        }
        
        
        
        
        
        return cell!
    }

    
    /// UISearchController delegate for when user types a new letter in search.
    func updateSearchResults(for searchController: UISearchController) {
        
        self.searchArrayToDisplay?.removeAll(keepingCapacity: false)
        
    
        self.searchArrayToDisplay = self.searchArray?.filter({ (store : Retail) -> Bool in
            if let sT = searchController.searchBar.text {
            
            if store.retailName == nil {
                
                return false
            }
        
            if store.retailName?.range(of: sT, options: .caseInsensitive, range: nil, locale: nil) != nil {
                
                
                return true
            }
          
            }
            
            return false
            
        })
        
        self.tableView.reloadData()
        
    }
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        //// Find all offers tied to the retail ID, then display a list of offers for that given retailer.
        autoreleasepool { () -> Void in
            
            
        if let ob = returnRetailObjectForIndexPath(Withindex: indexPath) {
        
        let wmJSON = WMJSON()
        
        
        
        if let data = wmJSON.loadFileFromBundle(WithfileName: "Offers.json") {

            
            let json = JSON(data: data)
            
            let offers = json["offers"]
            
  
           
           if let retailId = ob.id {
            var offerElements =  Dictionary<String, [Offers]?>()

            
            for i in  (0..<offers.count){

                let offerObject = Offers()
                
                
                if let retailers = offers[i]["retailers"].arrayObject {
                    
  
                    for rID in retailers {
                        
                        if rID is Int {
                            
                        /// Loop through all offers. Only pick the offer that is the one related in the list.
                            if Int( (rID as AnyObject) as! NSNumber ) == retailId {
            
                                
                                
                                if let id = offers[i]["id"].int {
                              
                                    offerObject.id = id
                                    
                                    
                                }
                                
                                
                                if let descrip = offers[i]["description"].rawString() {
                                    
                                    
                                    
                                    offerObject.offerDescription = descrip
                                    
                                    
                                }
                
                                if let terms = offers[i]["terms"].rawString() {
                       
                                    offerObject.terms = terms
                       
                                }
                                
                                
                                if let offerName = offers[i]["name"].rawString() {
                                    
                                    
                                    
                                 

                                    offerObject.offerName = offerName
                                    
                                    
                                    
                                    
                                }
                                
                                
                                
                                if let icon = offers[i]["large_url"].URL {
                                    
                                    offerObject.iconUrl = icon
                                    
                                }
                                
                               
                                var offersArray : [Offers]?
                                
                                if let firstChar = offerObject.offerName?.characters.first {
                                
                                
                                
                                    if let offerArr = offerElements[String(firstChar).uppercased()] {
                                
                                        
                                        offersArray = offerArr
                                        
                               
                                        
                                        
                                    } else {
                                        
                                        
                                        offersArray = [Offers]()
                                        
                                        
                                    }
                                
                                    
                                    
                                }
                                /// For usability purposes, we want to make sure a large list is easy to navigate
                                
                                if let firstChar = offerObject.offerName?.characters.first, var oArray = offersArray {
                     
                                oArray.append(offerObject)
                                
                                offerElements[String(firstChar).uppercased()] = wmJSON.sortOfferArray(retail:oArray)
                                        
                                    }
                                break
                                
                            } else {
                                
                                
                                continue
                                
                                
                            }
                            
                            
                            
                            
                            
                            
                        }
                        
                        
                        
                        
                    }
                    
                    
                }
            
                
                
            }
            
          let otv =  OffersTableViewController()
            
            if let company = ob.retailName {
                otv.title  = company + " Offers"
                
            }
           
            
            otv.tableElements = offerElements
            
            self.navigationController?.pushViewController(otv, animated: true)
            
            
            }
            }
            

        }
        
        }
        
    }
  
 
}
