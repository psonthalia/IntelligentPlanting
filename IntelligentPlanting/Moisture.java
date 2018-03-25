import java.util.Scanner;
import java.io.File;
public class Moisture {
	public static void main(String[] args){
		try{
			File f = new File("USDA_MOISTURE.csv");
			Scanner csv = new Scanner(f);
			System.out.println("{");
			while(csv.hasNextLine()){
				String line = csv.nextLine();
				String[] pcs = line.split(",");
				String plant = pcs[0];
				String moist = pcs[1];
				System.out.println("\t\""+plant+"\": [");
				System.out.println("\t\t{");
				System.out.println("\t\t\t\"Moisture\": \""+moist+"\"");
				System.out.println("\t\t}");
				System.out.print("\t]");
				if(csv.hasNextLine()){
					System.out.println(",");
				} else {
					System.out.println();
				}
			}
			System.out.println("}");
		} catch(Exception e){
			e.printStackTrace();
		}
	}
}