function get_open_filename_cross_platform(_filter = "All Files|*", _initial_dir = "") {
	if (os_type == os_linux) {
		var proc = ProcessExecute(
			"zenity --file-selection" + 
			(_initial_dir != "" ? (" --filename=\"" + _initial_dir + "/\"") : "")
		);
		
		var result = ExecutedProcessReadFromStandardOutput(proc);
		return result;
    }
    
	return get_open_filename(_filter, _initial_dir);
}