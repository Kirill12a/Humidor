
import Swift

extension Array where Element: Comparable {

  public func argmax() -> (Int, Element) {
    precondition(self.count > 0)
    var maxIndex = 0
    var maxValue = self[0]
    for i in 1..<self.count where self[i] > maxValue {
      maxValue = self[i]
      maxIndex = i
    }
    return (maxIndex, maxValue)
  }


  public func argsort(by areInIncreasingOrder: (Element, Element) -> Bool) -> [Array.Index] {
    return self.indices.sorted { areInIncreasingOrder(self[$0], self[$1]) }
  }


  public func gather(indices: [Array.Index]) -> [Element] {
    return indices.map { self[$0] }
  }
}
