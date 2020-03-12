//
//  FiberDetailsAndEditableViewController.swift
//  Fiber Tracker
//
//  Created by David Eisenbaum on 2/28/20.
//  Copyright © 2020 David Eisenbaum. All rights reserved.
//

import UIKit

class FiberDetailsAndEditableViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var editDateTextField: UITextField!
    
    var fiberToBeSent : FiberCDItem?
    
    private var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // configure UIDatePicker
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .dateAndTime
        datePicker?.addTarget(self, action: #selector(FiberDetailsAndEditableViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(FiberDetailsAndEditableViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        // connect text field with datepicker
        editDateTextField.inputView = datePicker
        
        //let time = fiberToBeSent?.date
        let displayTime = fiberToBeSent?.timeToString
        //set label to current time and date
        testLabel.text = displayTime
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let df = DateFormatter()
        df.dateFormat = "MM-dd hh:mm a"
        df.amSymbol = "AM"
        df.pmSymbol = "PM"
        editDateTextField.text = df.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
