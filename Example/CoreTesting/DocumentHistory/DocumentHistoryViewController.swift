import UIKit
import SnapKit

class DocumentHistoryViewController: UIViewController {
    
    let tableView = UITableView()
    
    let data: [Document]
    
    init(data: [Document]) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.dataSource = self
        tableView.register(DocumentHistoryCell.self, forCellReuseIdentifier: "DocumentHistoryCell")
        tableView.rowHeight = UITableView.automaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension DocumentHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentHistoryCell", for: indexPath) as! DocumentHistoryCell
        let document = data[indexPath.row]
        let viewState = DocumentHistoryCell.ViewState.makeWith(document: document)
        cell.update(with: viewState)
        return cell
    }
    
    
}
