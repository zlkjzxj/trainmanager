package com.zlkj.trainmanager.bean;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Created by Jonsy
 * id   label   path        level order
 * 1    水果      0           1   1
 * 2    苹果      0,1         2   1
 * 3    梨子      0,1         2   2
 * 4    雪梨      0,1,3       3   1
 * 5    鸭梨      0,1,3       3   2
 */
public class TreeModel {

    private String menuid; //菜单id

    private String menuname;//	菜单名称

    private String path="0";  //父节点的路径与父节点的id路径，用","分开，0表示父节点是根节点

    private String menuorder;   //菜单顺序

    private int type;//扩展字段。菜单类型，供不同业务区分

    private String style;//样式，方便ui展现

    private String menuparent;  //父菜单
    /** 状态 是否禁用*/
    private String menuenable;  //菜单是否可用

    private String menuurl	;     //菜单链接

    private List<? extends TreeModel> childNodes=new ArrayList<>();

    public String getMenuurl() {
        return menuurl;
    }

    public void setMenuurl(String menuurl) {
        this.menuurl = menuurl;
    }


    public String getMenuparent() {
        return menuparent;
    }

    public void setMenuparent(String menuparent) {
        this.menuparent = menuparent;
    }

    public String getMenuid() {
        return menuid;
    }

    public void setMenuid(String menuid) {
        this.menuid = menuid;
    }

    public String getMenuname() {
        return menuname;
    }

    public void setMenuname(String menuname) {
        this.menuname = menuname;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public int getLevel() {
        if(path==null){
            return 1;
        }
        return path.split(",").length;
    }

    public String getMenuorder() {
        return menuorder;
    }

    public void setMenuorder(String menuorder) {
        this.menuorder = menuorder;
    }

    public boolean isDisabled() {
        return "0".equals(menuenable)?true:false;
    }

    public void setMenuenable(String  menuenable) {
        this.menuenable = menuenable;
    }

    public String getStyle() {
        return style;
    }

    public void setStyle(String style) {
        this.style = style;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public TreeModel newChildNode(String nodeId, String label,String order){
        TreeModel node=new TreeModel();
        node.path =this.path +","+this.menuid;
        node.menuid=nodeId;
        node.menuorder=order;
        node.menuname=label;
        return node;
    }

    public List<? extends TreeModel> getChildNodes() {
        return childNodes;
    }

    @Override
    public String toString() {
        return menuname+"-"+ path +"-"+menuid+"-"+menuorder;
    }

    /***
     * 以level==1的节点作为开始节点构建树结构
     * @param nodes
     * @return
     */
    public static List<? extends TreeModel> buildTree(List<? extends TreeModel> nodes){
        if (isEmpty(nodes)){
            return null;
        }
        //List<? extends TreeModel> firstLevels=nodes.stream().filter(node->!node.isDisabled() && node.getLevel()==1).collect(Collectors.toList());
        List<? extends TreeModel> firstLevels=nodes.stream().filter(node->"#".equals(node.getMenuparent())).collect(Collectors.toList());
        sortByOrder(firstLevels);
        //System.out.println("父菜单为#的列表===="+firstLevels);
        firstLevels.stream().forEach(node-> setChildren(node,nodes));
        return firstLevels;
    }


    private static  void setChildren(TreeModel currentNode, List<? extends TreeModel> nodeList){
        //List<? extends TreeModel> childrens=nodeList.stream().filter(node->(!node.isDisabled() && node.getPath().equals(currentNode.getPath()+","+currentNode.getMenuid()))).collect(Collectors.toList());
        List<? extends TreeModel> childrens = nodeList.stream().filter(node->(node.isDisabled() && node.getMenuparent().equals(currentNode.getMenuid()))).collect(Collectors.toList());
        currentNode.childNodes=childrens;
        //System.out.println("父菜单=="+currentNode.getMenuname()+"===========子菜单====="+childrens);
        if (isEmpty(childrens)){
            return;
        }
        sortByOrder(childrens);
        childrens.stream().forEach(node-> setChildren(node,nodeList));

    }

    private static void sortByOrder(List<? extends TreeModel> firstLevels) {
        firstLevels.sort((node1,node2)->Integer.valueOf(node1.getMenuorder()).compareTo(Integer.valueOf(node2.getMenuorder())));
    }


    /***
     * 按数结构给节点排序
     * @param nodes
     */
    public static void sortByTree(List<? extends TreeModel> nodes) {
        if(isEmpty(nodes)){
            return;
        }
        sortByOrder(nodes);
        nodes.sort((o1, o2) -> (o1.getPath()+","+o1.getMenuid()).compareTo(o2.getPath()+","+o2.getMenuid()));
    }

    private static boolean isEmpty(List nodes) {
        return nodes == null || nodes.isEmpty();
    }


    //按节点的父子层次顺序展示
    private static void printTreeToConsole(List<TreeModel> nodes){
        if (isEmpty(nodes)){
            return;
        }

        sortByTree(nodes);

        nodes.stream().forEach(node->{
            if(node.isDisabled()){
                return;
            }
            for(int i=1;i<node.getLevel();i++){
                System.out.print("\t");
            }
            System.out.println(node);
        });
    }


    //以第一层为起点，递归方式展示父子层次树
    private static void printFirstLevelTreeToConsole(List<? extends TreeModel> nodes){
        if (isEmpty(nodes)){
            return;
        }
        nodes.forEach(item->{
            if(item.isDisabled()){
                return;
            }
            for(int i=1;i<item.getLevel();i++){
                System.out.print("\t");
            }
            System.out.println(item);

            printFirstLevelTreeToConsole(item.getChildNodes());
        });
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TreeModel treeModel = (TreeModel) o;

        return menuid != null ? menuid.equals(treeModel.menuid) : treeModel.menuid == null;

    }

    @Override
    public int hashCode() {
        return menuid != null ? menuid.hashCode() : 0;
    }

    public static void main(String[] arg){
        List<TreeModel> nodes=new ArrayList<>();
        TreeModel fruit=new TreeModel();
        fruit.setMenuid("1");
        fruit.setMenuname("水果");
        fruit.setMenuorder("2");
        nodes.add(fruit);

        TreeModel apple=fruit.newChildNode("7","苹果","2");
        nodes.add(apple);
        nodes.add(apple.newChildNode("4","红富士","2"));
        nodes.add(apple.newChildNode("15","山东苹果","1"));

        TreeModel lizi=fruit.newChildNode("e8","梨子","1");
        nodes.add(lizi);
        nodes.add(lizi.newChildNode("7r7","雪梨","1"));
        nodes.add(lizi.newChildNode("t31o","鸭梨","2"));

        TreeModel shucai=new TreeModel();
        shucai.setMenuid("a101");
        shucai.setMenuname("蔬菜");
        shucai.setMenuorder("1");
        shucai.setMenuenable("0");
         nodes.add(shucai);
        nodes.add(shucai.newChildNode("213","白菜","2"));
        printTreeToConsole(nodes);

        System.out.println("====================");
        List<? extends TreeModel> tree=TreeModel.buildTree(nodes);
        printFirstLevelTreeToConsole(tree);
    }
}
