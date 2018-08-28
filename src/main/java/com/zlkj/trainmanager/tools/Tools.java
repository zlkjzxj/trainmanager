package com.zlkj.trainmanager.tools;


import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Tools {

    public static String replaceNull(Object mesg) {
        if (mesg == null || mesg == "" || mesg.equals("")
                || ("" + mesg).equals("null") || mesg == null) {
            return "";
        } else {
            return mesg.toString();
        }
    }

    public static String getIp(HttpServletRequest req) {
        String ip_for = req.getHeader(" x-forwarded-for ");
        String ip_client = req.getHeader(" http_client_ip ");
        String un = " unknown ";

        if (ip_for != null && !ip_for.equalsIgnoreCase(un)
                && ip_for.trim().length() > 0) {
            return ip_for;
        } else if (ip_client != null && !ip_client.equalsIgnoreCase(un)
                && ip_client.trim().length() > 0) {
            return ip_client;
        } else {
            return req.getRemoteAddr();
        }
    }

    public static boolean checkNotNullOrEmpty(String arg) {
        if (null != arg && !"".equals(arg.trim()) && arg.trim().length() != 0) {
            return true;
        }
        return false;
    }

    public static boolean notEmpty(String s) {
        return s != null && !"".equals(s) && !"null".equals(s);
    }

    public static boolean isEmpty(String s) {
        return s == null || "".equals(s) || "null".equals(s);
    }

    public static String formatDate(Date date) {
        if (date != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            return sdf.format(date);
        } else
            return "";
    }

    public static String transNullOrZero(Object obj) {
        String temp = "";
        if (obj instanceof Integer) {
            if (!obj.equals(0)) {
                temp = obj.toString();
            }
        }
        if (obj instanceof String) {
            if (obj != null) {
                temp = obj.toString();
            }
        }
        return temp;
    }

    public static String formatNull(String str) {
        if (str == null || str.equals("")) {
            return str = "--";
        } else {
            return str;
        }
    }

    public static String getException(Throwable e) {
        String excString = "";
        if (e == null) {
            excString = "空的异常对象";
        } else {
            if (e.getCause() != null) {
                excString = handleSpecialStr(e.getCause().getLocalizedMessage()
                        .replaceAll("\n", ""));
            } else {
                excString = handleSpecialStr(e.toString().replaceAll("\n", ""));
            }
        }
        return excString;
    }

    public static String getException(String errMsg) {
        String excString = "";
        excString = handleSpecialStr(errMsg.replaceAll("\n", ""));
        return excString;
    }

    public static String handleSpecialStr(String str) {

        if (null == str || 0 == str.length()) {
            return "";
        }
        String hSymbol = "!\"#$%&'()*+,./:;<=>?@[\\]^_`{|}-~";
        String zSymbol = "！”＃＄％＆’（）＊＋，．／：；＜＝＞？＠［￥］＾＿‘｛｜｝－～";
        String tmp = str;
        for (int i = 0; i < hSymbol.length(); i++) {
            tmp = tmp.replace(hSymbol.charAt(i), zSymbol.charAt(i));
        }
        StringBuffer sb = new StringBuffer(tmp);
        return sb.toString();
    }

    public static String formatDate2(Date date) {
        if (date == null)
            return "";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(date);
    }

    public static String handleGlbm(String glbm, String bmjb) {
        if ("2".equals(bmjb))
            return glbm.substring(0, 2);
        else if ("3".equals(bmjb))
            return glbm.substring(0, 4);
        else if ("4".equals(bmjb))
            return glbm.substring(0, 6);
        // else if("4".equals(bmjb))return glbm.substring(0,2);
        return glbm;
    }

    /**
     * @param result
     * @return
     */
    public static String transResult(int result) {
        if (1 == result)
            return "成功";
        return "失败";
    }

    public static String transScript(String script) {
        StringBuffer sb = new StringBuffer();
        sb.append("<script>");
        sb.append(script);
        sb.append("</script>");
        return sb.toString();
    }

    /**
     * 把16进制字符串转换成字节数组
     *
     * @param hex
     * @return
     */
    public static byte[] hexStringToByte(String hex) {
        int len = (hex.length() / 2);
        byte[] result = new byte[len];
        char[] achar = hex.toCharArray();
        for (int i = 0; i < len; i++) {
            int pos = i * 2;
            result[i] = (byte) (toByte(achar[pos]) << 4 | toByte(achar[pos + 1]));
        }
        return result;
    }

    public static byte[] imageToByte(BufferedImage bi, String format)
            throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write(bi, format, baos);
        return baos.toByteArray();
    }

    private static byte toByte(char c) {
        byte b = (byte) "0123456789ABCDEF".indexOf(c);
        return b;
    }

    /** */
    /**
     * 把字节数组转换成16进制字符串
     *
     * @param bArray
     * @return
     */
    public static final String bytesToHexString(byte[] bArray) {
        StringBuffer sb = new StringBuffer(bArray.length);
        String sTemp;
        for (int i = 0; i < bArray.length; i++) {
            sTemp = Integer.toHexString(0xFF & bArray[i]);
            if (sTemp.length() < 2)
                sb.append(0);
            sb.append(sTemp.toUpperCase());
        }
        return sb.toString();
    }

    public static String unicodeToString(String str) {
        if (str != null && !str.equals("")) {
            Pattern pattern = Pattern.compile("(\\\\u(\\p{XDigit}{4}))");
            Matcher matcher = pattern.matcher(str);
            char ch;
            while (matcher.find()) {
                ch = (char) Integer.parseInt(matcher.group(2), 16);
                str = str.replace(matcher.group(1), ch + "");
            }
            return str;
        } else {
            return null;
        }
    }

    /**
     * invokeGetterMethod
     * 李享亮 2014-4-11
     * 修改者名字 修改日期
     * 修改内容
     *
     * @param @param  obj
     * @param @param  attribute
     * @param @return
     * @param @throws Exception
     * @return String
     * @throws
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    private static String invokeGetterMethod(Object obj, String attribute)
            throws Exception {
        Class clazz = obj.getClass();
        Object t = null;
        Method method = clazz.getMethod(getMethodName(true, attribute));
        if (method != null)
            t = method.invoke(obj);
        if (t != null)
            return t.toString();
        else
            return null;
    }

    /**
     * invokeSetterMethod
     * 李享亮  2014-4-11
     * 修改者名字 修改日期
     * 修改内容
     *
     * @param @param  obj
     * @param @param  attribute
     * @param @param  value
     * @param @throws Exception
     * @return void
     * @throws
     */
    @SuppressWarnings({"unchecked", "rawtypes"})
    public static void invokeSetterMethod(Object obj, String attribute,
                                          Object value) throws Exception {
        Class clazz = obj.getClass();
        Field field = clazz.getDeclaredField(attribute);
        Class paramType = field.getType();
        Method method = clazz.getMethod(getMethodName(false, attribute),
                paramType);
        if (method != null)
            method.invoke(obj, value);
    }

    @SuppressWarnings({"rawtypes"})
    public static void emptyToNull(Object obj) throws Exception {
        Class objcls = obj.getClass();
        Field[] fields = objcls.getDeclaredFields();
        for (int i = 0; i < fields.length; i++) {
            String value = invokeGetterMethod(obj, fields[i].getName());
            if (value != null && value.equals("")) {
                invokeSetterMethod(obj, fields[i].getName(), null);
            }
        }
    }

    /**
     * getMethodName 李享亮 2014-4-11 修改者名字 修改日期 修改内容
     *
     * @param @param  flag
     * @param @param  attribute
     * @param @return
     * @return String
     * @throws
     */
    private static String getMethodName(boolean flag, String attribute) {
        String firstElemntOfAttribute = attribute.substring(0, 1).toUpperCase();
        String restElementOfAttrute = attribute.substring(1);
        return (flag ? "get" : "set") + firstElemntOfAttribute
                + restElementOfAttrute;
    }
}

