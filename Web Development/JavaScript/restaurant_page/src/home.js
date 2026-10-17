export function loadhome(){
    const content= document.getElementById('content');
    const tabDiv=document.createElement("div");
    tabDiv.classList.add("tab-content");
    const title=document.createElement("h1");
    title.textContent="Gunwant's cafe";
    const review=document.createElement("p");
    review.textContent="best in class food is served here";
    const hoursHeading=document.createElement("h2")
    hoursHeading.textContent="Hours";
    const hours=document.createElement("p");
    hours.textContent="Mon-Fri: 6am-6pm | Sat-Sun:8am-10pm";
    tabDiv.appendChild(title);
    tabDiv.appendChild(review);
    tabDiv.appendChild(hoursHeading);
    tabDiv.appendChild(hours);

    content.appendChild(tabDiv);
}