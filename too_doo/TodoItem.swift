import Foundation

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

func viewAll(){
    for (_,item) in items{
        print(item)
    }
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