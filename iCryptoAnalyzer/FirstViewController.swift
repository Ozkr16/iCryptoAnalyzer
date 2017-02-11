//
//  FirstViewController.swift
//  iCryptoAnalyzer
//
//  Created by Oscar Gutierrez C on 10/2/17.
//  Copyright © 2017 Trilobytes. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITextViewDelegate {

	@IBOutlet weak var textToAnalyzeField: UITextView!
	@IBOutlet weak var ResultsLabel: UILabel!

	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		textToAnalyzeField.delegate = self

	}
	
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	
	 func textViewDidChange(_ textView: UITextView) {
		
		let frequencyResults = calculateFrequencyOf(stringToAnalyze: textView.text)
		let formatedString = formatFrequency(results: frequencyResults)
		self.ResultsLabel.text = formatedString

	}
	
	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		if(text == "\n") {
			textView.resignFirstResponder()
			return false
		}
		return true
	}
	
	func calculateFrequencyOf(stringToAnalyze: String) -> [(String, Double)] {
		let symbols = stringToAnalyze.lowercased().characters.map{String($0)}
		
		var results =  [(String, Double)]()
		for letra in symbols {
			if let indiceLetra = results.index(where: {(simbolo, frecuencia) in simbolo == letra}){
				let elemento = results.remove(at: indiceLetra)
				results.append((elemento.0, elemento.1 + 1 ))
			}else{
				results.append((letra, 1))
			}
		}
		return results
	}
	
	func formatFrequency(results: [(String, Double)]) -> String {
		var parcialResult : String = ""
		let numeroItems = Double(textToAnalyzeField.text.characters.count)
		
		for (letra, frecuencia) in results.sorted(by: {$0.1 > $1.1})
		{
			parcialResult += "Sign: \(letra) | Freq: \((frecuencia/numeroItems)*100 ) \n"
		}
		return parcialResult
	}

}

