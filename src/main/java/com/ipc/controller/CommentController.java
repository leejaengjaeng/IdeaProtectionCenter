package com.ipc.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ipc.dao.RegistrationDao;
import com.ipc.dao.RegistrationFileDao;
import com.ipc.vo.RegistrationFileVo;
import com.ipc.vo.RegistrationPatentVo;
import com.ipc.vo.userVo;


@Controller
public class CommentController {
	
	@Autowired
	RegistrationDao regDao;
	@Autowired
	HttpSession session;
	@Autowired
	RegistrationFileDao regFileDao;
	
	@RequestMapping("/test")
	public String test(Model model)
	{
		return "comment/comment";
	}
	
	/*
	발명가

		-이전 작성
		코멘트   -
		
		-새로 작성
		
   	변리사
		
		이전 코멘트 - 
		
		-발명가 작성 
		새로운 코멘트-
	 */
	@RequestMapping(value="/detail/{start_rid}",method=RequestMethod.GET)
	public String detail(@PathVariable int start_rid,Model model)
	{
		//접근한 경로에 대한 권한 확인
		RegistrationPatentVo assosiatedMemberId= regDao.getAssociatedMembersByRid(start_rid);		

		Object isAuthenticated = session.getAttribute("currentUser");

		if(assosiatedMemberId != null && isAuthenticated != null )
		{
			int inventorId = assosiatedMemberId.getUid();
			int plId = assosiatedMemberId.getLid();
			int userId = ((userVo)isAuthenticated).getUid();
			int lastRid = regDao.getLastRidInProcessList(start_rid);
			
			//현재 나타내는 rid 저장
			session.setAttribute("currentPosition", lastRid);

			List<RegistrationFileVo> imgList= regFileDao.getImgListByStartRid(start_rid);
			List<RegistrationPatentVo> processList = regDao.getAssociatedProcessList(start_rid);

			model.addAttribute("imgs", imgList);
			model.addAttribute("processList",processList);
			model.addAttribute("lastRid",lastRid);
			
			//발명가가 보는 경우
			if(inventorId==userId) 
			{
				//getRegistrationByRidOrPrevRid(prevRid) + getInventorModifyByRid
				
				RegistrationPatentVo currentAnswer = regDao.getInventorModifyByRid(lastRid);
				RegistrationPatentVo beforeReg = regDao.getRegistrationByRidOrPrevRid(currentAnswer.getPrev_rid());
				
				model.addAttribute("user","inventor");
				model.addAttribute("beforeReg",beforeReg);
				model.addAttribute("currentAnswer", currentAnswer);
				

				if(beforeReg == null)
					model.addAttribute("isFirst","true");
				else
					model.addAttribute("isFirst","false");
				
				return "comment/comment_inventor";
			}
			//변리사가 보는 경우
			if(plId==userId)
			{
				//getRegistrationByRidOrPrevRid(rid) + getPrevPlCommentByPrevRid
				
				RegistrationPatentVo currentAnswer = regDao.getRegistrationByRidOrPrevRid(lastRid);
				RegistrationPatentVo beforeComment = regDao.getPrevPlCommentByPrevRid(currentAnswer.getPrev_rid());
					
				model.addAttribute("user","pl");
				
				model.addAttribute("beforeComment", beforeComment);
				model.addAttribute("currentAnswer", currentAnswer);
				
				if(beforeComment == null)
					model.addAttribute("isFirst","true");
				else
					model.addAttribute("isFirst","false");
				
				return "comment/comment_pl";
			}
		}
		return "redirect:/authError";
	}
	
	//Ajax용
	@RequestMapping(value="/detailByRid/{rid}",method=RequestMethod.GET)
	@ResponseBody
	public Map detailByRid(@PathVariable int rid)
	{
		//접근한 경로에 대한 권한 확인
		RegistrationPatentVo assosiatedMemberId= regDao.getAssociatedMembersByRid(rid);		
		Object isAuthenticated = session.getAttribute("currentUser");

		if(assosiatedMemberId != null && isAuthenticated != null )
		{
			int inventorId = assosiatedMemberId.getUid();
			int plId = assosiatedMemberId.getLid();
			int userId = ((userVo)isAuthenticated).getUid();
			
			session.setAttribute("currentPosition", rid);
			
			Map<String,Object> retVal = new HashMap<String,Object>();
			
			
			//발명가가 보는 경우
			if(inventorId==userId) 
			{
				//getRegistrationByRidOrPrevRid(prevRid) + getInventorModifyByRid
				
				RegistrationPatentVo currentAnswer = regDao.getInventorModifyByRid(rid);
				RegistrationPatentVo beforeReg = regDao.getRegistrationByRidOrPrevRid(currentAnswer.getPrev_rid());
				
				retVal.put("user", "inventor");
				retVal.put("beforeReg", beforeReg);
				retVal.put("currentAnswer", currentAnswer);

				if(beforeReg == null)
					retVal.put("isFirst","true");
				else
					retVal.put("isFirst","false");
				
				return retVal;
			}
			//변리사가 보는 경우
			if(plId==userId)
			{
				//getRegistrationByRidOrPrevRid(rid) + getPrevPlCommentByPrevRid
				
				RegistrationPatentVo currentAnswer = regDao.getRegistrationByRidOrPrevRid(rid);
				RegistrationPatentVo beforeComment = regDao.getPrevPlCommentByPrevRid(currentAnswer.getPrev_rid());
					
				retVal.put("user", "pl");
				retVal.put("beforeComment", beforeComment);
				retVal.put("currentAnswer", currentAnswer);

				if(beforeComment == null)
					retVal.put("isFirst","true");
				else
					retVal.put("isFirst","false");
				
				return retVal;
			}
		}
		
		return null;
	}
	
	//Ajax용
	@RequestMapping(value="/tmpSave",method=RequestMethod.POST)
	@ResponseBody
	public String tmpSave(RegistrationPatentVo regVo, HttpServletRequest req)
	{
		String role = req.getParameter("role");
		
		//현재 페이지의 rid와 수정 요청한 rid가 같은지 확인 
		if((int)session.getAttribute("currentPosition") != regVo.getRid())
			return "잘못된 접근입니다.";
			
		if(role.equals("pl"))
		{
			//완료여부에 따른 체크 
			if(0 == regDao.checkIsCompletedByRid(regVo.getRid()))
				return "이미 완료된 사항입니다.";
			
			regVo.setIscomplete(1);
			
			regDao.plUpdate(regVo);
		}
		else if(role.equals("inventor"))
		{
			//완료여부에 따른 체크 
			if(1 == regDao.checkIsCompletedByRid(regVo.getRid()))
				return "이미 완료된 사항입니다.";

			regVo.setIscomplete(0);
			
			regDao.inventorSave(regVo);
		}
		else
		{
			return "저장 실패";
		}
		return "임시 저장 성공";
	}
	
	@RequestMapping(value="/ideaSave",method=RequestMethod.POST)
	@ResponseBody
	public String ideaSave(RegistrationPatentVo regVo, HttpServletRequest req)
	{
		String role = req.getParameter("role");
		//완료여부에 따른 체크 
		//현재 페이지의 rid와 수정 요청한 rid가 같은지 확인 
		if((int)session.getAttribute("currentPosition") != regVo.getRid())
		{
			System.out.println(regVo.getRid()+","+(int)session.getAttribute("currentPosition"));
			return "잘못된 접근입니다.";
		}
			
		if(role.equals("pl"))
		{
			if(0 == regDao.checkIsCompletedByRid(regVo.getRid()))
				return "이미 완료된 사항입니다.";
			
			RegistrationPatentVo tmpVo = regDao.getResourceForPlSaveByRid(regVo.getRid());
			System.out.println("여기로 오니?");
			regVo.setRid(0);
			regVo.setIscomplete(0);
			regVo.setPrev_rid(regVo.getRid());
			regVo.setStart_rid(tmpVo.getStart_rid());
			regVo.setLid(tmpVo.getLid());
			regVo.setUid(tmpVo.getUid());
			regDao.plSave(regVo);

			return "저장 성공";

		}
		else if(role.equals("inventor"))
		{
			if(1 == regDao.checkIsCompletedByRid(regVo.getRid()))
				return "이미 완료된 사항입니다.";
		
			regVo.setIscomplete(1);
			regDao.inventorSave(regVo);
			
			return "저장 성공";
			
		}
		else
		{
			System.out.println(role+"잉?");
			
			return "저장 실패";
		}
		
	}
	@RequestMapping(value="deleteFile",method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String,String> deleteFile(HttpServletRequest request,@RequestParam HashMap<String, Object> param){
		String path=param.get("path").toString();
		File file=new File("../Idea-Protection-Center/src/main/webapp"+path);
		file.delete();
		regFileDao.deleteFile(path);
		
		
		HashMap<String,String> map=new HashMap<String,String>();
		map.put("result", "aa");
		return map;
	}
}
