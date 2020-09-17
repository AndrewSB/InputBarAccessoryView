//
//  InputBarStyleSelectionController.swift
//  Example
//
//  Created by Nathan Tannar on 8/18/17.
//  Copyright © 2017-2020 Nathan Tannar. All rights reserved.
//

import UIKit

class InputBarStyleSelectionController: UITableViewController {
    
    let styles = InputBarStyle.allCases

    let tabBarExampleIndexPath = IndexPath(row: 6, section: 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        title = "InputBarAccessoryView"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Styles", style: .plain, target: nil, action: nil)
        if #available(iOS 13, *) {
            navigationController?.navigationBar.tintColor = .systemBackground
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBackground]
        } else {
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        navigationController?.navigationBar.barTintColor = .systemBlue
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "InputBarViewController"
        }
        return section == 1 ? "InputAccessoryView" : "Subview"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 2 {
            return styles.count + 1 // an extra, for the tab bar example
        }
        return styles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if indexPath.section == 0 {
            cell.textLabel?.text = "README Preview"
        } else if indexPath == tabBarExampleIndexPath {
            cell.textLabel?.text = "Slack in a tab bar"
        } else {
            cell.textLabel?.text = styles[indexPath.row].rawValue
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            navigationController?.pushViewController(READMEPreviewViewController(), animated: true)
        } else {
            let convo = SampleData.shared.getConversations(count: 1)[0]
            if indexPath.section == 1 {
                navigationController?.pushViewController(
                    InputAccessoryExampleViewController(style: styles[indexPath.row],
                                                        conversation: convo),
                    animated: true)
            } else if indexPath.section == 2 {
                if indexPath.row == tabBarExampleIndexPath.row {
                    let tabBarController = UITabBarController()
                    let contained = SubviewExampleViewController(style: InputBarStyle.slack, conversation: convo)
                    tabBarController.viewControllers = [contained]
                    navigationController?.pushViewController(tabBarController, animated: true)
                } else {
                    navigationController?.pushViewController(
                        SubviewExampleViewController(style: styles[indexPath.row],
                                                     conversation: convo),
                        animated: true)
                }
            }
        }
    }
}
