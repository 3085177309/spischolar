package com.wd.backend.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.view.UrlBasedViewResolver;

import com.wd.backend.bo.Pager;
import com.wd.backend.bo.PersonBO;
import com.wd.backend.model.Person;
import com.wd.backend.service.PersonServiceI;
import com.wd.exeception.SystemException;
/**
 * 没用到
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/backend/person")
public class PersonController {

	@Autowired
	private PersonServiceI personService;

	@RequestMapping(value = { "/index/{orgId}" }, method = { RequestMethod.GET })
	public String index(@PathVariable Integer orgId, HttpServletRequest request) {
		request.setAttribute("orgId", orgId);
		return "backend/person/index";
	}

	/**
	 * 查看机构人员列表
	 * 
	 * @param orgId
	 * @return
	 */
	@RequestMapping(value = { "/list/{orgId}" }, method = { RequestMethod.GET })
	public String orgPersonList(@PathVariable Integer orgId, HttpServletRequest request) {
		Pager pager = personService.searchOrgPerson(orgId);
		request.setAttribute("pager", pager);
		request.setAttribute("orgId", orgId);
		return "backend/person/list";
	}

	/**
	 * 查看人员详细信息
	 * 
	 * @param personId
	 * @return
	 */
	@RequestMapping(value = { "/detail/{personId}" }, method = { RequestMethod.GET })
	public String detail(@PathVariable Integer personId, HttpServletRequest request) {
		PersonBO person = personService.detail(personId);
		request.setAttribute("person", person);
		request.setAttribute("orgId", person.getOrgId());
		return "backend/person/detail";
	}

	/**
	 * 添加人员
	 * 
	 * @return
	 
	@RequestMapping(value = { "/add/{orgId}" }, method = { RequestMethod.GET })
	public String add(@PathVariable Integer orgId, HttpServletRequest request) {
		request.setAttribute("orgId", orgId);
		request.setAttribute("prepareOpt", "add");
		return "backend/person/detail";
	}

	/**
	 * 添加人员
	 * 
	 * @return
	 
	@RequestMapping(value = { "/add" }, method = { RequestMethod.POST })
	public String add(PersonBO person, HttpServletRequest request) {
		try {
			personService.add(person);
		} catch (SystemException e) {
			request.setAttribute("error", e.getMessage());
			request.setAttribute("prepareOpt", "add");
		}
		request.setAttribute("orgId", person.getOrgId());
		request.setAttribute("person", person);
		request.setAttribute("msg", "用户添加成功");
		request.setAttribute("location", "backend/person/list/"+person.getOrgId());
		return "backend/success";
	}*/

	/**
	 * 修改人员信息
	 * 
	 * @param person
	 * @param response
	 */
	@RequestMapping(value = { "/edit" }, method = { RequestMethod.POST })
	public String edit(PersonBO person, HttpServletRequest request) {
		try {
			personService.edit(person);
		} catch (SystemException e) {
			request.setAttribute("error", e.getMessage());
		}
		Person model = personService.detail(person.getId());
		BeanUtils.copyProperties(model, person);
		request.setAttribute("person", person);
		request.setAttribute("orgId", person.getOrgId());
		return "backend/person/detail";
	}

	@RequestMapping(value = { "/del/{orgId}/{personId}" }, method = { RequestMethod.GET })
	public String del(@PathVariable Integer orgId, @PathVariable Integer personId) {
		personService.del(personId);
		return UrlBasedViewResolver.FORWARD_URL_PREFIX + "/backend/person/list/" + orgId;
	}

	@RequestMapping(value = { "/editStatus/{personId}/{status}" }, method = { RequestMethod.GET })
	public void editStatus(@PathVariable Integer personId, @PathVariable Integer status, HttpServletResponse response) {
		response.setCharacterEncoding("UTF-8");
		personService.editStatus(personId, status);
		String rs = "{}";
		try {
			response.getWriter().print(rs);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = { "/resetPwd/{personId}" }, method = { RequestMethod.GET })
	public void resetPwd(@PathVariable Integer personId, HttpServletResponse httpServletResponse) throws IOException {
		this.personService.editPwdByReset(personId);
		httpServletResponse.getWriter().print("{}");
	}

	/**
	 * 修改密码
	 * 
	 * @param person
	 * @param response
	 */
	@RequestMapping(value = { "/editPwd" }, method = { RequestMethod.POST })
	public void editPwd(PersonBO person, HttpServletResponse response, HttpServletRequest request) {
		Person loginPerson = (Person) request.getSession().getAttribute("loginPerson");
		String rs = "{}";
		response.setCharacterEncoding("UTF-8");
		if (null == loginPerson) {
			rs = "{\"error\":\"无法完成密码修改操作!\"}";
		} else if (!loginPerson.getId().equals(person.getId())) {
			rs = "{\"error\":\"无法完成密码修改操作!\"}";
		} else {
			try {
				personService.editPwd(person);
			} catch (SystemException e) {
				rs = "{\"error\":\"" + e.getMessage() + "\"}";
			}
		}

		try {
			response.getWriter().print(rs);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
