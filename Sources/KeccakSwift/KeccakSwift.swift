/**
 *
 * Copyright 2023 SUBSTRATE LABORATORY LLC <info@sublab.dev>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0

 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitati
 * ons under the License.
 *
 */

import Foundation
import KeccakC

// MARK: - Rates

public enum ShakeRate {
    case rate128
    case rate256
}

public enum Sha3Rate {
    case rate224
    case rate256
    case rate384
    case rate512
}

public enum KeccakRate {
    case rate256
}

// MARK: Swift wrapper

public struct Keccak {
    public static func hash(data: Data, rate: Rate, outputSize: OutputSize) throws -> Data {
        let outputBytesSize = outputSize.to(.bytes)
        var outputData = Data(count: outputBytesSize)
        
        let result = outputData.withUnsafeMutableBytes { output in
            data.withUnsafeBytes { input in
                let outputBuffer = output.baseAddress?.assumingMemoryBound(to: UInt8.self)
                let inputBuffer = input.baseAddress?.assumingMemoryBound(to: UInt8.self)
                let count = data.count
                
                switch rate {
                case .shake(let rate):
                    switch rate {
                    case .rate128:
                        return shake128(outputBuffer, outputBytesSize, inputBuffer, count)
                    case .rate256:
                        return shake256(outputBuffer, outputBytesSize, inputBuffer, count)
                    }
                case .sha3(let rate):
                    switch rate {
                    case .rate224:
                        return sha3_224(outputBuffer, outputBytesSize, inputBuffer, count)
                    case .rate256:
                        return sha3_256(outputBuffer, outputBytesSize, inputBuffer, count)
                    case .rate384:
                        return sha3_384(outputBuffer, outputBytesSize, inputBuffer, count)
                    case .rate512:
                        return sha3_512(outputBuffer, outputBytesSize, inputBuffer, count)
                    }
                case .keccak(let rate):
                    switch rate {
                    case .rate256:
                        return keccak_256(outputBuffer, outputBytesSize, inputBuffer, count)
                    }
                }
            }
        }
        
        guard result == 0 else {
            throw Error.internalFailure(errorCode: Int(result))
        }

        return outputData
    }
}

// MARK: - Error

extension Keccak {
    enum Error: Swift.Error {
        case internalFailure(errorCode: Int)
        case invalidHashSize
    }
}

// MARK: - Rate

extension Keccak {
    public enum Rate {
        case shake(ShakeRate)
        case sha3(Sha3Rate)
        case keccak(KeccakRate)
    }
}

// MARK: - Output size

extension Keccak {
    public enum OutputSize {
        public enum Conversion {
            case bytes, bits
        }
        
        case bytes(Int)
        case bits(Int)
        
        func to(_ size: Conversion) -> Int {
            switch (self, size) {
            case (let .bits(bits), .bits): return bits
            case (let .bits(bits), .bytes): return bits / 8
            case (let .bytes(bytes), .bytes): return bytes
            case (let .bytes(bytes), .bits): return bytes * 8
            }
        }
    }
}
