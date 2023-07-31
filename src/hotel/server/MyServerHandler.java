package hotel.server;

import hotel.vo.User;
import hotel.vo.User.User_signal;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;
import java.util.ArrayList;
import java.util.concurrent.ConcurrentHashMap;

public class MyServerHandler implements Runnable {
	
	private ObjectInputStream ois;
	private ObjectOutputStream oos;
	private Socket soc;
	private static ConcurrentHashMap<String, MyServerHandler> client = new ConcurrentHashMap<String, MyServerHandler>();
	
	public MyServerHandler(Socket soc){
		this.soc=soc;
		try {
			oos = new ObjectOutputStream(soc.getOutputStream());
			ois = new ObjectInputStream(soc.getInputStream());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void run() {
		while(true){
			try {
				Object o = ois.readObject();
				if(o instanceof User){
					switch(((User) o).getSignal()){
						case loginCheck : loginCheck((User)o);
							return;
					}
				}
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
	}

	private void loginCheck(User u) {
		for(String user :client.keySet()){
			if(user.equals(u.getId())){
				try {
					oos.writeObject(false);
					oos.reset();
				} catch (IOException e) {
					e.printStackTrace();
				}
				return;
			}
		}
		client.put(u.getId(), this);
		try {
			oos.writeObject(true);
			oos.reset();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
	
