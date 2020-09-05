//
//  ContentView.swift
//  SlotMachine
//
//  Created by James Cosgrove on 05/09/2020.
//

import SwiftUI



struct ContentView: View {
    @State private var score = 58
    var body: some View {
        SlotMachineView(score: $score)
    }
}

struct SlotMachineView: View {
    @Binding var score: Int
    var digits: [Int] {
        var digitsArray = [0, 0, 0, 0, 0, 0]
        let numberArray = String(score).compactMap{ $0.wholeNumberValue }
        digitsArray.insert(contentsOf: numberArray, at: digitsArray.count - numberArray.count)
        print(digitsArray)
        return digitsArray
    }
    var body: some View {
        VStack {
            HStack {
                NumberView(number: digits[0])
                NumberView(number: digits[1])
                NumberView(number: digits[2])
                NumberView(number: digits[3])
                NumberView(number: digits[4])
                NumberView(number: digits[5])
            }
            Button(action: {
                score = Int.random(in: 0...999)
            }, label: {
                Text("New Number: \(score)")
            })
        }
    }
}

struct NumberView: View {
    var number: Int = 0
    var body: some View {
        VStack {
            NumberListView(number: number)
                .offset(x: 0, y: CGFloat(135 - (30 * number)))
                .animation(.easeInOut(duration: 2))
        }
        .overlay(
            Rectangle()
                .stroke(Color.gray, lineWidth: 3)
                .frame(width: 28, height: 34, alignment: .center)
        )
        .mask(
            Rectangle()
                .frame(width: 30, height: 36, alignment: .center)
        )
    }
}

struct NumberListView: View {
    var number: Int = 0
    var body: some View {
        VStack {
            ForEach(0...9, id: \.self) { number in
                Text("\(number)")
                    .font(Font.system(.largeTitle, design: .monospaced))
                    .fontWeight(.medium)
                    .frame(width: 20, height: 30, alignment: .center)
                    
            }
        }
    }
}

struct NumberListView_Previews: PreviewProvider {
    static var previews: some View {
        NumberListView().previewLayout(.sizeThatFits)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
