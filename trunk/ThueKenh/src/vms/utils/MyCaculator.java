/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package mylibararies.caculator;

import java.util.Stack;

/**
 *
 * @author slayer
 */
public class MyCaculator {
    //stack chua hau to

    private Stack m_S;//chua dau
    private Stack m_Q;//chua so

    public static void main(String[] args) {
        System.out.println( MyCaculator.cal(" 01 + 22 * 2 "));
    }
    
    public static String cal(String expression){
        MyCaculator c = new MyCaculator();
        expression=expression.replace(" ", "");
        return c.CalculatePostfix(expression);
    }

    private MyCaculator() {
        m_S = new Stack();
        m_Q = new Stack();
    }

    private int getUuTien(char c) {
        if (c == '+' || c == '-') {
            return 0;
        }
        if (c == '*' || c == '/') {
            return 1;
        }
        if (c == '(' || c == ')') {
            return 2;
        }
        return 100;
    }

    //ham tinh = chuoi cong thuc + - * /
    private void infixToPostfix(String _strExp) {
        for (int i = 0; i < _strExp.length(); i++) {
            //lay 1 ki tu x trong P
            char charAt = _strExp.charAt(i);

            //la ki tu so
            if (charAt >= '0' && charAt <= '9') {
                char temp=charAt;
                int iStart = i;
                while (((charAt >= '0' && charAt <= '9') || charAt == '.') && i < _strExp.length()) {
                    charAt = _strExp.charAt(i);
                    i++;
                }

                String strNumber = _strExp.substring(iStart, i > iStart ? i-1 : i);
                //System.out.println(strNumber);
                i=iStart;
                charAt=temp;
                m_Q.push(strNumber);
            }

            //la ki tu mo ngoac
            if (charAt == '(') {
                m_S.push(charAt);
                //System.out.println(charAt);
            }

            //la toan tu
            if (charAt == '+'
                    || charAt == '-'
                    || charAt == '*'
                    || charAt == '/') {
                while (!m_S.isEmpty() && (getUuTien((Character) m_S.lastElement()) >= getUuTien(charAt))) {
                    Object pop = m_S.pop();
                    if(pop.toString().charAt(0)!='(')
                        m_Q.push(pop);
                    else
                        break;
                }
                m_S.push(charAt);
            }

            //la dau )
            if (charAt == ')') {
                String sTemp = "";
                while (sTemp != "(" && !m_S.isEmpty()) {
                    sTemp = m_S.pop().toString();
                    if(sTemp.charAt(0)!='(')
                        m_Q.push(sTemp);
                }
                if (!m_S.isEmpty()) {
                    m_S.pop();
                }
            }

        }
        int c = 0;
//        for(int i=0;i<m_Q.size();i++) {
//            String firstElement = m_Q.get(i).toString();
//            System.out.print(firstElement);
//                    
//        }
    }

    private String CalculatePostfix(String _strExp) {
        _strExp="("+_strExp+")";
        infixToPostfix(_strExp);
        for(int i=0;i<m_Q.size();i++) {
            String firstElement = m_Q.get(i).toString();
            char charAt = firstElement.charAt(0);
            //la so
            if (Character.isDigit(charAt)) {
                m_S.push(firstElement);
            }
            
            if (charAt == '+'
                    || charAt == '-'
                    || charAt == '*'
                    || charAt == '/') 
            { //la toan tu
                Object pop1 = m_S.pop();
                Object pop2 = m_S.pop();
                double v1 = Double.parseDouble(pop1.toString());
                double v2 = Double.parseDouble(pop2.toString());
                double kq = PhepTinh(v1, v2, firstElement.charAt(0));
                m_S.push(kq);
            }

        }
        return m_S.pop().toString();
    }

    private double PhepTinh(double v1, double v2, char c) {
        //System.out.print(String.valueOf(v1));
        //System.out.print(String.valueOf(c));
        //System.out.println(String.valueOf(v2));
        switch (c) {
            case '+':
                return v2 + v1;
            case '-':
                return v2 - v1;
            case '*':
                return v2 * v1;
            case '/':
                return v2 / v1;
        }
        return 0;
    }
}
