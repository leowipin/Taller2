import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Calendar;
import com.bank.*;

public aspect Log {
	static String file = "recursos/datos.txt";
    Calendar cal = Calendar.getInstance();
    pointcut Transaccion() : call(* Bank.money*(..));
    
    after(): Transaccion() {
    	if (Bank.tipotransaccion.equals("2")) {
        	System.out.print("Depósito"+" , "+cal.getTime().toString());
        	try {
        		registrarArchivo("Depósito"+" , "+cal.getTime().toString());
    		} catch (IOException e) {
    			e.printStackTrace();
    		}	
    	}else if(Bank.tipotransaccion.equals("3")) {
    	 	System.out.print("Retiro"+" , "+cal.getTime().toString());
        	try {
        		registrarArchivo("Retiro"+" , "+cal.getTime().toString());
    		} catch (IOException e) {
    			e.printStackTrace();
    		}
    	}
    	
    }
    	
    public static void registrarArchivo(String dato) throws IOException{
    	
	    try(BufferedWriter bw = new BufferedWriter (new FileWriter(file,true) ) ) {
	    	bw.write(dato);
	    	bw.newLine();	
	    }
    	
    }
}