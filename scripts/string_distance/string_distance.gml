///@function levenshtein_distance(_a, _b)
///@desc computes the Levenshtein (edit) distance between two strings —
///      the minimum number of single-character insertions, deletions,
///      or substitutions needed to turn _a into _b. Lower = more similar.
///@param {String} _a
///@param {String} _b
///@returns {Real}
function levenshtein_distance(_a, _b) {
    var len_a = string_length(_a);
    var len_b = string_length(_b);

    if (len_a == 0) return len_b;
    if (len_b == 0) return len_a;

    // only need the previous row and current row, not a full 2D matrix
    var prev_row = array_create(len_b + 1);
    var curr_row = array_create(len_b + 1);

    for (var j = 0; j <= len_b; j++) prev_row[j] = j;

    for (var i = 1; i <= len_a; i++) {
        curr_row[0] = i;
        var char_a = string_char_at(_a, i);

        for (var j = 1; j <= len_b; j++) {
            var char_b = string_char_at(_b, j);
            var cost = (char_a == char_b) ? 0 : 1;

            curr_row[j] = min(
                prev_row[j] + 1,        // deletion
                curr_row[j - 1] + 1,    // insertion
                prev_row[j - 1] + cost  // substitution (or match)
            );
        }

        // swap rows for next iteration
        var tmp = prev_row;
        prev_row = curr_row;
        curr_row = tmp;
    }

    return prev_row[len_b];
}

///@function array_query_fuzzy(_array, _query, [_max_distance=2], [_key=undefined])
///@desc filters an array of strings (or structs) by Levenshtein distance against _query.
///      Comparison is case-insensitive. Returns only entries within _max_distance edits.
///@param {Array} _array               array of strings, OR array of structs (use _key to pick a field)
///@param {String} _query              the search term
///@param {Real} [_max_distance=2]     max edit distance to count as a match (lower = stricter)
///@param {String} [_key=undefined]    if _array holds structs, the struct field to compare against
///@returns {Array} filtered array, same element type as input, no reordering
function array_query_fuzzy(_array, _query, _max_distance = 12, _key = undefined) {
    var result = [];
    var query_lower = string_lower(_query);
    var len = array_length(_array);

    for (var i = 0; i < len; i++) {
        var item = _array[i];
        var compare_str = (_key != undefined) ? item[$ _key] : item;

        var dist = levenshtein_distance(string_lower(string(compare_str)), query_lower);

        if (dist <= _max_distance) {
            array_push(result, item);
        }
    }

    return result;
}

/// @function array_query_fuzzy_sort(_array, _query, [_key=undefined])
/// @returns {Array}
function array_query_fuzzy_sort(_array, _query, _key = undefined)
{
    var query_lower = string_lower(_query);
    var scored = [];

    var len = array_length(_array);

    for (var i = 0; i < len; i++)
    {
        var item = _array[i];

        var compare_str = (_key != undefined)
            ? item[$ _key]
            : item;

        compare_str = string_lower(string(compare_str));

        var dist = levenshtein_distance(compare_str, query_lower);

        array_push(scored, {
            item : item,
            score : dist
        });
    }

    array_sort(scored, function(a, b)
    {
        return a.score - b.score;
    });

    var result = [];

    for (var i = 0; i < array_length(scored); i++)
    {
        array_push(result, scored[i].item);
    }

    return result;
}