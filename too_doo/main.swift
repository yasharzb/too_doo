//
//  main.swift
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

/* enum CommandArg {
    case    CREATE  (EntityType, String, String, Int)
    case    VIEW_ALL(String)
    case    VIEW    (Int)
    case    EDIT    (EntityType, Int, String)
    case    DELETE  (Int)
    case    SORT    (EntityType, Bool)
    case    ADD     (Int, String)
    case    HELP    (Command)
    case    EXIT
} */

enum Command: String, CaseIterable {
    case    CREATE
    case    VIEW_ALL
    case    VIEW
    case    EDIT
    case    DELETE
    case    SORT
    case    ADD
    case    HELP
    case    CLEAR
    case    EXIT

    var help: String {
        switch self {
        case    .CREATE:
            return "create item/category <title>/<name> <content>/- <priority>/-"
        case    .VIEW_ALL:
            return "view_all items/categories"
        case    .VIEW:
            return "view item/category <item_id>/<category_name>"
        case    .EDIT:
            return "edit title/content/priority <item_id> <new_value>"
        case    .DELETE:
            return "delete <item_id>"
        case    .SORT:
            return "sort title/priority/time [true(ascending/default)/false(descending)]"
        case    .ADD:
            return "add <category_name> <item1_id> [<item2_id> ..]"
        case    .HELP:
            return "help <command>"
        case    .CLEAR:
            return "clear"
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

func handleHelp(inpArray: [String]) {
    if inpArray.count > ParamOrder.PARAM_1.rawValue {
        let cmdHelp = inpArray[ParamOrder.PARAM_1.rawValue].uppercased()
        print(help(command: Command(rawValue: cmdHelp)))
    } else {
        print(help(command: nil))
    }
}


let NONE: String = ""
func help(command: Command?) -> String {
    var helpInstr: String = NONE
    for cmd in Command.allCases{
        if command != nil && command != cmd{
            continue
        }
        helpInstr += cmd.help
        helpInstr += "\n"
    }
    return helpInstr
}

// ------------------------------------------

class TodoItem : Hashable, CustomStringConvertible {
    let id :Int
    var title = "untitled"
    var category = "-"
    var content = "-"
    var priority :Int = -1
    var time: Date

    static var idIncrementer = 0

    init(title: String, content: String, priority: Int){
        self.id = TodoItem.idIncrementer
        self.title = title
        self.content = content
        self.priority = priority
        self.time = Date()

        TodoItem.idIncrementer += 1
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public var description: String { return "TodoItem:\(id)  title: \(title)  timestamp: \(time)  cat: \(category)  cont: \(content)  priority: \(priority)" }
}

func ==(lhs: TodoItem, rhs: TodoItem) -> Bool {
    return lhs.id == rhs.id
}

var items = [Int:TodoItem]()
var categories = [String:Array<Int>]()

func checkNotNil(command: Command, _ args: Any?...) -> Bool{
    for argument in args {
        if argument == nil{
            invalidCommand(command: command)
            return false
        }
    }
    return true
}

func invalidCommand(command: Command){
    print("Invalid command structure!")
    print(help(command: command))

}


func createItem(inpTitle: String?, inpContent: String?, inpPriority: Int?, command: Command){
    if checkNotNil(command: command, inpTitle, inpContent, inpPriority){
        let title = inpTitle!
        let content = inpContent!
        let priority = inpPriority!
        let newItem = TodoItem(title: title, content: content, priority: priority)
        items[newItem.id] = newItem
    }
}

func createCategory(inpCategoryName: String?, command: Command){
    if checkNotNil(command: command, inpCategoryName){
        let categoryName = inpCategoryName!
        if categories[categoryName] != nil {
            print("Category name already exists!")
        }else{
            categories[categoryName] = []
        }
    }
}

func viewAllItems(){
    for (_,item) in items{
        print(item)
    }
    print()
}

func viewAllCategories(){
    for (category, _) in categories{
        print(category)
    }
    print()
}

func viewItem(inpId: Int?, command: Command){
    if checkNotNil(command: command, inpId){
        let id = inpId!
        let item = items[id]
        if item != nil{
            print(item!)
        }else{
            print("Item not found!")
        }
    }
}

enum EDIT_TYPE: String, CaseIterable{
    case TITLE
    case CONTENT
    case PRIORITY
}


func editItem(inpId: Int?, inpTitle: String?=nil, inpContent: String?=nil, inpPriority: Int?=nil, command: Command){
    if checkNotNil(command: command, inpId){
        let id = inpId!
        if let item = items[id] {
            item.title = inpTitle ?? item.title
            item.content = inpContent ?? item.content
            item.priority = inpPriority ?? item.priority
        }else{
            print("Item not found!")
        }
    }
}

func deleteItem(inpId: Int?, command: Command){
    if checkNotNil(command: command, inpId){
        let id = inpId!
        let removedItem = items.removeValue(forKey: id)
        if removedItem == nil{
            print("Item not found!")
        }
    }
}

enum SORT_TYPE: String, CaseIterable {
    case    TITLE
    case    PRIORITY
    case    TIME
}

func viewSorted(inpSortType: SORT_TYPE?, asc: Bool=true, command: Command){
    if checkNotNil(command: command, inpSortType){
        let sortType :SORT_TYPE = inpSortType!
        func printItemArray(itemArray: Array<TodoItem>){
            for item in itemArray{
                print(item)
            }
        }
        if asc{
            switch sortType{
                case .TITLE:
                    printItemArray(itemArray: Array(items.values).sorted{ $0.title < $1.title })
                case .PRIORITY:
                    printItemArray(itemArray: Array(items.values).sorted{ $0.priority < $1.priority })
                case .TIME:
                    printItemArray(itemArray: Array(items.values).sorted{ $0.time < $1.time })
            }
        }else{
            switch sortType{
                    case .TITLE:
                        printItemArray(itemArray: Array(items.values).sorted{ $0.title > $1.title })
                    case .PRIORITY:
                        printItemArray(itemArray: Array(items.values).sorted{ $0.priority > $1.priority })
                    case .TIME:
                        printItemArray(itemArray: Array(items.values).sorted{ $0.time > $1.time })
                }
        }
    }
}

// -----------------

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
        }else if inpArray[1] == "category"{
            let categoryName = inpArray[2]
            createCategory(inpCategoryName: categoryName, command: command)
        }else{
            invalidCommand(command: command)
        }
    }else{
        invalidCommand(command: command)
    }
}


func handleViewAll(inpArray: [String], command: Command){
    if inpArray.count != 2{
        invalidCommand(command: command)
        return
    }
    if inpArray[1].lowercased() == "items"{
        viewAllItems()
    }else if inpArray[1].lowercased() == "categories"{
        viewAllCategories()
    }
    else{
        invalidCommand(command: command)
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

// ---------------------

func handle_cmd(inp: String) -> Bool{
    let inpArray = inp.components(separatedBy: " ")
    let cmd: String = inpArray[ParamOrder.CMD.rawValue].uppercased()
    let command = Command(rawValue: cmd)
    switch command {
    case .HELP:
        handleHelp(inpArray: inpArray)
    case .ADD:
        print("Add")
    case .CREATE:
        handleCreate(inpArray: inpArray, command: command!)
    case .VIEW:
        handleViewItem(inpArray: inpArray, command: command!)
    case .VIEW_ALL:
        handleViewAll(inpArray: inpArray, command: command!)
    case .EDIT:
        handleEdit(inpArray: inpArray, command: command!)
    case .DELETE:
        handleDeleteItem(inpArray: inpArray, command: command!)
    case .SORT:
        handleSort(inpArray: inpArray, command: command!)
    case .CLEAR:
        print("\u{001B}[2J")
    case .EXIT:
        print("\u{001B}[2J")
        return false
    default:
        print("Please enter a valid command")
    }
    return true
}

print("Enter a command. help to view all commands")

var isRunning = true
while isRunning {
    let inp = readLine()
    isRunning = handle_cmd(inp: inp!)
}
