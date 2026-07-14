package DataStructures;
public class BST {
    class node{
        int val;
        node left;
        node right;
        public node(int v){
         this.val=v;
         this.left=null;
         this.right=null;
        }
    }

    private node root;

    public node insert(int val){
        root = recinsert(root, val);
        return root;
    }

    public node recinsert(node root,int val){
        if(root==null){
            return new node(val);
        }
        else{
            if(val<=root.val){
                root.left = recinsert(root.left, val);
            }
            else{
                root.right = recinsert(root.right, val);
            }
            return root;
        }
    }
    public void inOrder(node root) {
        if (root == null) return;
        inOrder(root.left);
        System.out.print(root.val + " ");
        inOrder(root.right);
    }
    public void preOrder(node root) {
        if (root == null) return;
        System.out.print(root.val + " ");
        preOrder(root.left);
        preOrder(root.right);
    }
    public void postOrder(node root) {
        if (root == null) return;
        postOrder(root.left);
        postOrder(root.right);
        System.out.print(root.val + " ");
    }
    
    public static void main(String args[]){
        BST binarytree = new BST();
        binarytree.insert(34);
        binarytree.insert(55);
        binarytree.insert(99);
        binarytree.insert(101);
        System.out.println("\npost order");
        binarytree.postOrder(binarytree.root);
        System.out.println("\npre order");
        binarytree.preOrder(binarytree.root);
        System.out.println("\nin order");
        binarytree.inOrder(binarytree.root);
    }

}
