
import Vision


public func top(_ k: Int, _ prob: [String: Double]) -> [(String, Double)] {
  return Array(prob.map { x in (x.key, x.value) }
                   .sorted(by: { a, b -> Bool in a.1 > b.1 })
                   .prefix(through: min(k, prob.count) - 1))
}

/
public func top(_ k: Int, _ observations: [VNClassificationObservation]) -> [(String, Double)] {
  return observations.prefix(through: min(k, observations.count) - 1)
                     .map { ($0.identifier, Double($0.confidence)) }
}
