function startTime() {

    // Get current date
    var currentDate = new Date();

    // Set some date in the future. In this case, June 21st Launch date.
    var futureDate  = new Date('2015-06-21T20:00:00Z');

    // Calculate the difference in seconds between the future and current date
    var diff = futureDate.getTime() / 1000 - currentDate.getTime() / 1000;
    console.log(diff);
    console.log(diff/60/60);

    var today=new Date();


    var h=diff / 60 / 60;
    var m=diff / 60;
    var s=diff;

// days is just hours divided by 24 with a floor
    d = Math.floor(h / 24);
    h = Math.floor(checkTime(h))%24;
    m = Math.floor(checkTime(m))%60;
    s = Math.floor(checkTime(s))%60;

    // document.getElementById('txt').innerHTML = h+":"+m+":"+s;
    document.getElementById('days').innerHTML = d;
    document.getElementById('hours').innerHTML = h;
    document.getElementById('minutes').innerHTML = m;
    document.getElementById('seconds').innerHTML = s;

    var t = setTimeout(function(){startTime()},1000);


}

function checkTime(i) {
    if (i<10) {i = "0" + i};  // add zero in front of numbers < 10
    return i;
    console.log(i);
}


// floor for amount of days
// model of days for what's left. 










// THINK THROUGH
// Get seconds remaining. 
