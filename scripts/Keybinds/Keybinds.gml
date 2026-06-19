enum KEY { PRESS, HOLD, RELEASE }
enum BIND { NAME, TYPE, COMBO, FIRST_KEY }

function Keybinds() constructor {
	binds = [];
	environment = {};

	static bind = function(name, keys, combo = false, type = KEY.PRESS){
		if (!is_array(keys)) keys = [keys];
		
		var bin = [name, type, combo];
		if (environment[$ name] == undefined) environment[$ name] = false;
		
		for(var i = 0; i < array_length(keys); i++) {
			var k = (is_string(keys[i])) ? ord(string_upper(keys[i])) : keys[i];
			array_push(bin, k);	
		}
		
		array_push(binds, bin);
	}
	
	static step = function() {
		for(var i = 0; i < array_length(binds); i++) {
			var bin = binds[i];
			environment[$ bin[BIND.NAME]] = check_bind(bin);
		}
	}
	
	static check_bind = function(bin) {
	    var combo = bin[BIND.COMBO];
	    var type = combo ? KEY.HOLD : bin[BIND.TYPE];
	
	    for (var i = BIND.FIRST_KEY; i < array_length(bin); i++) {
	        var key = bin[i];
	
	        // Last key in a combo must be pressed this frame
	        if (combo && i == array_length(bin) - 1)
	            type = KEY.PRESS;
	
	        var result = false;
	
	        switch (type) {
	            case KEY.PRESS:
	                result = keyboard_check_pressed(key);
	                break;
	
	            case KEY.HOLD:
	                result = keyboard_check(key);
	                break;
	
	            case KEY.RELEASE:
	                result = keyboard_check_released(key);
	                break;
	        }
	
	        if (combo) {
	            if (!result)
	                return false;
	        } else if (result) {
	            return true;
	        }
	    }
	
	    return combo;
	}
}