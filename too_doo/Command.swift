//
//  Command.swift
//  too_doo
//
//  Created by YashyZB on 6/5/21.
//  Copyright © 2021 SUT. All rights reserved.
//

import Foundation

enum EntityType: String {
    case    ITEM
    case    TITLE
    case    CONTENT
    case    PRIORITY
    case    TIME
    case    CATEGORY
}

enum CommandArg {
    case    CREATE  (EntityType, String, String, Int)
    case    VIEW_ALL(String)
    case    VIEW    (Int)
    case    EDIT    (EntityType, Int, String)
    case    DELETE  (Int)
    case    SORT    (EntityType, Bool)
    case    ADD     (Int, String)
    case    HELP    (Command)
    case    EXIT
}

enum Command: String, CaseIterable {
    case    CREATE
    case    VIEW_ALL
    case    VIEW
    case    EDIT
    case    DELETE
    case    SORT
    case    ADD
    case    HELP
    case    EXIT
    
    var help: String {
        switch self {
        case    .CREATE:
            return "create item/category <title>/<name> <content>/- <priority>/-"
        case    .VIEW_ALL:
            return "view_all <category_name>"
        case    .VIEW:
            return "view <item_id>"
        case    .EDIT:
            return "edit title/content/priority <item_id> <new_value>"
        case    .DELETE:
            return "delete <item_id>"
        case    .SORT:
            return "sort title/priority/time true(ascending)/false(descending)"
        case    .ADD:
            return "add <item_id> <category_name>"
        case    .HELP:
            return "help <command>"
        case    .EXIT:
            return "exit"
            
        }
    }
}

enum ParamOrder: Int {
    case    CMD = 0
    case    PARAM_1
    case    PARAM_2
    case    PARAM_3
    case    PARAM_4
}
