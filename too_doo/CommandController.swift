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

func handleHelp(inpArray: [String]) {
    if inpArray.count > ParamOrder.PARAM_1.rawValue {
        let cmdHelp = inpArray[ParamOrder.PARAM_1.rawValue].uppercased()
        print(help(command: Command(rawValue: cmdHelp)))
    } else {
        print(help(command: nil))
    }
}

extension Array {
    var last: Element {
        return self[self.endIndex - 1]
    }
}

func handleCreate(inpArray: [String], command: Command){
    if inpArray.count >= 3 {
        if inpArray[1] == "item"{
            let priority = Int(inpArray.last ?? "") ?? nil
            let title = inpArray[2]
            let content = Array(inpArray[3...inpArray.endIndex - 2]).joined(separator: " ")
            createItem(inpTitle: title, inpContent: content, inpPriority: priority, command: command)
        }else{
            let categoryName = inpArray[2]
            // todo
        }
    }else{
        invalidCommand(command: command)
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

func handleViewItem(inpArray: [String], command: Command){
    if inpArray.count == 2 {
        let itemId = Int(inpArray[1])
        viewItem(inpId: itemId, command: command)
    } else {
        invalidCommand(command: command)
    }
}

func handleDeleteItem(inpArray: [String], command: Command){
    if inpArray.count == 2 {
        let itemId = Int(inpArray[1])
        deleteItem(inpId: itemId, command: command)
    } else {
        invalidCommand(command: command)
    }
}

func handleSort(inpArray: [String], command: Command){
    if inpArray.count >= 2 {
        let sortTypeStr = inpArray[1].uppercased()
        let sortType = SORT_TYPE(rawValue: sortTypeStr)
        if inpArray.count < 3 || inpArray[2] == "true"{
            viewSorted(inpSortType: sortType, asc: true, command: command)
        } else {
            viewSorted(inpSortType: sortType, asc: false, command: command)
        }
    } else {
        invalidCommand(command: command)
    }
}

func handleEdit(inpArray: [String], command: Command){
    if inpArray.count >= 4 {
        let editType = EDIT_TYPE(rawValue: inpArray[1].uppercased())
        let id = Int(inpArray[2])
        switch editType{
                case .TITLE:
                    editItem(inpId: id, inpTitle: inpArray[3], command: command)
                case .PRIORITY:
                    editItem(inpId: id, inpPriority: Int(inpArray[3]), command: command)
                case .CONTENT:
                    editItem(inpId: id, inpContent: Array(inpArray[3...inpArray.endIndex - 1]).joined(separator: " "), command: command)
                case .none:
                    print("Please enter a valid edit type.")
                    print(help(command: command))
        }
    } else {
        invalidCommand(command: command)
    }
}
