package hotel.server;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.concurrent.ConcurrentHashMap;

public class MyServerSocket {
	
	private ServerSocket svsoc;
	private final int PORT=8880;
	
	public MyServerSocket() {
		try {
			svsoc = new ServerSocket(PORT);
		} catch (IOException e) {
			e.printStackTrace();
		}
		System.out.println("클라이언트 접속대기중...");
		while(true){
			try {
				Socket soc = svsoc.accept();
				MyServerHandler msh = new MyServerHandler(soc);
				Thread th = new Thread(msh);
				th.start();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void main(String[] args) {
		new MyServerSocket();
	}
}
