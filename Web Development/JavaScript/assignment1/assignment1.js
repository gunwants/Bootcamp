const library=[];

class Book {
    constructor(title, author, pages, isread) {
        this.id = crypto.randomUUID();
        this.title = title;
        this.author = author;
        this.pages = pages;
        this.isread = isread;
    }
    toggleRead() {
        this.isread = !this.isread;
    }
}
function addbook(title,author,pages,isread){
    const book=new Book(title,author,pages,isread)
    library.push(book);         
}

function handleAddBook(){
    const title = document.getElementById('title').value;
    const author= document.getElementById('author').value;
    const pages = document.getElementById('pages').value;
    const isread=document.getElementById('isread').checked;

    addbook(title,author,pages,isread);
    displaybooks();
}
function removebook(id){
    const index=library.findIndex(book => book.id === id);
    library.splice(index,1);
    displaybooks();
}
function toggleRead(id){
    const book = library.find(book => book.id===id);
    book.toggleRead();
    displaybooks();
}
function displaybooks(){
    const list=document.getElementById('book-list');
    list.innerHTML= '';

      myLibrary.forEach(book => {
    const div = document.createElement('div');
    div.innerHTML = `
      <strong>${book.title}</strong> by ${book.author}, ${book.pages} pages
      - ${book.isRead ? 'Read' : 'Not Read'}
      <button onclick="toggleRead('${book.id}')">Toggle Read</button>
      <button onclick="removeBook('${book.id}')">Remove</button>
    `;
    list.appendChild(div);
  });
}