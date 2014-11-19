var array1 = [10, [20, 30], 40];
var array2 = [1, 2, [3], 4, [5, 6]];

var flatten = function(array) {
    var new_array = [];

    for (var i = array.length - 1; i >= 0; i--) {
        if (array[i] instanceOf Array) {
            for (var i = array[i].length - 1; i >= 0; i--) {
                new_array.push(array[i][i]);
            };
        }
        else {
            new_array.push(array[i]);
        };
    };
    return new_array;
}

console.log(flatten(array1));