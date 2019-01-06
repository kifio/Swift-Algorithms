import Cocoa

class Node<K, V> {
    var value: V
    let key: K
    var left: Node?
    var right: Node?
    
    init(key: K, value: V) {
        self.value = value
        self.key = key
    }
}

class BinarySearchTree<K: Comparable, V> {
    
    private var root: Node<K, V>?
    
    func put(key: K, value: V) {
        root = put(root, key, value)
    }
    
    private func put(_ node: Node<K, V>?, _ key: K, _ value: V) -> Node<K, V> {
        if node == nil {
            return Node<K, V>(key: key, value: value)
        }
        
        if key < node!.key {
//            print("put \(key) to the left of \(node!.key)")
            node!.left = put(node!.left, key, value)
        } else if key > node!.key {
//            print("put \(key) to the right of \(node!.key)")
            node!.right = put(node!.right, key, value)
        } else {
//            print("rest \(key) with value \(value)")
            node!.value = value
        }
        
        return node!
    }
    
    func get(key: K) -> V? {
        var node = root
        while node != nil {
//            print("compare \(key) with \(node!.key)")
            if key < node!.key {
                node = node!.left
            } else if key > node!.key {
                node = node!.right
            } else {
                return node!.value
            }
        }
        return nil
    }
    
    func delete(key: K) {
        root = delete(&root, key)
    }
    
    private func delete(_ node: inout Node<K, V>?,_ key: K) -> Node<K, V>? {
        if node == nil {
            return nil
        } else if key < node!.key {
            var left = node!.left
            node!.left = delete(&left, key)
        } else if key > node!.key {
            var right = node!.right
            node!.right = delete(&right, key)
        } else {
            if node!.right == nil {
                return node!.left
            } else if node!.left == nil {
                return node!.right
            }
            
            let t = node!
            node = min(t.right!)
            node!.right = deleteMin(t.right!)
            node!.left = t.left
        }
        return node
    }
    
    private func deleteMin(_ node: Node<K, V>) -> Node<K, V>? {
        if node.left == nil {
            return node.right
        } else {
            node.left = deleteMin(node.left!);
            return node
        }
    }
    
    private func min(_ node: Node<K, V>) -> Node<K, V> {
        if node.left == nil {
            return node
        } else {
            return min(node.left!)
        }
    }
}

var bts = BinarySearchTree<String, Int>()

bts.put(key: "Dimka", value: 26)
bts.put(key: "Diman", value: 26)
bts.put(key: "JoJo", value: 26)
bts.put(key: "Anton", value: 26)
bts.put(key: "Alexander", value: 26)
bts.put(key: "Kirill", value: 25)
bts.put(key: "Nastya", value: 22)
bts.put(key: "Ivasik", value: 25)
bts.put(key: "Dasha", value: 25)

bts.delete(key: "Dimka")
bts.delete(key: "Diman")
bts.delete(key: "JoJo")
bts.delete(key: "Anton")
bts.delete(key: "Alexander")
bts.delete(key: "Kirill")
bts.delete(key: "Nastya")
bts.delete(key: "Ivasik")
bts.delete(key: "Dasha")
