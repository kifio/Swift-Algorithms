import Cocoa

func exchange<T>(_ items: inout [T],_ f: Int,_ t: Int) {
    let tmp = items[f]
    items[f] = items[t]
    items[t] = tmp
}

struct Selection<T: Comparable> {
    
    static func min(_ items: [T],_ min: Int) -> Int {
        var m = min
        for i in min..<items.count {
            if items[i] < items[m] {
                m = i
            }
        }
        return m
    }
    
    static func sort(items: inout [T]) {
        var min = 0
        for i in 0..<items.count {
            min = Selection.min(items, i)
            print("exchange: \(items[i]) and \(items[min])")
            exchange(&items, i, min)
        }
    }
}

//var arr = ["Dashka", "Ivasik", "JoJo", "Anton", "Dima", "Nastya"]
//Selection.sort(items: &arr)
//print(arr)

struct Insertion<T: Comparable> {
    static func sort(items: inout [T]) {
        for i in 1..<items.count {
            for j in (1...i).reversed() {
                if items[j] < items[j - 1] {
                    exchange(&items, j - 1, j)
                } else {
                    break
                }
            }
        }
    }
}

//var arr1 = [9,2,4,3,1,0,8,6,7,5,10]
//Insertion.sort(items: &arr1)
//print(arr1)

struct Shell<T: Comparable> {
    static func sort(items: inout [T]) {
        var k = items.count / 2
        while k != 0 {
            print("Shell with step: \(k)")
            for i in 0..<items.count - k {
                if items[i] > items[i + k] {
                    exchange(&items, i, k)
                }
            }
            k =  k / 2
        }
    }
}

//var arr2 = [9,2,4,3,1,0,8,6,7,5,10]
//Shell.sort(items: &arr2)
//print(arr1)

struct Shuffling<T> {
    static func shuffle(items: inout [T]) {
        for i in items.indices {
            exchange(&items, Int.random(in: 0...i), i)
        }
    }
}

//Shuffling.shuffle(items: &arr2)
//print(arr2)

func dutchNationalFlag(_ n: Int) {
    
    var swapsCount = 0
    var colorCount = 0
    var lo = 0
    var mid = 0
    var hi = 3 * n - 1
    
    var arr = Array(repeating: "r", count: n) + Array(repeating: "w", count: n) + Array(repeating: "b", count: n)
    Shuffling.shuffle(items: &arr)
    print(arr)

    func swap(_ f: Int,_ t: Int) {
        swapsCount += 1
        exchange(&arr, f, t)
    }
    
    func color(_ i: Int) -> String {
        colorCount += 1
        return arr[i]
    }
    
    while mid <= hi {
        if color(mid) == "r" {
            swap(lo, mid)
            mid += 1
            lo += 1
        } else if color(mid) == "w" {
            swap(hi, mid)
            hi -= 1
        } else {
            mid += 1
        }
    }
    
    print(arr)
    print("Items count: \(arr.count)")
    print("Swaps: \(swapsCount)")
    print("Color: \(colorCount)")
}

dutchNationalFlag(10)
