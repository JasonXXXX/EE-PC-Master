package com.e.until;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class ImageUtil {
	/**
	 * @Description: 将base64编码字符串转换为图片
	 * @Author: 
	 * @CreateTime: 
	 * @param imgStr base64编码字符串
	 * @param path 图片路径-具体到文件
	 * @return
	*/
	public static boolean generateImage(String imgStr, String path) {
		if (imgStr == null) {
			return false;
		}
		BASE64Decoder decoder = new BASE64Decoder();
		try {
			byte[] b = decoder.decodeBuffer(imgStr);
			for (int i = 0; i < b.length; ++i) {
				if (b[i] < 0) {
					b[i] += 256;
				}
			}
			OutputStream out = new FileOutputStream(path);
			out.write(b);
			out.flush();
			out.close();
			return true;
		} catch (Exception e) {
			return false;
		}
	}
	
	/**
	 * @Description: 根据图片地址转换为base64编码字符串
	 * @Author: 
	 * @CreateTime: 
	 * @return
	 */
	public static String getImageStr(String imgFile) {
		InputStream iStream = null;
		byte[] data = null;
		try {
			iStream = new FileInputStream(imgFile);
			data = new byte[iStream.available()];
			iStream.read(data);
			iStream.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		BASE64Encoder encoder = new BASE64Encoder();
		return encoder.encode(data);
	}
}
