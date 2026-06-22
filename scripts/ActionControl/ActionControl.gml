function ActionControl() constructor {
	actionlist = [];
	index = 0; // points to the next slot to write; also = number of "active" actions (before redo-undone ones)
	
	// Call this to undo the most recent action
	undo = function() {
		if (index <= 0) return; // nothing to undo
		index--;
		var action = actionlist[index];
		action.apply(action.before);
	}
	
	// Call this to redo the most recently undone action
	redo = function() {
		if (index >= array_length(actionlist)) return; // nothing to redo
		var action = actionlist[index];
		action.apply(action.after);
		index++;
	}
	
	// Call this whenever the user performs a NEW action.
	// `before`/`after` are state snapshots; `apply` is a function(state) that sets the state.
	add = function(before, after, apply) {
		// Throw away any "future" redo history past current index
		if (index < array_length(actionlist)) {
			array_delete(actionlist, index, array_length(actionlist) - index);
		}
		array_push(actionlist, {before: before, after: after, apply: apply});
		index++;
	}
}

//static functions

// Applies a node state snapshot (used for both undo and redo)
function move_node(state) {
	var node = state.object;
	node.x = state.x;
	node.y = state.y;

}

// Helper: grab a snapshot of a node's current transform
function capture_node_state(node) {
	return {
		object: node,
		x: node.x,
		y: node.y,

	};
}