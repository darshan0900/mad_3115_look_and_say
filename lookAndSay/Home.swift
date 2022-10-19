//
//  ViewController.swift
//  lookAndSay
//
//  Created by Darshan Jain on 2022-10-18.
//

import UIKit

struct NumberCount{
	let number: String
	var count:Int
}

class Home: UIViewController {

	@IBOutlet weak var sayLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)
		
		reset()
	}

	@IBAction func onNumberChanged(_ sender: UITextField) {
		let input = sender.text!
		let splitInput = input.map({String($0)})
		var numbersWithCount: [NumberCount] = []
		for number in splitInput{
			if let index = numbersWithCount.firstIndex(where: {$0.number==number}){
				numbersWithCount[index].count += 1
			}else{
				numbersWithCount.append(NumberCount(number: number, count: 1))
			}
		}
		var label = ""
		for (index, item) in numbersWithCount.enumerated(){
			if(index>0 && index >= numbersWithCount.count - 1){
				label += " and "
			}else if !label.isEmpty{
				label+=", "
			}
			label += "\(getNumberinWords(number: item.count)) \(getPlural(number: item.number, count: item.count))"
		}
		if !label.isEmpty{
			label = label.prefix(1).uppercased()+label.dropFirst()
			sayLabel.text = label
		}else{
			reset()
		}
		
	}
	
	private func getPlural (number: String, count: Int)-> String{
		if count>1{
			return number+"s"
		}
		return number
	}
	
	private func getNumberinWords (number: Int) -> String{
		let digitNames = [
			0: "zero",
			1: "one",
			2: "two",
			3: "three",
			4: "four",
			5: "five",
			6: "six",
			7: "seven",
			8: "eight",
			9: "nine"
		]
		return digitNames[number]!
	}
	
	private func reset (){
		sayLabel.text = "Type something in the box"
	}
}

