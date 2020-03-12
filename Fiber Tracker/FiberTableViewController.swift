//
//  FiberTableViewController.swift
//  Fiber Tracker
//
//  Created by David Eisenbaum on 1/8/20.
//  Copyright © 2020 David Eisenbaum. All rights reserved.
//


import UIKit

class FiberTableViewController: UITableViewController {
    
    var fiberTimesArray : [FiberCDItem] = []
    
    let df = DateFormatter()
    
    //feb 22
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    func loadData(){
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            if let fiberTimes = try? context.fetch(FiberCDItem.fetchRequest()) as? [FiberCDItem]{
                self.fiberTimesArray = fiberTimes
                tableView.reloadData()
            }
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fiberTimesArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = fiberTimesArray[indexPath.row].typeOfSupplement! + " taken at " + fiberTimesArray[indexPath.row].timeToString!
        
        return cell
    }
    
    // swipe to delete functionality
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let deletedItem = fiberTimesArray[indexPath.row]
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
                context.delete(deletedItem)
                loadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Clickable cells to point to another screen to edit date, see total fiber intake, and edit suppplement taken
        let fiberToBeSent = fiberTimesArray[indexPath.row]
        performSegue(withIdentifier: "clickedOnCellShow", sender: fiberToBeSent)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let FiberDetailVC = segue.destination as? FiberDetailsAndEditableViewController {
            if let fiberToBeSent = sender as? FiberCDItem {
                FiberDetailVC.fiberToBeSent = fiberToBeSent
            }
        }
    }
    
    @IBAction func addBarButton(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            let fiber = FiberCDItem(context: context)
            let dateNow = Date()
            
            // set date and time formatted as a string
            df.dateFormat = "MM-dd hh:mm a"
            df.amSymbol = "AM"
            df.pmSymbol = "PM"
            let dateString = df.string(from: dateNow)
            fiber.timeToString = dateString
            
            // set type of supplement
            fiber.typeOfSupplement = "Metamucil"
            //set date to supplement
            fiber.date = dateNow
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            loadData()
        }
    }
    
    
}
