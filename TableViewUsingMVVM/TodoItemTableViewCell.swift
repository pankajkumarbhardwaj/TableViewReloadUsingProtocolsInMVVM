//
//  TodoItemTableViewCell.swift
//  TableViewUsingMVVM
//
//  Created by Pankaj Kumar on 24/07/20.
//  Copyright © 2020 Pankaj Kumar. All rights reserved.
//

import UIKit

class TodoItemTableViewCell: UITableViewCell {

    @IBOutlet weak var textIndex: UILabel!
    @IBOutlet weak var textTodoitem: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(withViewModel viewModel:ToDoItemPresentable) {
        textIndex.text = viewModel.id
        textTodoitem.text = viewModel.textValue
    }
}
