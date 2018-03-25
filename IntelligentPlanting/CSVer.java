import java.util.Scanner;
import java.io.File;
public class CSVer {
	public static void main(String[] args){
		String[] states = new String[]{"Alabama","Alaska","Arizona"
,	"Arkansas"
,	"California"
,	"Colorado"
,	"Connecticut"
,	"Delaware"
,	"Florida"
,	"Georgia"
,	"Hawaii"
,	"Idaho"
,	"Illinois"
,	"Indiana"
,	"Iowa"
,	"Kansas"
,	"Kentucky"
,	"Louisiana"
,	"Maine"
,	"Maryland"
,	"Massachusetts"
,	"Michigan"
,	"Minnesota"
,	"Mississippi"
,	"Missouri"
,	"Montana"
,	"Nebraska"
,	"Nevada"
,	"New Hampshire"
,	"New Jersey"
,	"New Mexico"
,	"New York"
,	"North Carolina"
,	"North Dakota"
,	"Ohio"
,	"Oklahoma"
,	"Oregon"
,	"Pennsylvania"
,	"Rhode Island"
,	"South Carolina"
,	"South Dakota"
,	"Tennessee"
,	"Texas"
,	"Utah"
,	"Vermont"
,	"Virginia"
,	"Washington"
,	"West Virginia"
,	"Wisconsin"
,	"Wyoming"};
		try{
			File f = new File("USDA_PLANTS.csv");
			Scanner csv = new Scanner(f);
			System.out.println("{");
			while(csv.hasNextLine()){
				String line = csv.nextLine();
				String[] pcs = line.split(",");
				String state = pcs[0];
				String name = pcs[1];
				System.out.println("\t\""+state+"\": [");
				while(pcs[0].equals(state)){
					System.out.println("\t\t{");
					System.out.println("\t\t\t\"Name\": \""+name+"\"");
					System.out.println("\t\t},");
					if(csv.hasNextLine()){
						line = csv.nextLine();
						pcs = line.split(",");
						name = pcs[1];
					} else {
						break;
					}
				}

				System.out.println("\t]");
			}
			System.out.println("}");
		} catch(Exception e){
			e.printStackTrace();
		}
	}
}