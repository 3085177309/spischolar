package com.wd.exeception;

public class SystemException extends Exception {

	private static final long serialVersionUID = 1L;
	private boolean writeLog;

	public SystemException(String msg) {
		super(msg);
		writeLog = false;
	}

	public SystemException(String msg, boolean writeLog) {
		super(msg);
		this.writeLog = writeLog;
	}

	public SystemException(String msg, Exception exception) {
		super(msg, exception);
		writeLog = false;
	}

	public SystemException(String msg, Exception exception, boolean writeLog) {
		super(msg, exception);
		this.writeLog = writeLog;
	}

	public boolean isWriteLog() {
		return writeLog;
	}

	public void setWriteLog(boolean writeLog) {
		this.writeLog = writeLog;
	}

}
