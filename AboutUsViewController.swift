//
//  AboutUsViewController.swift
//  challengeLodjinha
//
//  Created by Renato Souza Bueno on 14/02/17.
//  Copyright © 2017 Renato S. Bueno. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

    @IBOutlet weak var developerLabel: UILabel!
    
    @IBOutlet weak var developmentDateLabel: UILabel!
    
    @IBOutlet weak var appNameCenterLabel: UILabel!     
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.setupTabBarItems(tabBar: self.tabBarController!)
        self.setupNavigationBar()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupTabBarItems(tabBar: UITabBarController) {
        tabBar.tabBar.tintColor = Color.hexStringToUIColor(hex: "#5a2986")
    }
    
    func setupNavigationBar() {
        self.navigationController!.navigationBar.barTintColor = Color.hexStringToUIColor(hex: "#5a2986")
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationItem.title = "Sobre"
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
