package com.zlkj.trainmanager.tools;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.Random;

public class ImageTools {

	public static void writeImage(byte[] bytes,OutputStream ops){
		try {
			ops.write(bytes);
		} catch (Exception e) {
			//e.printStackTrace();
		}
	}
	
	public static Color getRandColor(int fc, int bc) {
		Random random = new Random();
		if (fc > 255)
			fc = 255;
		if (bc > 255)
			bc = 255;
		int r = fc + random.nextInt(bc - fc);
		int g = fc + random.nextInt(bc - fc);
		int b = fc + random.nextInt(bc - fc);
		return new Color(r, g, b);
	}
	
	public static void printRandImg(HttpServletRequest request,
			HttpServletResponse response) {
		int width = 65, height = 20;
		try {
			BufferedImage image = new BufferedImage(width, height,
					BufferedImage.TYPE_INT_RGB);
			Graphics g = image.getGraphics();
			Random random = new Random();
			g.setColor(getRandColor(200, 250));
			g.fillRect(0, 0, width, height);
			g.setFont(new Font("Times   New   Roman", Font.PLAIN, 18));
			g.setColor(getRandColor(160, 200));
			for (int i = 0; i < 155; i++) {
				int x = random.nextInt(width);
				int y = random.nextInt(height);
				int xl = random.nextInt(10);
				int yl = random.nextInt(10);
				g.drawLine(x, y, x + xl, y + yl);
			}
			char c[] = new char[62];
			for (int i = 97, j = 0; i < 123; i++, j++) {
				c[j] = (char) i;
			}
			for (int o = 65, p = 26; o < 91; o++, p++) {
				c[p] = (char) o;
			}
			for (int m = 48, n = 52; m < 58; m++, n++) {
				c[n] = (char) m;
			}
			String sRand = "";
			for (int i = 0; i < 4; i++) {
				// int x = random.nextInt(62);
				// String rand = String.valueOf(c[x]);
				// sRand += rand;
				// g.setColor(new Color(20 + random.nextInt(110), 20 + random
				// .nextInt(110), 20 + random.nextInt(110)));
				// g.drawString(rand, 13 * i + 6, 16);
				int x = random.nextInt(62);
				String rand = String.valueOf(c[x]).toUpperCase();
				if ("I".equals(rand) || "O".equals(rand) || "0".equals(rand))
					rand = "W";
				sRand += rand;
				g.setColor(new Color(20 + random.nextInt(110), 20 + random
						.nextInt(110), 20 + random.nextInt(110)));
				g.drawString(rand, 13 * i + 6, 16);
			}
			// ����֤�����SESSION
			request.getSession().setAttribute("rand", sRand.toUpperCase());
			g.dispose();
			ImageIO.setUseCache(true);
			ServletOutputStream stream = response.getOutputStream();
			ImageIO.write(image, "JPEG", stream);
			stream.flush();
			stream.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * ͼƬ�ü�
	 * @param image
	 * @param x
	 * @param y
	 * @param w
	 * @param h
	 * @param scaleWidth
	 * @return
	 * @throws Exception
	 */
	public static byte[] imageClipping(byte[] image,int x,int y,int w,int h,int scaleWidth) throws Exception{
		ByteArrayInputStream bais = null;
		ByteArrayOutputStream baos = null;
		BufferedImage bi = null;
        try {
			bais = new ByteArrayInputStream(image);
			bi = ImageIO.read(bais);
			bi = imageResize(bi, scaleWidth);
			bi = bi.getSubimage(x, y, w, h);
			baos = new ByteArrayOutputStream();
			ImageIO.write(bi, "jpg", baos);
			return baos.toByteArray();
		} catch (Exception e) {
			throw e;
		}finally{
			try {
				bais.close();
			} catch (Exception e) {}
		}
	}
	
	/**
	 * ͼƬ�ü�
	 * @param image
	 * @param x
	 * @param y
	 * @param w
	 * @param h
	 * @param scaleWidth
	 * @return
	 * @throws Exception
	 */
	public static byte[] imageClipping(byte[] image,int x,int y,int w,int h,int scaleWidth,int scaleHeight) throws Exception{
		ByteArrayInputStream bais = null;
		ByteArrayOutputStream baos = null;
		BufferedImage bi = null;
        try {
			bais = new ByteArrayInputStream(image);
			bi = ImageIO.read(bais);
			bi = imageResize(bi, scaleWidth,scaleHeight);
			bi = bi.getSubimage(x, y, w, h);
			baos = new ByteArrayOutputStream();
			ImageIO.write(bi, "jpg", baos);
			return baos.toByteArray();
		} catch (Exception e) {
			throw e;
		}finally{
			try {
				bais.close();
			} catch (Exception e) {}
		}
	}
	
	/**
	 * ����
	 * @param args
	 * @throws Exception
	 */
	public static void main(String args[]) throws Exception{
		//ͼƬ�ü�
		BufferedImage bi = ImageIO.read(new File("C:/Users/new/Desktop/xk0.jpeg"));
		//bi = imageResize(bi, 300);
		//bi = bi.getSubimage(136, 34, 206, 206);
		ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
		ImageIO.write(bi, "jpg", byteArrayOutputStream);
		byte[] bs2 = byteArrayOutputStream.toByteArray();
		FileOutputStream fos = new FileOutputStream("D:/xk0_s.jpeg");
		fos.write(bs2);
	}
	
	/**
	 * ���ݿ�ȵȱ�������ͼƬ
	 * @param image
	 * @param newWidth
	 * @return
	 * @throws Exception
	 */
	public static BufferedImage imageResize(BufferedImage image,int newWidth) throws Exception {  
		try {
			int w = image.getWidth();
			int h = image.getHeight();
			float ratio = (float)w/h;
			float newHeight = newWidth / ratio;
			
			BufferedImage newImage = new BufferedImage(newWidth, (int) newHeight, BufferedImage.TYPE_INT_RGB);
			Graphics2D g = newImage.createGraphics();
			g.drawImage(image, 0,0,newWidth, (int) newHeight, null);
			return newImage;
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("���ݿ�ȵȱ�������ͼƬ�����쳣��",e);
		}
    }
	
	/**
	 * ���ݿ�ȡ��߶ȵȱ�������ͼƬ
	 * @param image
	 * @param newWidth
	 * @return
	 * @throws Exception
	 */
	public static BufferedImage imageResize(BufferedImage image,int newWidth,int newHeight) throws Exception {  
		try {
			int w = image.getWidth();
			int h = image.getHeight();
			
			BufferedImage newImage = new BufferedImage(newWidth, (int) newHeight, BufferedImage.TYPE_INT_RGB);
			Graphics2D g = newImage.createGraphics();
			g.drawImage(image, 0,0,newWidth, (int) newHeight, null);
			return newImage;
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("���ݿ�ȵȱ�������ͼƬ�����쳣��",e);
		}
    }
}
