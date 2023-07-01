extends Node

const letters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"] 
const symbols = ["!","@","#","$","%","^","&","*","(",")","-","_","+","=","[","]","{","}","\\","|",".",",","<",">","/","?","'","\"",";",":"]
const non_number = ["!","@","#","$","%","^","&","*","(",")","_","+","=","[","]","{","}","\\","|",",","<",">","/","?","'","\"",";",":","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"] 
const numbers = ["0","1","2","3","4","5","6","7","8","9"]

func isolate_id(uuid):
	return str(uuid).get_slice("|", 1)
func gen_uuid(length, identifier):
	var result = ""
	for index in length:
		var letter_index = randi_range(0, 25)
		var number_index = randi_range(0, 9)
		if (randf() > 0.5):
			var letter = letters[letter_index]
			if (randf() > 0.5):
				result = result + letter.capitalize()
			else:
				result = result + letter
		else:
			result = result + numbers[number_index]
	return result + "|" + identifier
func contains_any(string: String, chas: Array):
	var result = false
	for cha in chas:
		if string.contains(cha):
			result = true
			break
	return result
func erase_provided(string: String, chas: Array):
	var result = string
	for cha in chas:
		result.replace(cha, "")
	return result
# Both return 0 if a non number is found ("-" and "." are considered numbers)
func get_int_safe(string: String):
	var check = contains_any(string, non_number)
	return 0 if check else int(string)
func get_float_safe(string: String):
	const non_number = ["!","@","#","$","%","^","&","*","(",")","-","_","+","=","[","]","{","}","\\","|",",","<",">","/","?","'","\"",";",":","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"] 
	var check = contains_any(string, non_number) && string.count(".") <= 1
	return 0.0 if check else float(string)
func find_any(string: String, chas: Array, after: bool = false) -> int:
	var result = 0
	for index in string.length() - 1:
		for cha in chas:
			var sub_str = string.substr(index, cha.length())
			if sub_str == cha:
				result = index + cha.length() if after else index
				return result
	return 0
