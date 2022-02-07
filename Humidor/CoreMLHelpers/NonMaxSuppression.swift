

import Foundation
import Accelerate

public struct BoundingBox
{

  public let classIndex: Int


  public let score: Float


  public let rect: CGRect

  public init(classIndex: Int, score: Float, rect: CGRect)
  {
    self.classIndex = classIndex
    self.score = score
    self.rect = rect
  }
}


public func IOU(_ a: CGRect, _ b: CGRect) -> Float
{
  let areaA = a.width * a.height
  if areaA <= 0 { return 0 }

  let areaB = b.width * b.height
  if areaB <= 0 { return 0 }

  let intersectionMinX = max(a.minX, b.minX)
  let intersectionMinY = max(a.minY, b.minY)
  let intersectionMaxX = min(a.maxX, b.maxX)
  let intersectionMaxY = min(a.maxY, b.maxY)
  let intersectionArea = max(intersectionMaxY - intersectionMinY, 0) *
                         max(intersectionMaxX - intersectionMinX, 0)
  return Float(intersectionArea / (areaA + areaB - intersectionArea))
}


public func nonMaxSuppression(boundingBoxes: [BoundingBox],
                              iouThreshold: Float,
                              maxBoxes: Int) -> [Int] {
  return nonMaxSuppression(boundingBoxes: boundingBoxes,
                           indices: Array(boundingBoxes.indices),
                           iouThreshold: iouThreshold,
                           maxBoxes: maxBoxes)
}


public func nonMaxSuppression(boundingBoxes: [BoundingBox],
                              indices: [Int],
                              iouThreshold: Float,
                              maxBoxes: Int) -> [Int] {

  let sortedIndices = indices.sorted { boundingBoxes[$0].score > boundingBoxes[$1].score }

  var selected: [Int] = []

  for i in 0..<sortedIndices.count
  {
    if selected.count >= maxBoxes { break }

    var shouldSelect = true
    let boxA = boundingBoxes[sortedIndices[i]]


    for j in 0..<selected.count {
      let boxB = boundingBoxes[selected[j]]
      if IOU(boxA.rect, boxB.rect) > iouThreshold
      {
        shouldSelect = false
        break
      }
    }


    if shouldSelect
    {
      selected.append(sortedIndices[i])
    }
  }

  return selected
}


public func nonMaxSuppressionMultiClass(numClasses: Int,
                                        boundingBoxes: [BoundingBox],
                                        scoreThreshold: Float,
                                        iouThreshold: Float,
                                        maxPerClass: Int,
                                        maxTotal: Int) -> [Int] {
  var selectedBoxes: [Int] = []

  for c in 0..<numClasses
  {
    var filteredBoxes = [Int]()

    for p in 0..<boundingBoxes.count
    {
      let prediction = boundingBoxes[p]
      if prediction.classIndex == c
      {

        if prediction.score > scoreThreshold
        {
          filteredBoxes.append(p)
        }
      }
    }

    let nmsBoxes = nonMaxSuppression(boundingBoxes: boundingBoxes,
                                     indices: filteredBoxes,
                                     iouThreshold: iouThreshold,
                                     maxBoxes: maxPerClass)

    selectedBoxes.append(contentsOf: nmsBoxes)
  }

  let sortedBoxes = selectedBoxes.sorted { boundingBoxes[$0].score > boundingBoxes[$1].score }
  return Array(sortedBoxes.prefix(maxTotal))
}
