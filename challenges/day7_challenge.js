function isPalindrome (str) {
  // Write your code here, and
  // return your final answer.
 str.toLowerCase().replace(/\W+/g, "") === str.replace(/\W+/g, "").split('').reverse().join('').toLowerCase();
  
}

isPalindrome("abcddcddba")