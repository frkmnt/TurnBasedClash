extends RichTextLabel

#=== About ===#
# This class records/emits the game's logs. This includes combat interactions, found loot, etc.
# It is bound via signal to the encounter manager, which transmits any emitted logs.


#=== Variables ===#
# Individual snippets that are appended to the code.
var _log_snippets = []
# The whole text composed of snippets, as appended to the log.
var _total_text = ""




#=== Bootstrap ===#





#=== Receive Log ===#

# Receives the log data, then parses and stores the information.
# Log data contains the type and message.
# Appends an empty space before each snippet_text to offset from the panel's left border.
func register_log(snippet_text):
	_log_snippets.append(snippet_text)
	_total_text = _total_text + " " + snippet_text + "\n"
	text = _total_text
	calculate_scroll_lines()


# Calculates the scroll_vertical parameter based on the total number of lines.
func calculate_scroll_lines():
	var intended_scroll = _log_snippets.size() - 3
	if intended_scroll < 0:
		intended_scroll = 0
#	scroll_vertical = intended_scroll
#	print(get_v_scroll_bar())

