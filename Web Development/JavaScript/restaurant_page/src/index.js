import { loadhome } from "./home";
import { loadAbout } from "./about";
import { loadMenu } from "./menu";

function clearContent(){
    const content = document.getElementById("content");
    content.innerHTML="";
}
loadhome();
document.getElementById("Home").addEventListener("click",()=>{
    clearContent();
    loadhome();
});

document.getElementById("Menu").addEventListener("click",()=>{
    clearContent();
    loadMenu();
});
document.getElementById("About").addEventListener("click",()=>{
    clearContent();
    loadAbout();
});
