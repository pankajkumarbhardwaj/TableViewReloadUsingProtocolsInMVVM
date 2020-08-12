//
//  ToDoViewModel.swift
//  TableViewUsingMVVM
//
//  Created by Pankaj Kumar on 24/07/20.
//  Copyright © 2020 Pankaj Kumar. All rights reserved.
//

import Foundation


protocol ToDoItemPresentable {
    var id:String? {get}
    var textValue:String? {get}
}

struct ToDoItemViewModel:ToDoItemPresentable {
    var textValue: String?
    var id: String?
}

protocol TodoItemVieDelegate {
    func onItemSelectd() -> ()
}


extension ToDoItemViewModel:TodoItemVieDelegate {
    func onItemSelectd() {
        print("tap at index id : \(id)")
    }
    
    
}

//.....................................................................



protocol TodoItemViewDelegate {
    func onTodoItemAdded() -> ()
}

class ToDoViewModel {
    weak var view:TodoView?
    
    var newTodoItem:String?
    var items:[ToDoItemPresentable] = []
    
    init(view:TodoView) {
        self.view = view
        
        let item1 = ToDoItemViewModel(textValue: "washing Cloths", id: "1")
        let item2 = ToDoItemViewModel(textValue: "Buy Groceries", id: "2")
        let item3 = ToDoItemViewModel(textValue: "washing Car", id: "3")
        self.items.append(contentsOf: [item1, item2, item3])
    }
}

extension ToDoViewModel:TodoItemViewDelegate {
    func onTodoItemAdded() {
        guard let newValue = self.newTodoItem else {
            return
        }
        let newIndex = items.count + 1
        let newItem = ToDoItemViewModel(textValue: newValue, id: "\(newIndex)")
        self.items.append(newItem)
        self.newTodoItem = ""
        self.view?.insertTodoItem()
    }
}
