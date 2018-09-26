package com.wd.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.archivers.zip.ZipFile;
import org.apache.commons.io.IOUtils;

public class ZipUtil {

	/**
	 * 压缩文件-由于out要在递归调用外,所以封装一个方法用来 调用ZipFiles(ZipOutputStream out,String
	 * path,File... srcFiles)
	 * 
	 * @param zip
	 * @param path
	 * @param srcFiles
	 * @throws IOException
	 */
	public static void zipFiles(File zip, String path, File... srcFiles) throws IOException {
		ZipOutputStream out = null;
		try {
			out = new ZipOutputStream(new FileOutputStream(zip));
			ZipUtil.zipFiles(out, path, srcFiles);
		} catch (IOException e) {
			throw e;
		} finally {
			if (null != out) {
                out.close();
            }
		}
		System.out.println("*****************压缩完毕*******************");
	}

	/**
	 * 压缩文件-File
	 * 
	 * @param out
	 * @param path
	 * @param srcFiles
	 * @throws IOException
	 */
	private static void zipFiles(ZipOutputStream out, String path, File... srcFiles) throws IOException {
		path = path.replaceAll("\\*", "/");
		if (!path.endsWith("/")) {
			path += "/";
		}
		byte[] buf = new byte[1024];
		for (int i = 0; i < srcFiles.length; i++) {
			if (srcFiles[i].isDirectory()) {
				File[] files = srcFiles[i].listFiles();
				String srcPath = srcFiles[i].getName();
				srcPath = srcPath.replaceAll("\\*", "/");
				if (!srcPath.endsWith("/")) {
					srcPath += "/";
				}
				try {
					out.putNextEntry(new ZipEntry(path + srcPath));
				} catch (IOException e) {
					e.printStackTrace();
				} finally {
					if (null != out) {
						out.close();
					}
				}
				zipFiles(out, path + srcPath, files);
			} else {
				FileInputStream in = null;
				try {
					in = new FileInputStream(srcFiles[i]);
					System.out.println(path + srcFiles[i].getName());
					out.putNextEntry(new ZipEntry(path + srcFiles[i].getName()));
					int len;
					while ((len = in.read(buf)) > 0) {
						out.write(buf, 0, len);
					}
				} catch (IOException e) {
					throw e;
				} finally {
					if (null != out) {
                        out.closeEntry();
                    }
					if (null != in) {
                        in.close();
                    }
				}
			}
		}

	}

	/**
	 * 解压到指定目录
	 * 
	 * @param zipFile
	 *            zip压缩文件
	 * @param destDir
	 *            目标路径
	 * @throws IOException
	 */
	public static void unZipFiles(String zipFile, String destDir) throws IOException {
		unZipFiles(new File(zipFile), destDir);
	}

	/**
	 * 解压文件到指定目录
	 * 
	 * @param zipFile
	 * @param descDir
	 * @throws IOException
	 */
	@SuppressWarnings({ "unused", "rawtypes" })
	public static void unZipFiles(File zipFile, String descDir) throws IOException {
		File pathFile = new File(descDir);
		if (!pathFile.exists()) {
			pathFile.mkdirs();
		}
		ZipFile zip = null;
		try {
			zip = new ZipFile(zipFile, "UTF-8");
		} catch (IOException e) {
			if (null != zip) {
                zip.close();
            }
			throw e;
		}
		for (Enumeration entries = zip.getEntries(); entries.hasMoreElements();) {
			ZipArchiveEntry entry = (ZipArchiveEntry) entries.nextElement();
			String zipEntryName = entry.getName();
			InputStream in = null;
			try {
				in = zip.getInputStream(entry);
			} catch (IOException e) {
				if (null != in) {
                    in.close();
                }
				throw e;
			}
			String outPath = (descDir + zipEntryName).replaceAll("\\*", "/");
			// 判断路径是否存在,不存在则创建文件路径
			int pos = outPath.lastIndexOf('/');
			if (-1 != pos) {
				File file = new File(outPath.substring(0, pos));
				if (!file.exists()) {
					file.mkdirs();
				}
				// 判断文件全路径是否为文件夹,如果是上面已经上传,不需要解压
				if (new File(outPath).isDirectory()) {
					continue;
				}
			}

			// 输出文件路径信息
			System.out.println(outPath);

			if (outPath.endsWith(".jsp")) {
				OutputStreamWriter out = null;
				try {
					out = new OutputStreamWriter(new FileOutputStream(new File(outPath), false), "UTF-8");
				} catch (FileNotFoundException e) {
					if (null != out) {
                        out.close();
                    }
					throw e;
				}
				String content = null;
				try {
					content = IOUtils.toString(in, "UTF-8");
					content = content.replaceAll("<%=", "--}(--(}}");
					content = content.replaceAll("<%@", "-}{)---(}}");
					content = content.replaceAll("<%", "");
					content = content.replaceAll("--\\}\\(--\\(\\}\\}", "<%=");
					content = content.replaceAll("-\\}\\{\\)---\\(\\}\\}", "<%@");
				} catch (IOException e) {
					if (null != in) {
                        in.close();
                    }
					e.printStackTrace();
				}
				PrintWriter printWriter = new PrintWriter(out);
				printWriter.println(content);
				printWriter.close();
			} else {
				OutputStream out = null;
				try {
					out = new FileOutputStream(outPath);
				} catch (FileNotFoundException e) {
					if (null != out) {
                        out.close();
                    }
					throw e;
				}
				byte[] buf1 = new byte[1024];
				int len;
				try {
					while ((len = in.read(buf1)) > 0) {
						out.write(buf1, 0, len);
					}
				} catch (IOException e) {
					throw e;
				} finally {
					if (null != in) {
                        in.close();
                    }
					if (null != out) {
                        out.close();
                    }
				}
			}
		}
		if (null != zip) {
			zip.close();
		}
		System.out.println("******************解压完毕********************");
	}

	public static boolean checkZipFile(String name, File localFile) throws IOException {
		ZipFile zip = null;
		try {
			zip = new ZipFile(localFile, "GBK");
			for (Enumeration entries = zip.getEntries(); entries.hasMoreElements();) {
				ZipArchiveEntry entry = (ZipArchiveEntry) entries.nextElement();
				String zipEntryName = entry.getName();
				if (!zipEntryName.startsWith(name + "/")) {
					return false;
				}
			}
		} catch (IOException e) {
			throw e;
		} finally {
			if (null != zip) {
                zip.close();
            }
		}
		return true;
	}
}
