package com.wd.backend.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.wd.util.*;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.wd.backend.bo.Pager;
import com.wd.backend.model.Department;
import com.wd.backend.model.Member;
import com.wd.backend.model.Org;
import com.wd.backend.service.MailService;
import com.wd.backend.service.MemberManagerI;
import com.wd.backend.service.OrgServiceI;
import com.wd.backend.service.UserRequestServiceI;
import com.wd.backend.service.VisitServiceI;
import com.wd.comm.Comm;
import com.wd.exeception.SystemException;
import com.wd.front.service.UserServiceI;

@Controller
@RequestMapping("/backend/member")
public class MemberController {

    @Autowired
    private MemberManagerI manager;

    @Autowired
    private MailService mailService;

    /**
     * 用户信息修改
     */
    @Autowired
    private UserServiceI userService;

    @Autowired
    private VisitServiceI visitService;

    @RequestMapping(value = {"/list"}, method = {RequestMethod.GET})
    public String list(HttpServletRequest request) {
        request.setAttribute("show", 5);
        String offset = request.getParameter("offset");
        Pager pager = manager.getMemberSchool(offset);
        request.setAttribute("pager", pager);
        request.setAttribute("offset", offset);
        return "back/visit/schoolAll";
    }

    @RequestMapping(value = {"/list/school"}, method = {RequestMethod.GET})
    public String listFromSchool(HttpServletRequest request) {
        request.setAttribute("show", 5);
        String department = request.getParameter("department");
        String order = request.getParameter("order");
        String key = request.getParameter("key");
        Org org = (Org) request.getSession().getAttribute("org");
        String schoolFlag = org.getFlag();
        if (StringUtils.isNotEmpty(request.getParameter("schoolFlag"))) {
            schoolFlag = request.getParameter("schoolFlag");
            if ("all".equals(schoolFlag)) {
                schoolFlag = null;
            }
        }
        if (StringUtils.isEmpty(department)) {
            department = null;
        }
        if (StringUtils.isEmpty(order)) {
            order = "11";
        }
        Pager pager = manager.findPager(key, schoolFlag, department, order);
        request.setAttribute("data", pager);
        request.setAttribute("key", key);
        request.setAttribute("schoolFlag", schoolFlag);
        request.setAttribute("department", department);
        request.setAttribute("order", order);
        request.setAttribute("type", order.substring(1));
        return "back/visit/list";
    }

    /**
     * 找回密码
     *
     * @return
     */
    @RequestMapping(value = {"/list/findPwd"}, method = {RequestMethod.GET})
    public String findPwd() {
        return "back/findPwd";
    }

    @RequestMapping(value = {"/list/findPwd"}, method = {RequestMethod.POST})
    public String findPwd(String username, String code, HttpServletRequest request, HttpSession session) {
        Member member = userService.findByUsername(username);
        String sessionCode = (String) session.getAttribute("backend:code");
        if (member == null) {//
            request.setAttribute("email", "用户名不存在!");
        } else if (StringUtils.isBlank(code) || !code.equalsIgnoreCase(sessionCode)) {
            request.setAttribute("email", "验证码错误!");
        } else {
            String path = request.getContextPath();
            // 获得项目完全路径（假设你的项目叫MyApp，那么获得到的地址就是http://localhost:8080/MyApp/）:
            String basePath = request.getScheme() + "://" + request.getServerName()
                    + ":" + request.getServerPort() + path + "/user/checkLink";
            userService.sendResetMail(member, basePath);
            request.setAttribute("email", "邮件发送成功！请注意查收！");
//			throw new OperationException("邮件发送成功！请注意查收！");
        }
        return "back/findPwd";
    }

    @Autowired
    private OrgServiceI orgService;

    /**
     * 根据学校id查学院
     */
    @RequestMapping(value = {"/list/findDepBySchool"}, method = {RequestMethod.GET})
    @ResponseBody
    public AjaxResult findDepBySchool(HttpServletRequest request) {
        String schoolId = request.getParameter("schoolId");
        List<Department> list = orgService.findDepBySchool(Integer.parseInt(schoolId));
        Collections.sort(list);
        String js = JsonUtil.obj2Json(list);
        return new AjaxResult(js);
    }

    @RequestMapping(value = {"/list"}, method = {RequestMethod.POST})
    @ResponseBody
    public AjaxResult list(HttpServletRequest request, String schoolFlag, String department) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("schoolFlag", schoolFlag);
        params.put("department", department);
        Pager pager = manager.findPager(null, schoolFlag, department, null);
        String js = JsonUtil.obj2Json(pager);
        return new AjaxResult(js);
    }

    /**
     * 添加一个用户
     *
     * @param member
     * @param request
     * @return
     */
    @RequestMapping(value = {"/list/addUser"}, method = {RequestMethod.POST})
    @ResponseBody
    public AjaxResult addUser(Member member, HttpServletRequest request) {
        SchoolBackRequest schoolBackRequest = new SchoolBackRequest();
        boolean flag = schoolBackRequest.userRequest(request, JsonUtil.obj2Json(member));
        if (!flag) {
            return new AjaxResult("已成功发送给管理员审核！");
        }

        String ip = IpUtil.getIpAddr(request);
        member.setRegisterIp(ip);
        int result = manager.register(member);
        if (result != 0) {
            return new AjaxResult("添加成功！");
        } else {
            return new AjaxResult("添加失败！");
        }
    }

    /**
     * 编辑修改一个用户
     *
     * @param member
     * @param request
     * @return
     */
    @RequestMapping(value = {"/list/updateUser"}, method = {RequestMethod.POST})
    @ResponseBody
    public AjaxResult updateUser(Member member, HttpServletRequest request) {
        SchoolBackRequest schoolBackRequest = new SchoolBackRequest();
        boolean flag = schoolBackRequest.userRequest(request, JsonUtil.obj2Json(member));
        if (!flag) {
            return new AjaxResult("已成功发送给管理员审核！");
        }

        if ("      ".equals(member.getPwd())) {
            member.setPwd(null);
        } else {
            member.setPwd(MD5Util.getMD5(member.getPwd().getBytes()));
        }
        manager.update(member);
        Member p = (Member) request.getSession().getAttribute(Comm.MEMBER_SESSION_NAME);
//		Person p = (Person) request.getSession().getAttribute("person");
        if (member.getEmail().equals(p.getEmail()) && member.getPwd() != null) {
            return new AjaxResult("修改成功！因为修改了本账号密码!需要重新登录。", "backend/logout");
        }
        return new AjaxResult("修改成功！");
    }

    /**
     * 添加多个用户
     *
     * @param request
     * @return
     */
//	@RequestMapping(value={"/list/addUsers"},method={RequestMethod.POST})
//	@ResponseBody
//	public AjaxResult addUsers(@RequestParam(value = "file", required = false) MultipartFile file,HttpServletRequest request){
    @RequestMapping(value = {"/list/addUsers"}, method = {RequestMethod.POST})
    public String addUsers(@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request) {
        String path = null;
        if (!file.isEmpty()) {
            String realPath = FileUtil.getSysUserHome(), dailyPath = FileUtil.getDailyPath();
            realPath += dailyPath;
            //创建目录
            FileUtil.createDir(new File(realPath));
            //创建一个新文件
            File attachFile = FileUtil.createNewFile(realPath, file.getOriginalFilename());
            try {
                FileUtils.copyInputStreamToFile(file.getInputStream(), attachFile);
            } catch (IOException e) {
                e.printStackTrace();
            }
            path = dailyPath + attachFile.getName();
        }

        SchoolBackRequest schoolBackRequest = new SchoolBackRequest();
        boolean flag = schoolBackRequest.userRequest(request, path);
        if (!flag) {
            //	return new AjaxResult("已成功发送给管理员审核！");
            request.getSession().setAttribute("addUsers", "已成功发送给管理员审核！");
            return "redirect:/backend/member/list";
            //return "back/visit/list";
        }

        try {
            InputStream input = file.getInputStream();
            String ip = IpUtil.getIpAddr(request);
            manager.registerUsers(input, ip);
        } catch (Exception e) {
            //	return new AjaxResult("文本格式内容不正确！");
            request.getSession().setAttribute("addUsers", "文本格式内容不正确！");
            return "redirect:/backend/member/list";
            //return "back/visit/list";
        }
        request.getSession().setAttribute("addUsers", "上传成功！");
        return "redirect:/backend/member/list";
        //return "back/visit/list";
//		return new AjaxResult("上传成功！");
    }


    /**
     * 删除用户
     *
     * @param request
     * @return
     */
    @RequestMapping(value = {"/list/deleteUser"}, method = {RequestMethod.GET})
    @ResponseBody
    public AjaxResult deleteUser(HttpServletRequest request) {
        String id = request.getParameter("id");
        Member member = manager.getById(Integer.parseInt(id));

        SchoolBackRequest schoolBackRequest = new SchoolBackRequest();
        boolean flag = schoolBackRequest.userRequest(request, JsonUtil.obj2Json(member));
        if (!flag) {
            return new AjaxResult("已成功发送给管理员审核！");
        }
        String requestId = request.getParameter("requestId");
        if (requestId != null && !"".equals(requestId)) {
            userRequestService.updateById(Integer.parseInt(requestId));
        }

        manager.deleteUser(Integer.parseInt(id));
        return new AjaxResult("删除用户成功！");
    }

    /**
     * 根据用户id获取用户信息
     *
     * @param request
     * @return
     */
    @RequestMapping(value = {"/list/getById"}, method = {RequestMethod.GET})
    @ResponseBody
    public AjaxResult getById(HttpServletRequest request) {
        String id = request.getParameter("id");
        Member member = manager.getById(Integer.parseInt(id));
        String js = JsonUtil.obj2Json(member);
        return new AjaxResult(js);
    }

    /**
     * 校外登录
     *
     * @param request
     * @return
     */
    @RequestMapping(value = {"/list/apply"}, method = {RequestMethod.POST})
    @ResponseBody
    public AjaxResult apply(HttpServletRequest request) {
        String id = request.getParameter("id");
        String email = request.getParameter("email");
        String permission = request.getParameter("permission");
        Date date = new Date();
        Member user = (Member) request.getSession().getAttribute(Comm.MEMBER_SESSION_NAME);
        Member member = manager.getById(Integer.parseInt(id));
        member.setPermission(Integer.parseInt(permission));
        member.setHandleTime(date);
        member.setHandlePeople(user.getUsername());
        if (permission != null && !"".equals(permission) && Integer.parseInt(permission) == 4) {
            Calendar c = Calendar.getInstance();
            c.setTime(date);
            c.add(Calendar.MONTH, 6);
            member.setLifespan(c.getTime());
        }
        manager.applyLogin(member);
        try {
            String subject = request.getParameter("subject");
            String content = request.getParameter("content");
            mailService.send(email, subject, content, null);
        } catch (Exception e) {
            return new AjaxResult("邮件发送失败");
        }
        return new AjaxResult("邮件已成功发送");
    }

    /**
     * 禁用用户
     *
     * @param request
     * @return
     */
    @RequestMapping(value = {"/list/forbidden"}, method = {RequestMethod.GET})
    @ResponseBody
    public AjaxResult forbidden(HttpServletRequest request) {
        String id = request.getParameter("id");
        String type = request.getParameter("type");
        Member member = manager.getById(Integer.parseInt(id));
        member.setForbidden(Integer.parseInt(type));
        manager.forbidden(member);
//		mailService.send(member.getEmail(), "校外登录申请回馈", "校外登录申请成功", null);
        if (Integer.parseInt(type) == 1) {
            return new AjaxResult("该用户已解除禁用！");
        } else {
            return new AjaxResult("该用户已被禁用！");
        }
    }



    /**
     * 通过用户请求(添加一个用户)
     *
     * @param member
     * @param request
     * @return
     */
    @RequestMapping(value = {"/list/addUser"}, method = {RequestMethod.GET})
    @ResponseBody
    public AjaxResult addUserByRequest(Member member, HttpServletRequest request) {
        String id = request.getParameter("requestId");
        userRequestService.updateById(Integer.parseInt(id));

        String ip = IpUtil.getIpAddr(request);
        member.setRegisterIp(ip);
        int result = manager.register(member);
        if (result != 0) {
            return new AjaxResult("用户请求已通过！用户添加成功！");
        } else {
            return new AjaxResult("用户请求失败！用户添加失败！");
        }
    }

    /**
     * 通过用户请求(编辑修改一个用户)
     *
     * @param member
     * @param request
     * @return
     */
    @RequestMapping(value = {"/list/updateUser"}, method = {RequestMethod.GET})
    @ResponseBody
    public AjaxResult updateUserByRequest(Member member, HttpServletRequest request) {
        String id = request.getParameter("requestId");
        userRequestService.updateById(Integer.parseInt(id));

        if ("      ".equals(member.getPwd())) {
            member.setPwd(null);
        } else {
            member.setPwd(MD5Util.getMD5(member.getPwd().getBytes()));
        }
        manager.update(member);
        return new AjaxResult("用户请求已通过！修改成功！");
    }

    /**
     * 用户请求（添加多个用户）
     *
     * @param request
     * @return
     */
    @RequestMapping(value = {"/list/addUsers"}, method = {RequestMethod.GET})
    @ResponseBody
    public AjaxResult addUsersByRequest(String path, HttpServletRequest request) {
        String id = request.getParameter("requestId");
        userRequestService.updateById(Integer.parseInt(id));

        File file = new File(request.getSession().getServletContext().getRealPath("/") + path);
        InputStream input;
        try {
            input = new FileInputStream(file);
            String ip = IpUtil.getIpAddr(request);
            manager.registerUsers(input, ip);
        } catch (SystemException e) {
            return new AjaxResult("文本格式内容不正确！");
        } catch (FileNotFoundException e1) {
            return new AjaxResult("文件没找到或已被删除！");
        }
        return new AjaxResult("用户请求已通过！添加用户成功！");
    }

    @Autowired
    UserRequestServiceI userRequestService;

}
