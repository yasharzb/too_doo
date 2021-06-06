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
    case    EXIT

    var help: String {
        switch self {
        case    .CREATE:
            return "create item/category <title>/<name> <content>/- <priority>/-"
        case    .VIEW_ALL:
            return "view_all <category_name>/-"
        case    .VIEW:
            return "view <item_id>"
        case    .EDIT:
            return "edit title/content/priority <item_id> <new_value>"
        case    .DELETE:
            return "delete <item_id>"
        case    .SORT:
            return "sort title/priority/time true(ascending)/false(descending)"
        case    .ADD:
            return "add <category_name> <item1_id> [<item2_id> ..]"
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

func handle_help(inpArray: [String]) {
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

func createItem(title: String, content: String, priority: Int){
    let newItem = TodoItem(title: title, content: content, priority: priority)
    items[newItem.id] = newItem
}

func viewAll(){
    for (_,item) in items{
        print(item)
    }
}

func viewItem(id: Int){
    let item = items[id]
    if item != nil{
        print(item!)
    }else{
        print("Item not found")
    }
}

enum EDIT_TYPE: String, CaseIterable{
    case TITLE
    case CONTENT
    case PRIORITY
}


func editItem(id: Int, title: String?=nil, content: String?=nil, priority: Int?=nil){
    if let item = items[id] {
        item.title = title != nil ? title! : item.title
        item.content = content != nil ? content! : item.content
        item.priority = priority != nil ? priority! : item.priority
    }
}

func deleteItem(id: Int){
    let removedItem = items.removeValue(forKey: id)
    if removedItem == nil{
        print("Item not found")
    }
}

enum SORT_TYPE: String, CaseIterable {
    case    TITLE
    case    PRIORITY
    case    TIME
}

func viewSorted(sortType: SORT_TYPE, asc: Bool=true){
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

// -----------------

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

// ----------

func handle_cmd(inp: String) -> Bool{
    let inpArray = inp.components(separatedBy: " ")
    let cmd: String = inpArray[ParamOrder.CMD.rawValue].uppercased()
    let command = Command(rawValue: cmd)
    switch command {
    case .HELP:
        handle_help(inpArray: inpArray)
    case .ADD:
        print("Add")
    case .CREATE:
        handleCreate(inpArray: inpArray)
    case .VIEW:
        handleViewItem(inpArray: inpArray)
    case .VIEW_ALL:
        handleViewAll(inpArray: inpArray)
    case .EDIT:
        handleEdit(inpArray: inpArray)
    case .DELETE:
        handleDeleteItem(inpArray: inpArray)
    case .SORT:
        handleSort(inpArray: inpArray)
    case .EXIT:
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
