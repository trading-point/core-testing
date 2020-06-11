//
//  ViewController.swift
//  CoreTesting
//
//  Created by gsoti on 03/16/2020.
//  Copyright (c) 2020 gsoti. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    
    var data: [String] = [
        "Document history"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: UIViewController
        let text = data[indexPath.row]
        switch text {
        case "Document history":
            let cases: [Document.`Type`] = [
                .received,
                .clarify,
                .validated,
                .rejected
            ]
            let data = Array(repeating: cases, count: 6)
                .flatMap {$0}
                .map { Document.init(title: "My driving license", subtitle: "Nov 20, 2019 at 13:30, JPG", type: $0) }
            vc = DocumentHistoryViewController(data: data)
        default:
            fatalError("case not supported")
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
