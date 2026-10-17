export class Project {
    constructor(name){
        this.id=crypto.randomUUID();
        this.name=name;
        this.taskslist=[];
    }
    addTask(task){
        this.taskslist.push(task);
    }
    removeTask(taskId){
        this.taskslist=this.taskslist.filter(task=>task.id!==taskId);
    }
}