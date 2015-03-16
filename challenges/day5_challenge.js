function onlyUnique (str) {
  // Write your code here, and
  // return your final answer.
  uniques = str.split('')
  found = []
  console.log(uniques)
  for (var i = uniques.length - 1; i >= 0; i--) {
    console.log("i", i)

      chk = uniques[i]
      console.log("chk", chk)
      index = found.indexOf(chk)
      console.log("index", index)
      if (index === -1) {
        found.push(uniques[i])
      }
  }

    
 
  return found.join()
}

console.log(onlyUnique("abccdefe"))