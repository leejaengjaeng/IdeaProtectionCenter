package com.ipc.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ipc.dao.DocumentDao;
import com.ipc.dao.RegistrationDao;
import com.ipc.dao.RegistrationFileDao;
import com.ipc.dao.UpLoadDocDao;
import com.ipc.vo.ApplyDocVo;
import com.ipc.vo.RegistrationFileVo;
import com.ipc.vo.RegistrationPatentVo;

@Controller
public class downLoadDoc {
	@Autowired
	HttpSession session;
	@Autowired
	DocumentDao docmapper;
	@Autowired
	UpLoadDocDao uploaddocmapper;
	@Autowired
	RegistrationDao regismapper;
	@Autowired
	RegistrationFileDao regisfilemapper;
	@Autowired
	DocController docController;
	@Autowired
	DocumentDao docDao;
	
	@RequestMapping("/downLoadPage")
	public String downLoadPage(Model model){
		int rid=(int) session.getAttribute("currentPosition");
//		if(docmapper.isPersonal(rid)==1){
//			model.addAttribute("first", "주민등록등본");
//		}
//		else{
//			model.addAttribute("first", "법인등기부등본");
//		}
		model.addAttribute("docVo",uploaddocmapper.getVoByRid(rid));
		return "apply/downLoadDoc";
	}
	
	@RequestMapping(value="/downDoc",method=RequestMethod.POST)
	@ResponseBody
	public String downDoc(HttpServletRequest request){
		String data=request.getParameter("kind");
		int rid=(int) session.getAttribute("currentPosition");
		//String root_path=request.getSession().getServletContext().getRealPath("/")+"resources/uploadimgs/uploadDocument/";
		//String full_path;
		ApplyDocVo adv=docmapper.getVoByrid(rid);
		
		if(data.equals("resident")){
			//full_path=root_path+adv.getResident_registration();
			System.out.println("resident");
			System.out.println(adv.getResident_registration());
			return "resident";
		}
		else if(data.equals("business")){
			//full_path=root_path+adv.getBusiness_license();
			System.out.println("business");
			return "business";
		}
		else if(data.equals("certificate")){
			//full_path=root_path+adv.getCertificate();
			System.out.println("certificate");
			return "certificate";
		}
		else if(data.equals("small")){
			//full_path=root_path+adv.getSmallsale();
			System.out.println("small");
			return "small";
		}
		else if(data.equals("apply")){
			return "apply";
		}
		System.out.println("else");
		return "false";
	}
	@RequestMapping(value="/executeDownLoad/{file_kind}",method=RequestMethod.GET)
	public ModelAndView executeDownLoad(HttpServletRequest request,@PathVariable String file_kind) throws InvalidFormatException, IOException{
		int rid=(int) session.getAttribute("currentPosition");
		String file_name="";
		ApplyDocVo adv=docmapper.getVoByrid(rid);
		if(file_kind.equals("resident")){
			file_name=adv.getResident_registration();
		}
		else if(file_kind.equals("business")){
			file_name=adv.getBusiness_license();
		}
		else if(file_kind.equals("certificate")){
			file_name=adv.getCertificate();
		}
		else if(file_kind.equals("small")){
			file_name=adv.getSmallsale();
		}
		else if(file_kind.equals("apply")){
			RegistrationPatentVo rv=regismapper.getRegistrationByRidOrPrevRid(rid);
			String applyDocRootPath= request.getSession().getServletContext().getRealPath("/");
			List<RegistrationFileVo> imgList=regisfilemapper.getImgListByStartRid(regismapper.getStartRidByRid(rid));
			
			file_name=docController.savefile(rv, applyDocRootPath, imgList);
			
			HashMap<String,String> map= new HashMap<String,String>();
			
			map.put("file_name", file_name);
			map.put("start_rid", Integer.toString(regismapper.getStartRidByRid(rid)));
			
			docDao.saveDocument(map);
			
			String full_path=applyDocRootPath+"/resources/uploadimgs/document/"+file_name;
			File downloadFile = new File(full_path);
			ModelAndView mav = new ModelAndView();
			mav.addObject("downloadFile", downloadFile);
		    mav.addObject("downloadFileName", file_name);
		        
		    mav.setViewName("downloadFileView");
		    return mav;
		}
		String root_path=request.getSession().getServletContext().getRealPath("resources/uploadimgs/uploadDocument/");
		String full_path=root_path+file_name;
		File downloadFile = new File(full_path);
		System.out.println(full_path);
		ModelAndView mav = new ModelAndView();
        mav.addObject("downloadFile", downloadFile);
        mav.addObject("downloadFileName", file_name);
        
        mav.setViewName("downloadFileView");
        return mav;
	}
	@RequestMapping("/test")
	public String test(){
		return "apply/downloaddocument";
	}
}
