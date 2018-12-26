import Cocoa

func exchange<T>(_ items: inout [T],_ f: Int,_ t: Int) {
    let tmp = items[f]
    items[f] = items[t]
    items[t] = tmp
}

func shuffle<T>(_ items: inout [T]) {
    for i in items.indices {
        exchange(&items, Int.random(in: 0...i), i)
    }
}

func mergeSort<T: Comparable>(_ arr: inout [T], _ left: Int = 0, _ right: Int = arr.count) {
    if right - left <= 1 {
        return
    }
    
    // Divide array, sort each subarray
    let mid = (left + right) / 2
    mergeSort(&arr, left, mid)
    mergeSort(&arr, mid, right)
    merge(&arr, left, mid, right)
}

func merge<T: Comparable>(_ arr: inout [T], _ left: Int, _ mid: Int, _ right: Int) {
    var i = 0, j = 0
    var result = [T]()
    
    // Add smallest element to results  and move to next
    while left + i < mid && mid + j < right {
        if arr[left + i] < arr[mid + j] {
            result.append(arr[left + i])
            i += 1
        } else {
            result.append(arr[mid + j])
            j += 1
        }
    }
    
    // If the array contains odd elements count, add all the rest elements from left part to results
    while left + i < mid {
        result.append(arr[left + i])
        i += 1
    }
    
    // If the array contains odd elements count, add all the rest elements from right part to results
    while mid + j < right {
        result.append(arr[mid + j])
        j += 1
    }
    
    print(result)
    for k in 0..<result.count {
        arr[left + k] = result[k]
    }
}

var arr = [Int]()

for i in 0..<25 {
    arr.append(i)
}
//
//shuffle(&arr)
//mergeSort(&arr)
//print(arr)

func quickSort<T: Comparable>(_ arr: inout [T], _ left: Int = 0, _ right: Int = arr.count - 1) {
//    print("Сортируем подмассив от \(left) до \(right)")

    if left > right - 1 {
        return
    }
    
    let p = partition(&arr, left, right)
    
    quickSort(&arr, left, p)
    quickSort(&arr, p + 1, right)
}

func partition<T: Comparable>(_ arr: inout [T], _ left: Int, _ right: Int) -> Int {
    let p = left
    var j = right
    var i = left + 1
    
//    print("Pivot \(p) = \(arr[p]);")
//    print("Left: \(i) = \(arr[i]);")
//    print("Right: \(j) = \(arr[j]);")
//    print("\(arr)\n")

    while i <= j {
        
        while i <= j && arr[i] < arr[p] {
            i += 1
        }
        
        while j >= i && arr[j] > arr[p] {
            j -= 1
        }
        
        if i >= j {
            break
        }
        
//        print("Swap: \(j) = \(arr[j]) с \(i) = \(arr[i])")
        exchange(&arr, i, j)
    }
//    print("Swap: \(p) = \(arr[p]) с \(j) = \(arr[j])")
    exchange(&arr, p, j)
    return j
}

//shuffle(&arr)
//quickSort(&arr)
//print(arr)

for i in 1...5 {
    arr.removeAll()

    for j in 0...(5 * i) {
        arr.append(j)
    }

    shuffle(&arr)
    quickSort(&arr)
    print(arr)
}
