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
    
    var fiberToBeSent : FiberCDItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        testLabel.text = fiberToBeSent?.timeToString
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
