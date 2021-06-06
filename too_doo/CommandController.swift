//
//  CommandController.swift
//  too_doo
//
//  Created by YashyZB on 6/5/21.
//  Copyright © 2021 SUT. All rights reserved.
//

import Foundation

extension Array {
    var last: Element {
        return self[self.endIndex - 1]
    }
}

func handleCreate(inpArray: [String]){
    if inpArray[1] == "item"{
        let priority = Int(inpArray.last!)!
        let title = inpArray[2]
        let content = Array(inpArray[3...inpArray.endIndex - 1]).joined(separator: " ")
        createItem(title: title, content: content, priority: priority)
    }else{
        let categoryName = inpArray[2]
        // todo
    }
}


func handleViewAll(inpArray: [String]){
    if inpArray.count == 1{
        viewAll()
    }else{
        let categoryName = inpArray[1]
            // todo
    }
}

func handleViewItem(inpArray: [String]){
    let itemId = Int(inpArray[1])!
    viewItem(id: itemId)
}

func handleDeleteItem(inpArray: [String]){
    let itemId = Int(inpArray[1])!
    deleteItem(id: itemId)
}

func handleSort(inpArray: [String]){
    let sortTypeStr = inpArray[1].uppercased()
    let sortType = SORT_TYPE(rawValue: sortTypeStr)!
    if inpArray[2] == "true"{
        viewSorted(sortType: sortType, asc: true)
    }else{
        viewSorted(sortType: sortType, asc: false)
    }
}

func handleEdit(inpArray: [String]){
    let editType = EDIT_TYPE(rawValue: inpArray[1].uppercased())
    let id = Int(inpArray[2])!
    switch editType{
            case .TITLE:
                editItem(id: id, title: inpArray[3])
            case .PRIORITY:
                editItem(id: id, priority: Int(inpArray[3])!)
            case .CONTENT:
                editItem(id: id, content: inpArray[3])
            case .none:
                print("Please enter a valid edit type.")
        }
}
