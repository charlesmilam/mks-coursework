function permutations (str) {
  // Write your code here, and
  // return your final answer.

  var chars = str.split();
  var head = chars[0];
  //var tail = chars[1..-1]
  var perms = [];

  console.log(chars);

 function mapper(ary) {
    if (ary.length === 1) {
        console.log("do something");
    }
    else{
        console.log("do something else");

    }
 }
 mapper(chars);

}


permutations("D");
permutations("abc");