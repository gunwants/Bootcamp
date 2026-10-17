export function loadAbout(){
    const content = document.getElementById("content");
    const tabDiv = document.createElement("div");
    tabDiv.classList.add("tab-content");
    const title=document.createElement("h1");
    title.textContent="Contact & Location";
    const address =document.createElement("p");
    address.textContent="Jaipur";
    const phone=document.createElement("p");
    phone.textContent="987654321";
    
    tabDiv.appendChild(title);
    tabDiv.appendChild(address);
    tabDiv.appendChild(phone);

    content.appendChild(tabDiv);

}