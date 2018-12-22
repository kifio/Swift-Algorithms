import Cocoa

protocol UnionFind {
    var ids: [Int] {get set}
    func connected(_ p: Int, _ q: Int) -> Bool
    func union(_ p: Int, _ q: Int)
    init(n: Int)
}

class QuickFind: UnionFind {
    
    var ids: [Int]
    
    required init(n: Int) {
        ids = Array(0..<n)
    }
    
    func connected(_ p: Int, _ q: Int) -> Bool {
        return ids[p] == ids[q]
    }

    func union(_ p: Int, _ q: Int) {
        let pid = ids[p]
        let qid = ids[q]
        for i in 0..<ids.count {
            if (ids[i] == pid) {
                ids[i] = qid
            }
        }
    }
}

class QuickUnion: UnionFind {
    var ids: [Int]
    
    required init(n: Int) {
        ids = Array(0..<n)
    }
    
    func root(_ i: Int) -> Int {
        var item = i
        while ids[item] != item {
            ids[i] = ids[ids[i]]
            item = ids[item]
        }
        return item
    }

    func connected(_ p: Int, _ q: Int) -> Bool {
        return root(p) == root(q)
    }

    func union(_ p: Int, _ q: Int) {
        let pRoot = root(p)
        let qRoot = root(q)
        ids[pRoot] = qRoot
    }
}

class WeightedQuickUnion: QuickUnion {
    
    var size: [Int]
    var max: [Int]
    var count = 0
    
    required init(n: Int) {
        count = n
        size = Array(repeating: 1, count: n)
        max = Array(0..<n)
        super.init(n: n)
        print("size.count: \(size.count)")
        print("ids.count: \(self.ids.count)")
    }
    
    override func union(_ p: Int, _ q: Int) {
        let rootP = root(p);
        let rootQ = root(q);
        
        if rootP == rootQ {
            return
        }
        
        if (size[rootP] < size[rootQ]) {
            ids[rootP] = rootQ
            size[rootQ] += size[rootP]
            max[rootQ] = Swift.max(max[rootP], max[rootQ])
        } else {
            ids[rootQ] = rootP
            size[rootP] += size[rootQ]
            max[rootP] = Swift.max(max[rootP], max[rootQ])
        }
        count -= 1;
    }
    
    // Returns laargest element from union
    func find(_ i: Int) -> Int {
        return max[root(i)]
    }
}

// Test Union-find trivial operations.
func testUnionFind(_ unionFind: inout UnionFind) {
    
    unionFind.union(0, 1)
    unionFind.union(1, 2)
    unionFind.union(2, 7)
    unionFind.union(7, 8)
    unionFind.union(8, 9)
    
    print(unionFind.connected(0, 9))
    print(unionFind.connected(1, 8))
}

// Test Union-find with specific canonical element.
func testWeightedQuickUnion(_ unionFind: inout UnionFind) {
    testUnionFind(&unionFind)
    print((unionFind as! WeightedQuickUnion).find(0))
    print((unionFind as! WeightedQuickUnion).find(6))
}

struct SuccesorWithDelete {
    
    let uf: WeightedQuickUnion
    
    init(n: Int) {
        uf = WeightedQuickUnion(n: n)
    }
    
    func remove(_ i: Int) {
        uf.union(i, i + 1)
    }
    
    func successor(_ i: Int) -> Int {
        return uf.find(i)
    }
}

var quickFind: UnionFind = QuickFind(n: 10)
var quickUnion: UnionFind = QuickUnion(n: 10)
var weightedQuickUnion: UnionFind = WeightedQuickUnion(n: 10)

func testSuccesorWithDelete() {
    let succesorWithDelete = SuccesorWithDelete(n: 10)
    print(succesorWithDelete.successor(5))
    succesorWithDelete.remove(5)
    print(succesorWithDelete.successor(5))
}

testUnionFind(&quickFind)
testUnionFind(&quickUnion)
testWeightedQuickUnion(&weightedQuickUnion)
testSuccesorWithDelete()
