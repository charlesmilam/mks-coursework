function toMilitary (time) {
   if (time.charAt(time.length-2) == "a") {
       time = time.split(":");
       if (parseInt(time[0]) < 10) {
           time[0] = "0" + time[0]
       }
       if (time[0] == "12"){
           time[0] = "00"
       }
       return time[0] + ":" + time[1].slice(0, 2);
   } else if (time.charAt(time.length-2) == "p") {
       time = time.split(":");
       if (time[0] == "12" && time[1] == "00pm") {
           return "12:00"
       }
       time[0] = String(parseInt(time[0]) + 12)
       return time[0] + ":" + time[1].slice(0, 2);  
   } else {
       return time
 }
}

console.log(toMilitary("12:00pm"))