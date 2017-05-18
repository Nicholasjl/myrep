package com.company;
import java.math.BigInteger;
import java.util.*;
import java.util.Arrays;
import java.text.DecimalFormat;
import java.util.Comparator;
import static java.lang.Math.abs;
import static java.lang.Math.max;
import static java.util.Arrays.sort;
class MyComparator implements Comparator <Integer>{
    @Override
    public int compare(Integer o1, Integer o2){
        if(abs(o1)<abs(o2))
            return 1;
        if(abs(o1)>abs(o2))
            return -1;
        return 0;
    }
}

public class getBowlingScore {
    public static void main(String[] args) {

        int[] a=new int [50];

        Scanner in =new Scanner(System.in);
            int ma=0;
            String cc;
            while (in.hasNext()){
                cc=in.next();
                char[] c =cc.toCharArray();
                int n=1;
                a[0]=-1;
                for (int i=0;i<cc.length();i++){
                    if (c[i]=='X'||c[i]=='/')
                        a[n]=10;
                    else if (c[i]=='|')
                        a[n]=-1;
                    else if (c[i]=='-')
                        a[n]=0;
                    else
                        a[n]=c[i]-'0';
                    n++;
                }
                int sum=0;
                for (int i=1;a[i]!=-1||a[i+1]!=-1;i++){
                    if (a[i]==-1)
                        continue;
                    if (a[i]==10){
                        int k=0;
                        if (a[i-1]!=-1){
                            sum=sum+10-a[i-1];
                            k=1;
                        }
                        else {
                            sum+=10;
                            k=2;
                        }
                        for (int j=1;i+j<=n;j++){
                            if (k==0)
                                break;
                            if (a[i+j]!=-1){
                                sum+=a[i+j];
                                if (a[i+j]==10&&a[i+j-1]!=-1&&(a[i+2]!=-1||a[i+1]!=-1))
                                    sum-=a[i+j-1];
                                k--;
                            }
                        }
                    }
                    else
                        sum+=a[i];
                }
                ma=max(ma,sum);
                System.out.println(sum);
            }
            System.out.println(ma);



    }


}




//add+
//subtract-
//multiply*
//divide/
//remainder%
