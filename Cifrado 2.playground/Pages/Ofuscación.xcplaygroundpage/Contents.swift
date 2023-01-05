import Foundation

let clave = "8vUl2/WyKzqp0sysOZRbFinbIxt5MxFIyRFyVVw6gHo="
let clavePad = clave.padding(toLength: ((clave.count / 16) + 1) * 16, withPad: "#", startingAt: 0)
let claveGood = String(clave[clave.startIndex ... clave.index(clave.startIndex, offsetBy: clave.count-1)])
clave.count
clavePad.count

let arrayBytes = [UInt8](claveGood.utf8)
let dataBytes = Data(arrayBytes)

func obfuscateKey(key:[UInt8]) -> String {
    key.reduce("") { (result, char) -> String in
        let comma = result == "" ? "" : ","
        let firstNumber = UInt8(Int.random(in: 0...Int(char)))
        switch Int.random(in: 0...1) {
        case 0:
            let number = char - firstNumber
            return "\(result)\(comma)\(String(format: "0x%02X", firstNumber))\(String(format: "+0x%02X", number))"
        default:
            return "\(result)\(comma)\(String(format: "0x%02X", char + firstNumber))\(String(format: "-0x%02X", firstNumber))"
        }
    }
}

let claveOfuscada = obfuscateKey(key: arrayBytes)
print(claveOfuscada)

let datoOfuscado:[UInt8] = [0x3A-0x02,0x5A+0x1C,0x07+0x4E,0x05+0x67,0x1F+0x13,0x1F+0x10,0x11+0x46,0xB4-0x3B,0x3B+0x10,0x4A+0x30,0x9A-0x29,0xB8-0x48,0x20+0x10,0x05+0x6E,0x81-0x08,0x03+0x70,0x29+0x26,0x10+0x4A,0x34+0x1E,0x56+0x0C,0x4B-0x05,0x11+0x58,0x35+0x39,0x33+0x2F,0x8D-0x44,0x09+0x6F,0x2C+0x48,0x57-0x22,0x50-0x03,0x01+0x77,0x7E-0x38,0x69-0x20,0x4F+0x2A,0x0F+0x43,0x37+0x0F,0x3F+0x3A,0x27+0x2F,0x90-0x3A,0xBC-0x45,0x5A-0x24,0xC9-0x62,0x27+0x21,0xB6-0x47,0x03+0x3A]

let claveDes = String(data: Data(datoOfuscado), encoding: .utf8)!
print(claveDes)


