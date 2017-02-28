//
//  ViewController.swift
//  Test
//
//  Created by Spare on 26/01/17.
//  Copyright © 2017 Spare. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var myContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (UIApplication.shared.keyWindow?.rootViewController as! RootViewController).delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBar.selectedItem = self.tabBar.items?[0]
        self.tabBar(self.tabBar, didSelect: (self.tabBar.items?[0])!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadVC(at index : Int) {
        let storyBoard = UIStoryboard(name: "TabBarViewControllers", bundle: nil)
        var viewControllerToLoad : UIViewController! = nil
        
        switch index {
        case 0:
            self.tabBar.selectedItem = self.tabBar.items?[0]
            viewControllerToLoad = storyBoard.instantiateViewController(withIdentifier: "favorite")
            break
        case 1:
            self.tabBar.selectedItem = self.tabBar.items?[1]
            viewControllerToLoad = storyBoard.instantiateViewController(withIdentifier: "history")
            break
        case 2:
            self.tabBar.selectedItem = nil
            viewControllerToLoad = storyBoard.instantiateViewController(withIdentifier: "accounts")
            break
        default:
            self.tabBar.selectedItem = nil
            viewControllerToLoad = storyBoard.instantiateViewController(withIdentifier: "logout")
        }
        
        viewControllerToLoad.view.frame = self.myContainerView.frame
        viewControllerToLoad.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.myContainerView.addSubview(viewControllerToLoad.view)
        let view = viewControllerToLoad.view!
        let viewComponents : [String : UIView] = ["viewToLoad" : view]
        let ho = NSLayoutConstraint.constraints(withVisualFormat: "H:|[viewToLoad]|", options: [], metrics: nil, views: viewComponents)
        let ver = NSLayoutConstraint.constraints(withVisualFormat: "V:|[viewToLoad]|", options: [], metrics: nil, views: viewComponents)
        self.myContainerView.addConstraints(ho)
        self.myContainerView.addConstraints(ver)
        self.myContainerView.layoutIfNeeded()
        
        self.addChildViewController(viewControllerToLoad)
        self.myContainerView.bringSubview(toFront: viewControllerToLoad.view)
        viewControllerToLoad.didMove(toParentViewController: self)
    }
    
    @IBAction func openMenuTapped(_ sender: UIBarButtonItem) {
        (UIApplication.shared.keyWindow?.rootViewController as! RootViewController).toggleMenu()
    }
}

extension ViewController : UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        loadVC(at: item.tag)
    }
}

extension ViewController : MenuOptionChangeProtocol {
    func shouldLoadTabBar(at index: Int) {
        self.loadVC(at: index)
    }
}
