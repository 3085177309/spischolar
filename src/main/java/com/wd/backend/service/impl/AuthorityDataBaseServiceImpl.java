package com.wd.backend.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.transaction.SystemException;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.bo.AuthorityDatabaseBO;
import com.wd.backend.bo.Pager;
import com.wd.backend.dao.AuthorityDatabaseDaoI;
import com.wd.backend.model.AuthorityDatabase;
import com.wd.backend.service.AuthorityDataBaseServiceI;
import com.wd.comm.context.SystemContext;
import com.wd.util.SimpleUtil;

@Service("authorityDBService")
public class AuthorityDataBaseServiceImpl implements AuthorityDataBaseServiceI {

	@Autowired
	private AuthorityDatabaseDaoI authorityDatabaseDao;

	@Override
	public AuthorityDatabaseBO detail(Integer id) {
		AuthorityDatabase dbPartition = authorityDatabaseDao.findById(id);
		AuthorityDatabaseBO bo = null;
		if (null != dbPartition) {
			bo = new AuthorityDatabaseBO();
			BeanUtils.copyProperties(dbPartition, bo);
		}
		return bo;
	}

	@Override
	public void add(AuthorityDatabaseBO authorityDB) throws SystemException {
		if (SimpleUtil.strIsNull(authorityDB.getFlag())) {
			throw new SystemException("权威数据库标识不能为空!");
		}
		Integer flagExists = authorityDatabaseDao.findFlagExists(authorityDB.getFlag());
		if (null != flagExists) {
			throw new SystemException("权威数据库标识重复!");
		}
		AuthorityDatabase model = new AuthorityDatabase();
		BeanUtils.copyProperties(authorityDB, model);
		authorityDatabaseDao.insert(model);
	}

	@Override
	public void del(Integer id) {
		authorityDatabaseDao.del(id);
	}

	@Override
	public void edit(AuthorityDatabaseBO authorityDB) throws SystemException {
		if (SimpleUtil.strIsNull(authorityDB.getFlag())) {
			throw new SystemException("权威数据库标识不能为空!");
		}
		Map<String, Object> params = new HashMap<String, Object>(2);
		params.put("flag", authorityDB.getFlag());
		params.put("id", authorityDB.getId());
		Integer flagExists = authorityDatabaseDao.findFlagExistsByParam(params);
		if (null != flagExists) {
			throw new SystemException("权威数据库标识重复!");
		}
		AuthorityDatabase model = new AuthorityDatabase();
		BeanUtils.copyProperties(authorityDB, model);
		authorityDatabaseDao.update(model);
	}

	@Override
	public Pager search(String keyword) {
		Pager pager = new Pager();
		Map<String, Object> params = new HashMap<String, Object>(3);
		keyword = SimpleUtil.strIsNull(keyword) ? null : keyword.trim();
		params.put("key", keyword);
		Integer count = authorityDatabaseDao.getCountByKey(params);
		if (null == count) {
			count = 0;
		}
		pager.setTotal(count);
		if (count > 0) {
			params.put("offset", SystemContext.getOffset());
			params.put("size", 10);
			List<AuthorityDatabase> list = authorityDatabaseDao.findByParams(params);
			pager.setRows(list);
		}

		return pager;
	}

}
