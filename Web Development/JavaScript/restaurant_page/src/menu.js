export function loadMenu(){
    const content = document.getElementById("content");
    const tabDiv =document.createElement("div");
    tabDiv.classList.add("tab-content");
    const title = document.createElement("h1");
    title.textContent="Menu";
    const item1=document.createElement("h3");
    item1.textContent="Coffee - 10rs";
    const item2=document.createElement("h3");
    item2.textContent="Tea - 5 rs";

    tabDiv.appendChild(title);
    tabDiv.appendChild(item1);
    tabDiv.appendChild(item2);
    content.appendChild(tabDiv);
}