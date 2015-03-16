var array1 = [10, [20, 30], 40];
var array2 = [1, 2, [3], 4, [5, 6]];

var flatten = function(array) {
    var new_array = [];

    for (var i = array.length - 1; i >= 0; i--) {
        if (array[i] instanceof Array) {
            var subArray = array[i];

            for (var j = subArray.length - 1; j >= 0; j--) {
                new_array.push(subArray[j]);
            };
        }
        else {
            new_array.push(array[i]);
        };
    };
    return new_array;
};


console.log(flatten(array1).reverse());
console.log(flatten(array2).reverse());