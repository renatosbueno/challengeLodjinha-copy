//
//  HomeTableViewController.swift
//  challengeLodjinha
//
//  Created by iOS Developer on 2/17/17.
//  Copyright © 2017 Renato S. Bueno. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController, HomeViewModelDelegate {

    lazy var viewModel: HomeViewModel = HomeViewModel(delegate: self)
    
    var activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray) {
        didSet {
            if viewModel.isLoading {
                self.hideActivityIndicator()
            } else {
                self.hideActivityIndicator()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupTabBarItems(tabBar: self.tabBarController!)
        self.getProducts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - HomeDelegate
    func feedbackRequestProducts(errorMessage: String?) {
        if errorMessage == nil {
            self.tableView.reloadData()
        } else {
            //TODO: Show error
        }
    }
    
    // MARK: - Get products
    func getProducts() {
        self.viewModel.getProducts()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numbersOfSections()
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionType = SectionType(rawValue: section) ?? .None
        return sectionType.sectionTypeHeader(sectionType: sectionType)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbersOfRows(in: SectionType(rawValue: section) ?? .None)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = SectionType(rawValue: indexPath.section) ?? .None
        switch sectionType {
        case .Banner :
            if let cell = tableView.dequeueReusableCell(withIdentifier: "BannerTableViewCell", for: indexPath) as? BannerTableViewCell {
                return cell
            }
            break
        case .List :
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell {
                return cell
            }
            break
        case .Category:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as? CategoryTableViewCell {
                
                return cell
            }
            break
        case .None:
         return UITableViewCell()
        }
        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewModel.willDisplayCell(cell: cell, indexPath: indexPath, sectionType: SectionType(rawValue: indexPath.section) ?? SectionType.None)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.shouldReturnHeightForRowAt(indexPath: indexPath)
    }
    
    func showActivityIndicator() {
        activityView.center = self.view.center
        activityView.startAnimating()
        self.tableView.addSubview(activityView)
    }
    
    func hideActivityIndicator() {
        self.activityView.stopAnimating()
    }
    
    func setupNavigationBar() {
        self.navigationController!.navigationBar.barTintColor = Color.hexStringToUIColor(hex: "#5a2986")
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        let logo = UIImage(named: "logoNavbar_1")
        let imageView = UIImageView(image: logo)
        imageView.image = logo
        imageView.contentMode = .scaleAspectFit
        self.navigationController?.navigationItem.titleView?.addSubview(imageView)
        self.navigationItem.titleView = imageView
    }
    
    func setupTabBarItems(tabBar: UITabBarController) {
        tabBar.tabBar.tintColor = Color.hexStringToUIColor(hex: "#5a2986")
    }
}
