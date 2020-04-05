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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.dataSource = self
        tableView.register(DocumentHistoryCell.self, forCellReuseIdentifier: "DocumentHistoryCell")
        tableView.rowHeight = 80
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentHistoryCell", for: indexPath) as! DocumentHistoryCell
        let viewState = DocumentHistoryCell.ViewState(title: "My driving license", subtitle: "Nov 20, 2019 at 13:30, JPG", type: .rejected)
        cell.update(with: viewState)
        return cell
    }
    
    
}
