//
//  RootTableViewController.swift
//  StarterDex
//
//  Created by Rayyan Dirie on 12/9/24.
//

import Foundation
import UIKit
class RootTableViewController : UITableViewController {
    var starters = [StarterMon]()
    var typeImage = "Placeholder"
    let grassStarters = [
        "Bulbasaur", "Chikorita", "Treecko", "Turtwig", "Snivy", "Chespin", "Rowlet"
    ]

    let fireStarters = [
        "Charmander", "Cyndaquil", "Torchic", "Chimchar", "Tepig", "Fennekin", "Litten"
    ]

    let waterStarters = [
        "Squirtle", "Totodile", "Mudkip", "Piplup", "Oshawott", "Froakie", "Popplio"
    ]

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return starters.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let starter = starters[indexPath.row]
        
        let starterName = starter.StarterName
        let starterType = starter.StarterType
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath)
        cell.textLabel!.text = starterName
        cell.textLabel!.font = UIFont.boldSystemFont(ofSize: 18)
        
        cell.detailTextLabel!.text = starterType
        
        switch starter.StarterName {
        case let name where grassStarters.contains(name):
            typeImage = "grass"
        case let name where fireStarters.contains(name):
            typeImage = "fire"
        case let name where waterStarters.contains(name):
            typeImage = "water"
        default:
            typeImage = "fail"
        }
        
        var img = PullImage(imagePath: "https://raw.githubusercontent.com/rdirie/IT315Project2Files/refs/heads/main/\(typeImage).png")
        
        cell.imageView?.image = img
//        cell.imageView?.layer.cornerRadius = 50
//        cell.imageView?.layer.borderWidth = 2
//        cell.imageView?.layer.borderColor = UIColor.lightGray.cgColor
        return cell
    }
    
    //Function to make url -> bytes -> image type -> return image
    func PullImage(imagePath:String) -> UIImage {
        var downloadedImage = UIImage()
        
        let imageURL = URL(string:imagePath)
        
        let imgBytes = try? Data(contentsOf: imageURL!)
        
        print(imgBytes ?? "Error! Image doesn't exist at the URL \(imageURL!)")
        
        downloadedImage = UIImage(data:imgBytes!)!
        
        return downloadedImage
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender : Any?) {
        if segue.identifier == "showStarterDetails"{
            
            let indexPath = tableView.indexPathForSelectedRow
            let selectedStarter = starters[indexPath!.row]
            
            let destController = segue.destination as! ViewController
            
            destController.aStarter = selectedStarter
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        InitilizeData()
        GetAPIJSONData()
    }
    
    func GetAPIJSONData(){
        //Connect to JSON Source
        let endPointURL = URL(string:"https://raw.githubusercontent.com/rdirie/IT315Project2Files/refs/heads/main/Starter.JSON")
        
        //Pull JSON Data
        let dataBytes = try? Data(contentsOf: endPointURL!)
        
        //add debug print
        print("Received Data Bytes --:\(dataBytes!) ----- \n")
        
        if(dataBytes != nil){
            let dictionary:NSDictionary = (try? JSONSerialization.jsonObject(with: dataBytes!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            
            print("Received Dictionary --:\(dictionary) ----- \n")
            
            let StarterDictionary = dictionary["Starters"]! as! [[String:AnyObject]]
            
            for index in 0...StarterDictionary.count-1 {
                let st = StarterMon()
                let dictionaryST = StarterDictionary[index] //iterate JSON
                st.StarterName = dictionaryST["StarterName"] as! String
                st.StarterTitle = dictionaryST["StarterTitle"] as! String
                st.StarterType = dictionaryST["StarterType"] as! String
                st.StarterEvolutionLevel = dictionaryST["StarterEvolutionLevel"] as! Int
                st.StarterFact1 = dictionaryST["StarterFact1"] as! String
                st.StarterFact2 = dictionaryST["StarterFact2"] as! String
                st.StarterFact3 = dictionaryST["StarterFact3"] as! String
                st.StarterMove = dictionaryST["StarterMove"] as! String
                st.StarterSite = dictionaryST["StarterSite"] as! String
                st.StarterImage = dictionaryST["StarterImage"] as! String
                
                starters.append(st)
            }
        }
        else{
            print("Could not receive Remote Source")
        }
    }
}
