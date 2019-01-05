import Cocoa

class LinkedStackOfStrings {
    
    var first: Node? = nil
    var size = 0
    
    class Node {
        var value: String
        var next: Node? = nil
        
        init(value: String, next: Node?) {
            self.value = value
            self.next = next
        }
    }
    
    func isEmpty() -> Bool {
        return first == nil
    }
    
    func push(value: String) {
        first = Node(value: value, next: first)
        size = size + 1
    }
    
    func pop() -> String? {
        
        guard let val = first?.value else {
            return nil
        }
        
        first = first?.next
        size = size - 1
        return val
    }
}

class ArrayStackOfStrings {
    
    var items: [String] = [String]()
    
    var size: Int {
        get {
            return items.count
        }
    }
    
    func isEmpty() -> Bool {
        return items.count == 0
    }
    
    func push(value: String) {
        items.append(value)
    }
    
    func pop() -> String? {
        if items.count > 0 {
            return items.remove(at: items.count - 1)
        } else {
            return nil
        }
    }
}   
