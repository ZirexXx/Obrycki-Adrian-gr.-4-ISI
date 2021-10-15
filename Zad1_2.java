import java.util.Arrays;
import java.util.Scanner;

public class Zad1_2 {
    public static void main(String[] args){
        Scanner scan_number = new Scanner(System.in);
        System.out.println("Podaj liczbe stanowiaca ilosc wartosci: ");
        int amount = scan_number.nextInt();
        double numbers[] = new double[amount];
        for(int i=0; i<amount; i++){
            System.out.println("Podaj wartosc: ");
            double a = scan_number.nextDouble();
            numbers[i] = a;
        }
        scan_number.close();
        double tmp[] = new double[amount];
        System.arraycopy(numbers, 1, tmp, 0,amount-1);
        tmp[amount-1] = numbers[0];
        numbers = null;
        System.out.println(Arrays.toString(tmp));
    }
}
