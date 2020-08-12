//
//  ViewController.swift
//  TableViewUsingMVVM
//
//  Created by Pankaj Kumar on 24/07/20.
//  Copyright © 2020 Pankaj Kumar. All rights reserved.
//

import UIKit

protocol TodoView:class {
    func insertTodoItem()
}

class ViewController: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var addItemTextField: UITextField!
    
    let identifier = "TodoItemTableViewCell"
    var viewModel: ToDoViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.inetialSetup()
    }
    
    private func inetialSetup() {
        let nib = UINib(nibName:"TodoItemTableViewCell", bundle: nil)
        self.myTableView.register(nib, forCellReuseIdentifier: identifier)
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
        self.viewModel = ToDoViewModel(view: self)
    }

    @IBAction func addItemAction(_ sender: Any) {
        guard let text = self.addItemTextField.text, text != "" else {return}
        viewModel?.newTodoItem = text
        viewModel?.onTodoItemAdded()
    }
    
}


extension ViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.items.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? TodoItemTableViewCell
        let itemViewModel = viewModel?.items[indexPath.row]
        cell?.configure(withViewModel: itemViewModel!)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemViewModel = viewModel?.items[indexPath.row]
        (itemViewModel as? TodoItemVieDelegate)?.onItemSelectd()
    }
}

extension ViewController:TodoView {
    func insertTodoItem() {
        guard let items = viewModel?.items else {return}
        
        self.addItemTextField.text = viewModel?.newTodoItem
        
        self.myTableView.beginUpdates()
        self.myTableView.insertRows(at: [IndexPath(row: items.count-1, section: 0)], with: .automatic)
        self.myTableView.endUpdates()
    }    
}
