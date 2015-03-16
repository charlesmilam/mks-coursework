function parseQueryString (url) {
    
  var strip = url.split("?")

  if(typeof strip[1] != 'undefined'){
    var URIvariables = strip[1]
    var variables = URIvariables.split("&")
    var output = []
    
    for(i = 0; i <= variables.length-1; i++){
        
      if(typeof(variables[i] != 'undefined')){
          var push = variables[i].split("=")
      }
      else{
        push = []
      }

      output.push([push[0], decodeURI(push[1])])
    }
    return output
  }
  else {
    return []
  }
}
