
import Foundation
import Accelerate


public func argmax(_ array: [Float], count: Int? = nil) -> (Int, Float) {
  var maxValue: Float = 0
  var maxIndex: vDSP_Length = 0
  vDSP_maxvi(array, 1, &maxValue, &maxIndex, vDSP_Length(count ?? array.count))
  return (Int(maxIndex), maxValue)
}


public func argmax(_ ptr: UnsafePointer<Float>, count: Int, stride: Int = 1) -> (Int, Float) {
  var maxValue: Float = 0
  var maxIndex: vDSP_Length = 0
  vDSP_maxvi(ptr, vDSP_Stride(stride), &maxValue, &maxIndex, vDSP_Length(count))
  return (Int(maxIndex), maxValue)
}


public func argmax(_ array: [Double], count: Int? = nil) -> (Int, Double) {
  var maxValue: Double = 0
  var maxIndex: vDSP_Length = 0
  vDSP_maxviD(array, 1, &maxValue, &maxIndex, vDSP_Length(count ?? array.count))
  return (Int(maxIndex), maxValue)
}


public func argmax(_ ptr: UnsafePointer<Double>, count: Int, stride: Int = 1) -> (Int, Double) {
  var maxValue: Double = 0
  var maxIndex: vDSP_Length = 0
  vDSP_maxviD(ptr, vDSP_Stride(stride), &maxValue, &maxIndex, vDSP_Length(count))
  return (Int(maxIndex), maxValue)
}


public func clamp<T: Comparable>(_ x: T, min: T, max: T) -> T {
  if x < min { return min }
  if x > max { return max }
  return x
}


public func sigmoid(_ x: Float) -> Float {
  return 1 / (1 + exp(-x))
}

public func sigmoid(_ x: Double) -> Double {
  return 1 / (1 + exp(-x))
}

public func sigmoid(_ x: UnsafeMutablePointer<Float>, count: Int) {
  vDSP_vneg(x, 1, x, 1, vDSP_Length(count))
  var cnt = Int32(count)
  vvexpf(x, x, &cnt)
  var y: Float = 1
  vDSP_vsadd(x, 1, &y, x, 1, vDSP_Length(count))
  vvrecf(x, x, &cnt)
}

public func sigmoid(_ x: UnsafeMutablePointer<Double>, count: Int) {
  vDSP_vnegD(x, 1, x, 1, vDSP_Length(count))
  var cnt = Int32(count)
  vvexp(x, x, &cnt)
  var y: Double = 1
  vDSP_vsaddD(x, 1, &y, x, 1, vDSP_Length(count))
  vvrec(x, x, &cnt)
}


public func softmax(_ x: [Float]) -> [Float] {
  var x = x
  let len = vDSP_Length(x.count)

  var max: Float = 0
  vDSP_maxv(x, 1, &max, len)


  max = -max
  vDSP_vsadd(x, 1, &max, &x, 1, len)


  var count = Int32(x.count)
  vvexpf(&x, x, &count)


  var sum: Float = 0
  vDSP_sve(x, 1, &sum, len)

 
  vDSP_vsdiv(x, 1, &sum, &x, 1, len)

  return x
}
