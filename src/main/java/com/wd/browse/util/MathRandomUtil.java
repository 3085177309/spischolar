package com.wd.browse.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

/**
 * 根据概率生成随机数
 * @author Administrator
 *
 */
public class MathRandomUtil {
	
	//最小值  
    private static int MINVALUE = 1;  
    /** 
     * 这里为了避免某一个值占用大量资金，我们需要设定非最后一个值的最大金额，我们把他设置为金额平均值的N倍； 
     */  
    private static int TIMES = 30;  
  
    /** 
     * 判断是否合情理 
     * @param money 
     * @param count 
     * @return 
     */  
    public static boolean isRight(float money,int count) {
        float avg = money/count;  
      /*  if(avg < MINVALUE) {  
            return false;  
        } else if(avg > MAXVALUE) {  
            return false;  
        }  */
        MINVALUE = (int) avg/2;
        TIMES = (int) avg * 2;
        return true;  
    }  
  
    /** 
     * 核心算法 
     */  
    public static int randomRedPacket(int money,int minS,int maxS,int count) {  
        //当人数剩余一个值时，把当前剩余全部返回  
        if(count == 1) {  
            return money;  
        }  
        //如果当前最小值等于最大值，之间返回当前值  
        if(minS == maxS) {  
            return minS;  
        }  
        int max = maxS>money?money:maxS;  
        //随机产生一个值  
        int one = (int)(Math.random()*(max-minS)+minS);  
        int balance = money - one;  
        //判断此次分配后，后续是否合理  
        if(isRight(balance,count-1)) {  
            return one;  
        } else {  
            //重新分配  
            float avg = balance/(count-1);  
            //如果本次值过大，导致下次不够分，走这一条  
            if(avg < MINVALUE) {  
                return randomRedPacket(money, minS, one, count);  
            } else {  
                return randomRedPacket(money, one, maxS, count);  
            }  
        }  
    }  
  
    /** 
     * 将money分成count份
     */  
    public static List<Integer> spiltRedPackets(int money,int count) {
    	 List<Integer> list = new ArrayList<Integer>();  
    	if(count == 1) {
    		list.add(money);
    		return list;  
    	}
        //首先判断是否合情理  
        if(!isRight(money,count)) {
            return null;  
        }
       
        int max = TIMES;  
        max = max>money?money:max;  
        for(int i = 0 ; i < count; i++) {
        	int value = randomRedPacket(money,MINVALUE,max,count-i);  
            list.add(value);  
            money -= value;  
        }
        return list;  
    }

	/**
	 * 传入一个和为1的double数组，随机0~length的值，每个值的概率为double[i]
	 * @return int 
	 */
	public static int percentageRandom(double[] rate) {
		double randomNumber;
		randomNumber = Math.random();
		double min =0;
		double max =0;
		for(int i=0;i<rate.length;i++) {
			if(i>0) {
				min += rate[i-1];
			}
			max +=  rate[i];
			if(randomNumber >= min && randomNumber <= max) {
				return i;
			}
		}
		return -1;
	}
	/**
	 * 根据String获取概率（String为：1,2,3,0,4）
	 * @return int 
	 */
	public static int percentageRandomByString(String ratio) {
		String[] ratios = ratio.split(",");
		double[] rate=new double[ratios.length];
		for(int i=0;i<ratios.length;i++) {
			rate[i]=Double.valueOf(ratios[i])*0.01;
		}
		return percentageRandom(rate);
	}
	/**
	 * 根据访问随机
	 * @param max
	 * @param min
	 * @return
	 */
	public static int randomRange(int max,int min) {
        Random random = new Random();
        int s = random.nextInt(max)%(max-min+1) + min;
       	return s;
	}
	
	public static void main(String[] args) {
		List<Integer> list = spiltRedPackets(200,30);
		System.out.print(list);
	}
	
}
