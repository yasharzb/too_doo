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