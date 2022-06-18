package com.sikon.service.alarm.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.sikon.common.Search;
import com.sikon.service.alarm.AlarmDao;
import com.sikon.service.alarm.AlarmService;
import com.sikon.service.domain.Alarm;

@Service("alarmServiceImpl")
public class AlarmServiceImpl implements AlarmService{
	
	///Field
	@Autowired
	@Qualifier("alarmDaoImpl")
	private AlarmDao alarmDao;

	
	/// Constructor
	public AlarmServiceImpl() {
		System.out.println(this.getClass());
	}


	///Method
	public void addAlarm(Alarm Alarm) throws Exception {
		alarmDao.insertAlarm(Alarm);
	}

	public Map<String , Object> getAlarmList(Search search, String userId) throws Exception {
		List<Alarm> list= alarmDao.getAlarmList(search, userId);
		int totalCount = alarmDao.getAlarmCount(userId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", totalCount);
		
		return map;
	}
	
	public int getAlarmCount(String userId) throws Exception {
		
		int alarmCount = alarmDao.getAlarmCount(userId);
				
		return alarmCount;
	}
	
	//미확인 알람 개수
	public int getStatusCount(String userId) throws Exception {
		
		int statusCount = alarmDao.getStatusCount(userId);
				
		return statusCount;
	}
	
	public void updateAlarmStatus(Alarm alarm) throws Exception{
		alarmDao.updateAlarmStatus(alarm);
	}

}