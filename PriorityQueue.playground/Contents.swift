import Cocoa

class PriorityQueue<T : Comparable> {
    
    private var items = [T?]()
    
    init() {
        items.append(nil)
    }
    
    public func isEmpty() -> Bool {
        return items.count == 1
    }
    
    public func enqueue(item: T) {
        items.append(item)
        swim(items.count - 1)
    }
    
    public func dequeue() -> T {
        let max = items[1]!
        // swap largest and smallest elements
        exchange(1, items.count - 1)
        // remove largest item
        items.removeLast()
        // reorder items, for choosing new largest item
        sink(k: 1)
        return max
    }
    
    private func swim(_ k: Int) {
        var index = k
        // while parent node smaller, then child, swap them
        while index > 1 && items[index/2]! < items[index]! {
//            print("Swim: \(index)")
            exchange(index, index/2)
            index = index / 2
        }
    }
    
    private func sink(k: Int) {
        var i = k
//        print("Sink: \(i)")
        while i * 2 < items.count {
            var j = i * 2
            
            // choose largest node
            if j < items.count - 1 && items[j]! < items[j + 1]! {
                j += 1
            }
//            print("Largest: \(items[j])")
            
            // if current node larger then child, break.
            if items[i]! >= items[j]! {
                break
            }
            
            // swap current node and largest child
            exchange(i, j)
            i = j
        }
    }
    
    private func exchange(_ f: Int,_ t: Int) {
//        print("Swap: \(items[f]) and \(items[t])")
        let tmp = items[f]
        items[f] = items[t]
        items[t] = tmp
    }
}

// enqueue & dequeue
var pq = PriorityQueue<String>()
pq.enqueue(item: "A")
pq.enqueue(item: "B")
pq.enqueue(item: "C")
pq.enqueue(item: "D")
pq.enqueue(item: "E")
pq.enqueue(item: "F")

while !pq.isEmpty() {
    print("Remove: \(pq.dequeue())")
}
