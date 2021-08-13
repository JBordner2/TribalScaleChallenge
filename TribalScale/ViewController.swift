//
//  ViewController.swift
//  TribalScale
//
//  Created by Jack Bordner on 8/13/21.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var viewModel = ViewControllerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "articleTableViewCell")
        tableView.estimatedRowHeight = CGFloat(100)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "articleTableViewCell", for: indexPath) as? ArticleTableViewCell else { return UITableViewCell() }
    
        let article = viewModel.data[indexPath.row]
        cell.configure(article: article)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ViewController: ViewControllerViewModelDelegate {
    
    func didRetrieveData() {
        tableView.reloadData()
    }
    
    func didRecieveError(error: Error) {
        print(error)
    }
}
