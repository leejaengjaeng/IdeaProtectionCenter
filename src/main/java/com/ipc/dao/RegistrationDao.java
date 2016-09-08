package com.ipc.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ipc.vo.RegistrationPatentVo;

@Mapper
public interface RegistrationDao {
	public void makeidea(HashMap<String,String> map);
	public List<RegistrationPatentVo>getInventorProcessList(int uid);
	public List<RegistrationPatentVo> getPlProcessList(int lid);
	public List<RegistrationPatentVo> getAssociatedMembers(int start_rid);
	
	public List<RegistrationPatentVo> getAssociatedProcessList(int start_rid);
	public RegistrationPatentVo getInventorProcessByRid(int rid);
	public RegistrationPatentVo getPrevCommentByPrevRid(int prev_rid);
	public RegistrationPatentVo getPlProcessByRid(int rid);
	
}