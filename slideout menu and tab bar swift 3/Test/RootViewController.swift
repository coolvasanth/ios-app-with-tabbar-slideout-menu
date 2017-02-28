//
//  RootViewController.swift
//  Test
//
//  Created by Spare on 27/01/17.
//  Copyright © 2017 Spare. All rights reserved.
//

import UIKit

protocol MenuOptionChangeProtocol {
    func shouldLoadTabBar(at index : Int)
}

class RootViewController: UIViewController {

    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    var delegate : MenuOptionChangeProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.menuTableView.register(UINib(nibName: "menuCell", bundle: nil), forCellReuseIdentifier: "menuOptionCell")
        
        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func toggleMenu () {
        if self.containerView.frame.origin.x == 0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.containerView.frame = CGRect(x: 202, y: (self.containerView.frame.origin.y), width: (self.containerView.bounds.size.width), height: (self.containerView.bounds.size.height))
            })
        }
        else {
            UIView.animate(withDuration: 0.5, animations: {
                self.containerView.frame = CGRect(x: 0, y: (self.containerView.frame.origin.y), width: (self.containerView.bounds.size.width), height: (self.containerView.bounds.size.height))
            })
        }
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

extension RootViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.menuTableView.dequeueReusableCell(withIdentifier: "menuOptionCell") as! menuOptionCell
        if indexPath.row == 0 {
            cell.optionLabel.text = "Account"
        }
        else {
            cell.optionLabel.text = "Log out"
        }
        return cell
    }
}

extension RootViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.toggleMenu()
        self.delegate?.shouldLoadTabBar(at: indexPath.row + 2)
    }
}
