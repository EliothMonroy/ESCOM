import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.LinkedList;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.logging.Level;
import java.util.logging.Logger;
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author andressaldana
 */
public class TestThreadPool{  
    
    //public void 
    
    public static void main(String[] args) {
        System.out.println("Enter webpage to download: ");
        InputStreamReader isr = new InputStreamReader(System.in);
        BufferedReader br = new BufferedReader (isr);
        String url = "";
        try {
            url = br.readLine();
        } catch (IOException ex) {}
        
        URLhandler u = new URLhandler(url,url);
        u.run();
        LinkedList<String> li = u.getQueue();

        ExecutorService executor = Executors.newFixedThreadPool(5);//creating a pool of 5 threads  
        for (int i = 0; i < 10; i++) {  
            URLhandler u1 = new URLhandler(li.get(i),url);
            executor.execute(u1);//calling execute method of ExecutorService
        }  
        executor.shutdown();  
        while (!executor.isTerminated()) {}    
        System.out.println("Finished all threads");

    }  
 }  

//https://www.djangoproject.com/
//https://www.heroku.com/
//https://sweetalert.js.org/guides/
