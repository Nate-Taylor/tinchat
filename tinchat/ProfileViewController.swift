//
//  ViewController.swift
//  tinchat
//
//  Created by nate_taylor on 24.09.17.
//  Copyright © 2017 nate_taylor. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Application moved from [Disappeared or viewloaded] to [Appearing] state: \(#function)\n")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Application moved from [Appearing] to [Appeared] state: \(#function)\n")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("Application moved to [subviews are going to be laid out] state while [appearing]: \(#function)\n")
    }
    
    override func viewDidLayoutSubviews() {
       // super.viewDidLayoutSubviews()
        print("Application moved to [view has layed out its subviews] state while [appearing]: \(#function)\n")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Application moved from [Appeared] to [Disappearing] state: \(#function)\n")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
        print("Application moved from [Disappearing] to [Disappered] state: \(#function)\n")
    }
}

