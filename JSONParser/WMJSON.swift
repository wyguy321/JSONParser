//
//  WMJSON.swift
//  JSONParser
//
//  Created by Wyatt on 9/28/16.
//  Copyright © 2016 Wyatt. All rights reserved.
//

import UIKit

class WMJSON: NSObject {
    
    
    
    
    
    
    // grabs the retailers from the dictionary data structure.

    func grabRetailArrayFromDictionary (WithKey : String?,instance : Dictionary<String, [Retail]?>?) ->  [Retail]? {
        
        if let k = WithKey, let i = instance {
            
            if let rArray = i[k] {
                
                
                return rArray
            }
         
        }
        
       return nil
      
    }

    
    
    // Sorts the retailers in alphabetic order.
    
    func sortRetailArray (retail : [Retail]) -> [Retail]? {

        return retail.sorted(by: { (Ob1, Ob2) -> Bool in
            
            if let r1Name = Ob1.retailName?.lowercased(), let r2Name = Ob2.retailName?.lowercased() {
                
                if r1Name < r2Name {
                    
                    return true
                }
                
                return false
                
            }

            return false
        })
        
        
    }
    /// Sorts the Offers in alphabetic order
    func sortOfferArray (retail : [Offers]) -> [Offers]? {
        
        return retail.sorted(by: { (Ob1, Ob2) -> Bool in
            
            if let r1Name = Ob1.offerName?.lowercased(), let r2Name = Ob2.offerName?.lowercased() {
                
                if r1Name < r2Name {
                    
                    return true
                }
                
                return false
                
            }
            
            return false
        })
        
        
    }
    
    
    
    /// Tuple method. Returns both the dictionary data structure for list as well as an array to search all retailers.
    func loadRetail () -> ([Retail]?, Dictionary<String, [Retail]?>?) {
  

   return  autoreleasepool { () -> ([Retail]?, Dictionary<String, [Retail]?>?) in
  
        var retailSearchArray = [Retail]()
    
        var elements = Dictionary<String, [Retail]?>()
        if let jData = loadFileFromBundle(WithfileName: "Retailers.json") {
            let json = JSON(data: jData)
   
            var retailers = json["retailers"]
            // print(json["retailers"])
            
            for i in  (0..<retailers.count){
               
                var retailArray : [Retail]?
                
                let retailObject = Retail()
                var firstLetter : String?
                if let rName = retailers[i]["name"].rawString(){
                    
                     retailObject.retailName = rName
                    if let firstChar = rName.characters.first {
                    
                    firstLetter = String(describing: firstChar).uppercased()
                    
                    }
                    if let rArray =  grabRetailArrayFromDictionary(WithKey: firstLetter, instance: elements) {
                        
                        
                        retailArray = rArray
                        
                        
                    } else {
                        
                        
                        retailArray = [Retail]()
                        
                    }
                    
             
                }

                if let name = retailers[i]["icon_url"].URL {
        
                    retailObject.iconUrl = name

                }
    
                if let id = retailers[i]["id"].int {
                    
                    retailObject.id = id
                    
                }
                
                
                retailArray?.append(retailObject)

                
                retailSearchArray.append(retailObject)
                
                if let fLetter = firstLetter, let rArray = retailArray {
                    
                    print(rArray)
                
                    print(sortRetailArray(retail: rArray))
                    
                    elements[fLetter] = sortRetailArray(retail: rArray)
  
                }
                
         
                print(retailers[i])
            }
            
            return (retailSearchArray,elements)
        }
        
   return (nil,nil)
    }
 
        
    }
    
    
    
    // Generic method to load JSON files from the bundle. Returns Data object.
    
    func loadFileFromBundle (WithfileName : String?) -> Data? {
        
        if let fp = WithfileName {
            
            if let path = Bundle.main.path(forResource: fp, ofType: nil){
                
                do {
       return  try Data(contentsOf: URL(fileURLWithPath: path))
                } catch {
                    return  nil
                }
                
            }

        }
        
        
        
        return nil
    }
    
    

}
