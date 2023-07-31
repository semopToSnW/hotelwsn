package hotel.client;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;

public class ClientSocket implements Runnable {
	
	private Socket soc;
	private ObjectOutputStream oos;
	private ObjectInputStream ois;
	
	public ClientSocket(){
		try {
			soc= new Socket("203.233.196.192", 8880);
			oos = new ObjectOutputStream(soc.getOutputStream());
			ois= new ObjectInputStream(soc.getInputStream());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void send(Object o){
		try {
			oos.writeObject(o);
			oos.reset();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void close(){
		try {
			ois.close();
			oos.close();
			soc.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public Object take() {
		Object o=null;
		try {
			 o = ois.readObject();
		} catch (ClassNotFoundException | IOException e) {
			e.printStackTrace();
		}
		return o;
	}

	@Override
	public void run() {
		while(true){
			
			
		}
	}
}
