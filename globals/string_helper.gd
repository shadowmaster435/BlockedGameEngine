extends Node

const letters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"] 
const symbols = ["!","@","#","$","%","^","&","*","(",")","-","_","+","=","[","]","{","}","\\","|",".",",","<",">","/","?","'","\"",";",":"]
const non_number = ["!","@","#","$","%","^","&","*","(",")","_","+","=","[","]","{","}","\\","|",",","<",">","/","?","'","\"",";",":","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"] 
const numbers = ["0","1","2","3","4","5","6","7","8","9"]

func parse_bracket_text(string: String):
	var sub_string = string.substr(1, string.find(")"))
	return to_sliced_dictionary(sub_string, [","], false)

func to_sliced_dictionary(provided_string: String, delims: Array, include_delims: bool = true):
	var string = provided_string.replace(" ", "")
	var result = {}
	var split_strings = {}
	var split_delims = {}
	var unified_slices = replace_all(string, "|", delims)
	var slice_index = 0
	var aux_index = 0
	var slice_sub_string = ""
	var aux_sub_string = ""
	for index in string.length() :
		
		for delim in delims:
			var sliced = ""
			var matches = 0
			var delim_leng = delim.length()
	
			for delim_char_index in delim_leng:
				if string[clamp(index + delim_char_index, 0, string.length() - 1)] == delim[delim_char_index]:
					matches += 1
					continue
				else:
					break
			if matches == delim_leng:
				if slice_sub_string != "":
					split_strings[slice_index] = erase_provided(slice_sub_string, delims)
					split_delims[aux_index] = delim
					slice_index += 1
					slice_sub_string = ""
				else:

					split_delims[aux_index] = delim

					split_strings[slice_index] = delim + erase_provided(aux_sub_string, delims) + ")"

				aux_index += 1


				
		slice_sub_string = slice_sub_string + string[index]
		aux_sub_string = aux_sub_string + string[index]
	split_strings[slice_index] = erase_provided(slice_sub_string, delims) 

	return {"strings": split_strings, "delims": split_delims} if include_delims else split_strings
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
		result = result.replace(cha, "")
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
func replace_all(string: String, with: String, chars: Array):
	var result = string
	for char in chars:
		result = result.replace(char, with)
	return result
func to_json(dict: Dictionary):
	return JSON.stringify(dict, "\t")
