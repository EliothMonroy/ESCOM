
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.LinkedList;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author andressaldana
 */
public class URLhandler extends Thread{
    
    String path,parent;
    LinkedList<String> li;
    String rootFolder = "Users/andressaldana/Documents/Github/Net-Applications/URL_constructor/";
    int counter;
    
    public URLhandler(String path,String parent){
            this.path = path;
            this.parent = parent;
            li = new LinkedList();
            counter = 10;
    }
     
    public void getPage(){
        URL url;
        //for the entrant url
        InputStream is = null;
        BufferedReader br;
        //line is the current line that is being readed
        String line;
        //this stores the dependencies ofr


        try {
            url = new URL(path);
            
            BufferedWriter writer = new BufferedWriter(new FileWriter(mknewIndex(path), true));  
            is = url.openStream(); 
            br = new BufferedReader(new InputStreamReader(is));

            while ((line = br.readLine()) != null) {
                
                if(line.contains("<a")){
                    if(counter > 0){
                        line = handleLink(line);
                        counter--;
                    }
                }
                if(line.contains("<link")){
                    if(handleCSS_JS(line) != ""){
                        line = handleCSS_JS(line);
                    }                    
                }
                if(line.contains("<script")){
                    if(handleCSS_JS(line) != ""){
                        line = handleCSS_JS(line);
                    }
                }
                writer.append(line+"\n");            
            }
            writer.close();

        } catch (MalformedURLException mue) {
           mue.printStackTrace();
        } catch (IOException ioe) {
           ioe.printStackTrace();
        } finally {
            try {
                if (is != null) is.close();
            } catch (IOException ioe) {
                // nothing to see here
            }
        }
    }
    
    public String handleLink(String link){
        String [] aux = link.split("\"");
        String newLink = "";
        for(int i = 0 ; i<aux.length ; i++){
            if(aux[i].contains("href")){           
                //discriminates the hashtags
                if(aux[i+1].contains("#")){}
                else if(aux[i+1].charAt(0) == '/'){}
                //links to other page
                else if(aux[i+1].contains("https://")){
                    //adding the page
                    li.add(aux[i+1]);

                    newLink = constructNewLink(aux[i + 1]);
                    newLink = link.replaceAll(aux[i+1], newLink);
                    //System.out.println(newLink);
                }
            }
        }  
        return newLink;
    }
    
    public String handleCSS_JS(String link){
        String newLink = "";
        if(link.contains(".css") && !link.contains("https")){ 
            InputStream is = null;
            BufferedReader br;
            String line;
            
            String [] aux = link.split("\"");
            for(int i = 0 ; i<aux.length ; i++){
                if(aux[i].contains("href")){ 
                    try{
                    //creates the new link
                    newLink = link.replaceAll(aux[i + 1], constructCSS_JSlink(aux[i + 1]));
                    //this has the download link
                    String newPath = parent.substring(0,parent.length()-1)+aux[i+1];
                       
                    
                    URL url = new URL(newPath);  
                    is = url.openStream();  
                    br = new BufferedReader(new InputStreamReader(is));

                    BufferedWriter writer = new BufferedWriter(new FileWriter(handleCreateFile(newPath), true));

                    while ((line = br.readLine()) != null) {         
                        writer.append(line+"\n");
                    }
                    writer.close();

                    } catch (MalformedURLException mue) {
                         mue.printStackTrace();
                    } catch (IOException ioe) {
                         ioe.printStackTrace();
                    } finally {
                        try {
                            if (is != null) is.close();
                        } catch (IOException ioe) {
                            // nothing to see here
                        }
                    }      
                }//href
            }
            
        }
        
        if(link.contains(".js") && !link.contains("https")){ 
            InputStream is = null;
            BufferedReader br;
            String line;
            
            String [] aux = link.split("\"");
            for(int i = 0 ; i<aux.length ; i++){
                if(aux[i].contains("src")){ 
                    try{
                    //creates the new link
                    newLink = link.replaceAll(aux[i + 1], constructCSS_JSlink(aux[i + 1]));
                    //this has the download link
                    String newPath = parent.substring(0,parent.length()-1)+aux[i+1];
                       
                    
                    URL url = new URL(newPath);  
                    is = url.openStream();  
                    br = new BufferedReader(new InputStreamReader(is));

                    BufferedWriter writer = new BufferedWriter(new FileWriter(handleCreateFile(newPath), true));

                    while ((line = br.readLine()) != null) {         
                        writer.append(line+"\n");
                    }
                    writer.close();

                    } catch (MalformedURLException mue) {
                         mue.printStackTrace();
                    } catch (IOException ioe) {
                         ioe.printStackTrace();
                    } finally {
                        try {
                            if (is != null) is.close();
                        } catch (IOException ioe) {
                            // nothing to see here
                        }
                    }      
                }//href
            }
            
        }
        System.out.println(newLink);
        return newLink;
    }
    
    public String constructCSS_JSlink(String link){
        link = "/"+rootFolder+parent.replaceAll("https://", "")+link.substring(1, link.length());
        return link;
    }
    
    public String constructNewLink(String link){
        String newLink = "";
        //handling reference, when is the main index        
        if(parent.equals(path)){
            newLink = "/"+rootFolder+link.replaceAll("https://", "")+"/index.html";                                      
        }
        else{
            newLink = "/"+rootFolder+link.replaceAll("https://", "")+"/index.html";
        }
        return newLink;
    }
    
    public String mknewDir(String dir){       
        dir = dir.replaceAll("https://","");
        if(dir.charAt(dir.length()-1)!='/'){
            dir+="/";
        }
        new File("/Users/andressaldana/Documents/Github/Net-Applications/URL_constructor/"+dir).mkdirs();
        return dir;
    }
    
    public String handleCreateFile(String link){
        String aux = link.substring(0,link.lastIndexOf("/")+1);
        mknewDir(aux);
        link = link.replaceAll("https://","");
        File file = new File(link);
        try {
            file.createNewFile();
        } catch (IOException ex) {
            System.err.println("Problem on creating archive");
        }
        return link;
    }
    //creates new directory with html index
    public String mknewIndex(String dir){       
        String aux = mknewDir(dir)+"index.html";
        File file = new File(aux);
        try {
            file.createNewFile();
        } catch (IOException ex) {
            System.err.println("Problem on creating archive");
        }
        return aux;
    }
    
    
    public LinkedList<String> getQueue(){
        return this.li;
    }
    
    public void run(){
        getPage();
    }
    
    public static void main(String[] args) {
        URLhandler u = new URLhandler("https://www.djangoproject.com/","https://www.djangoproject.com/");
        u.getPage();
        LinkedList<String> li = u.getQueue();
        for(int i = 0; i < 4; i++){
            URLhandler uaux = new URLhandler(li.get(i),"https://www.djangoproject.com/");
            uaux.getPage();
        }
    }
}
