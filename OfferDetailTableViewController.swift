 //
//  OfferDetailTableViewController.swift
//  JSONParser
//
//  Created by Wyatt on 9/29/16.
//  Copyright © 2016 Wyatt. All rights reserved.
//

import UIKit

class OfferDetailTableViewController: WMParentTableViewController {
    
    var imageUrl : URL?
    
    
    
    var offerElements : [Offers]?
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerGenericTableCell()
        self.tableView.addParallax(with: nil, andHeight: 300, andUrl: imageUrl)
        
        
        self.tableView.separatorStyle = .none
        
        
        
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let count = offerElements?.count {
            
            
            return count
            
            
        }
        
        
        return 1
    }

  
    func returnRetailObjectForIndexPath (Withindex : IndexPath) -> Offers? {
        
     
        
        
        if let ob = offerElements?[Withindex.row] {
            
       
            return ob
            
            
        }
        
 
        return nil
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "offerNib", for: indexPath) as? OffersTableViewCell
        
        if let ob = returnRetailObjectForIndexPath(Withindex: indexPath) {
        
            
            
           let attrText = NSMutableAttributedString()

            if let description = ob.offerDescription {
                
                attrText.append(prepareAttributedString(s: "Description: \n \n", f: UIFont.boldSystemFont(ofSize: 18), color: UIColor.black))
                
                attrText.append(prepareAttributedString(s: description + "\n \n", f: UIFont.systemFont(ofSize: 18), color: UIColor.black))
   
            }
            
            
            
            if let terms = ob.terms {
            
   
            attrText.append(prepareAttributedString(s: "Terms: \n \n", f: UIFont.boldSystemFont(ofSize: 18), color: UIColor.black))
                
            attrText.append(prepareAttributedString(s: terms, f: UIFont.systemFont(ofSize: 10), color: UIColor.lightGray))

                
                
            }
        cell?.offersLabel.attributedText = attrText

            cell?.selectionStyle = .none
            
        }
        // Configure the cell...

        return cell!
    }
 


    
}
