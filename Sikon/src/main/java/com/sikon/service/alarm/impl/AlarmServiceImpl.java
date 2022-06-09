package com.sikon.service.alarm.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.sikon.common.Search;
import com.sikon.service.purchase.PurchaseService;
import com.sikon.service.purchase.PurchaseDao;
import com.sikon.service.alarm.AlarmDao;
import com.sikon.service.alarm.AlarmService;
import com.sikon.service.domain.Alarm;
import com.sikon.service.domain.Purchase;
import com.sikon.service.domain.User;


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

	public Map<String , Object > getAlarmList(Search search) throws Exception {
		List<Alarm> list= alarmDao.getAlarmList(search);
		int totalCount = alarmDao.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

}