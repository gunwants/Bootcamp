export class Task {
    constructor(Title,DueDate,Priority){
        this.id=crypto.randomUUID();
        this.Title = Title;        
        this.DueDate = DueDate;
        this.Priority = Priority;
        this.completed=false;
    }
    togglecompleted(){
        this.completed=!this.completed;
    }
}