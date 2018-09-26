package com.wd.backend.model;

import java.util.Date;
import java.util.Map;

import com.wd.front.bo.SearchDocument;
import com.wd.front.bo.ShouluMap;
import com.wd.util.JsonUtil;

/**
 * 用户收藏
 * @author Administrator
 *
 */
public class Favorite {
	
	private Integer id;
	
	/**用户ID*/
	private Integer memberId;
	
	/**搜藏时间*/
	private Date time;
	
	/**搜藏内容*/
	private String content;
	
	/**文档ID(根据文档的title和href生成的MD5码)*/
	private String docId;
	
	/**1是文章收藏，2是期刊收藏*/
	private int type;
	
	private Map<String, Object> docJournal;
	
	private Map<String, ShouluMap> shoulu;


	public Map<String, ShouluMap> getShoulu() {
		return shoulu;
	}

	public void setShoulu(Map<String, ShouluMap> shoulu) {
		this.shoulu = shoulu;
	}

	public Map<String, Object> getDocJournal() {
		return docJournal;
	}

	public void setDocJournal(Map<String, Object> docJournal) {
		this.docJournal = docJournal;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public SearchDocument getDoc(){
		return JsonUtil.json2Obj(content, SearchDocument.class);
	}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getMemberId() {
		return memberId;
	}

	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getDocId() {
		return docId;
	}

	public void setDocId(String docId) {
		this.docId = docId;
	}

}
