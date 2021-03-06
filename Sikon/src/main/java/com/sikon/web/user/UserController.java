package com.sikon.web.user;

import java.io.File;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.sikon.common.Page;
import com.sikon.common.Search;
import com.sikon.service.alarm.AlarmService;
import com.sikon.service.coupon.CouponService;
import com.sikon.service.domain.Career;
import com.sikon.service.domain.Coupon;
import com.sikon.service.domain.License;
import com.sikon.service.domain.User;
import com.sikon.service.user.UserService;


@Controller
@RequestMapping("/user/*")
public class UserController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("alarmServiceImpl")
	private AlarmService alarmService;
	
	@Autowired
	@Qualifier("couponServiceImpl")
	private CouponService couponService;
		
	public UserController(){
		System.out.println(this.getClass());
	}

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	// 파일 업로드 저장경로
	private String FILE_SERVER_PATH= "C:\\Users\\bitcamp\\git\\Sikon_PJT\\Sikon\\src\\main\\webapp\\resources\\images\\uploadFiles";
	
	@RequestMapping( value="login", method=RequestMethod.GET )
	public String login() throws Exception{
		
		System.out.println("/user/logon : GET");

		return "redirect:/user/loginView.jsp";
	}
	
	@RequestMapping( value="login", method=RequestMethod.POST )
	public String login(@ModelAttribute("user") User user , HttpSession session, Model model ) throws Exception{
		
		System.out.println("/user/login : POST");
		
		User dbUser=userService.getUser(user.getUserId());
		
		int statusCount = alarmService.getUncheckedAlarm(user.getUserId());
				
		//탈퇴 회원 로그인 방지
		if(dbUser.getQuitStatus().equals("Y")) {
		model.addAttribute("msg","탈퇴 회원 입니다.");
		model.addAttribute("url","loginView.jsp");

		return "/user/loginFail.jsp";
		}
		
				
		// 입력한 비밀번호와 서버에 저장된 비밀번호를 확인
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
			session.setAttribute("alarm", statusCount );
			return "redirect:/index.jsp";
		} else {
			model.addAttribute("msg","비밀번호가 일치하지 않습니다.");
			model.addAttribute("url","loginView.jsp");
			return "/user/loginFail.jsp";
		}		
		
	}
	
	@RequestMapping(value="/kakaoLogin", method=RequestMethod.GET)
	public String kakaoLogin(@RequestParam(value = "code", required = false) String code, HttpSession session, Model model) throws Exception {
		
			String access_Token = userService.getAccessToken(code);
			
			HashMap<String, Object> userInfo = userService.getUserInfo(access_Token);
			
			String userId = (String)userInfo.get("email") ;
			String userNickname = (String)userInfo.get("nickname") ;

			System.out.println("/user/checkDuplication : POST");
				
			if(userService.checkDuplication(userId)==true) {  // 서버에 ID가 존재하지 않을때 새로 회원가입
				User user = new User();
				user.setUserId(userId);
				user.setUserName(userNickname);
				user.setPassword("1234");
				user.setUserNickname(userId);
				user.setMentorApply("N");
				user.setLoginPath("K");
				user.setUserImage("168939.jpg");
								
				List list = new ArrayList();
				License license = new License();
				license.setLicenseNo(0);
				license.setUserId(user.getUserId());
				License license2 = new License();
				license2.setLicenseNo(0);
				license2.setUserId(user.getUserId());
				list.add(license);
				list.add(license2);
								
				List list2 = new ArrayList();
				Career career = new Career();
				career.setCareerNo(0);
				career.setUserId(user.getUserId());
				Career career2 = new Career();
				career2.setCareerNo(0);
				career2.setUserId(user.getUserId());
				list2.add(career);
				list2.add(career2);
								
				Map map = new HashMap();
				map.put("list", list);
				map.put("list2", list2);
				
				userService.addKakaoUser(user, map);
							
			}else if(userService.getUser(userId).getQuitStatus().equals("Y")){	// 서버에 저장된 ID가 탈퇴회원일때 로그인 방지
				
				model.addAttribute("msg","탈퇴 회원 입니다.");
				model.addAttribute("url","loginView.jsp");

				return "/user/loginFail.jsp";
				
			}else {
				
				User user1 = userService.getUser(userId);
				session.setAttribute("user", user1);
			}
			
			return "redirect:/index.jsp";
	}
	
	@RequestMapping( value="logout", method=RequestMethod.GET )
	public String logout(HttpSession session ) throws Exception{
		
		System.out.println("/user/logout : POST");
		
		session.invalidate();
		
		return "redirect:/index.jsp";
	}
	
	@RequestMapping( value="findUserId", method=RequestMethod.GET )
	public String findUserId() throws Exception {

		System.out.println("/user/findUserId : GET");
		
		return "redirect:/user/findUserId.jsp";
	}
	
	@RequestMapping( value="findUserPw", method=RequestMethod.GET )
	public String findUserPw() throws Exception {

		System.out.println("/user/findUserPw : GET");
		
		
		return "redirect:/user/findUserPw.jsp";
	}
	
	
	@RequestMapping( value="updateUserpw", method=RequestMethod.GET )
	public String updateUserpw(@RequestParam( value = "userId", required = false ) String userId, Model model) throws Exception {

		System.out.println("/user/updateUserpw : GET");
		System.out.println("/user/updateUserpw : GET"+ userId);
	
		model.addAttribute("userId", userId);
		
		return "forward:/user/updateUserpw.jsp";
	}
	
	@RequestMapping( value="updateUserpw", method=RequestMethod.POST )
	public String findUserPw(HttpServletRequest request,@RequestParam("userId") String userId, @RequestParam("password") String password) throws Exception {
		
		System.out.println("/user/findUserId : POST");
				
		User user = userService.getUser(userId);
		
		userService.updateUserPw(userId, password);
		System.out.println("userId="+userId);
		System.out.println("password="+password);
		return "redirect:/user/loginView.jsp";
	}
	
		
	@RequestMapping( value="addUser", method=RequestMethod.GET )
	public String addUserView() throws Exception {

		System.out.println("/user/addUser : GET");
		
		return "redirect:/user/addUserView.jsp";
	}
	
	@RequestMapping( value="addUser", method=RequestMethod.POST )
	public String addUser(@ModelAttribute("user") User user,
			@RequestParam("licenseName") String[] licenseName,
			@RequestParam("licenseInstitution") String[] licenseInstitution,
			@RequestParam("licenseDate") String[] licenseDate,
			@RequestParam("company") String[] company,
			@RequestParam("careerExperience") String[] careerExperience,
			@RequestParam("startDate") String[] startDate,
			@RequestParam("endDate") String[] endDate,
			@RequestParam("uploadFile")  MultipartFile file, Model model) throws Exception {

		System.out.println("/user/addUser : POST");
		
		List list = new ArrayList();
		for ( int j=0 ; j<licenseName.length ; j++) {
			License license = new License();
			license.setLicenseName(licenseName[j]);
			license.setLicenseInstitution(licenseInstitution[j]);
			license.setLicenseDate(licenseDate[j]);
			license.setUserId(user.getUserId());
			list.add(license);
		}
				
		List list2 = new ArrayList();
			for ( int m=0 ; m<company.length ; m++) {
			Career career = new Career();
			career.setCompany(company[m]);
			career.setCareerExperience(careerExperience[m]);
			career.setStartDate(startDate[m]);
			career.setEndDate(endDate[m]);
			career.setUserId(user.getUserId());
			list2.add(career);
		}
				
		Map map = new HashMap();
		map.put("list", list);
		map.put("list2", list2);
		
		
		if(!file.getOriginalFilename().isEmpty()) {
			file.transferTo(new File(FILE_SERVER_PATH, file.getOriginalFilename()));
			model.addAttribute("msg", "File uploaded successfully.");
			user.setUserImage(file.getOriginalFilename());
		}else {
			model.addAttribute("msg", "Please select a valid mediaFile..");
			user.setUserImage("168939.jpg");
		}
		
		
		userService.addUser(user, map);
			
		return "redirect:/user/loginView.jsp";
	}
	
	@RequestMapping( value="getUser", method=RequestMethod.GET )
	public String getUser( @RequestParam("userId") String userId , Model model, HttpServletRequest request ) throws Exception {
		
		System.out.println("/user/getUser : GET");
		
		User user = userService.getUser(userId);
		List list = userService.getLicense(userId);
		List list2 = userService.getCareer(userId);
				
		model.addAttribute("user", user);
		model.addAttribute("license", list);
		model.addAttribute("career", list2);

		return "forward:/user/getUser.jsp";
	}
	
	@RequestMapping( value="updateUser", method=RequestMethod.GET )
	public String updateUser( @RequestParam("userId") String userId , Model model ) throws Exception{

		System.out.println("/user/updateUser : GET");
		
		User user = userService.getUser(userId);
		List license = userService.getLicense(userId);
		List career = userService.getCareer(userId);
		
		// Model 과 View 연결
		model.addAttribute("user", user);
		model.addAttribute("license", license);
		model.addAttribute("career", career);
		
		return "forward:/user/updateUser.jsp";
	}
	
	@RequestMapping( value="updateUser", method=RequestMethod.POST )
	public String updateUser( @ModelAttribute("user") User user ,
			@RequestParam(value="licenseNo",  defaultValue="0") int[] licenseNo,
			@RequestParam(value="licenseName",  required=false) String[] licenseName,
			@RequestParam(value="licenseInstitution", required=false) String[] licenseInstitution,
			@RequestParam(value="licenseDate", required=false) String[] licenseDate,
			@RequestParam(value="careerNo", defaultValue="0") int[] careerNo,
			@RequestParam(value="company", required=false) String[] company,
			@RequestParam(value="careerExperience", required=false) String[] careerExperience,
			@RequestParam(value="startDate", required=false) String[] startDate,
			@RequestParam(value="endDate", required=false) String[] endDate,
			@RequestParam("uploadFile")  MultipartFile file, Model model , HttpServletRequest request, HttpSession session) throws Exception{

		System.out.println("/user/updateUser : POST");
		
		System.out.println(user.getAddr());
		
		if(!file.getOriginalFilename().isEmpty()) {
			file.transferTo(new File(FILE_SERVER_PATH, file.getOriginalFilename()));
			model.addAttribute("msg", "File uploaded successfully.");
		}else {
			model.addAttribute("msg", "Please select a valid mediaFile..");
		}
		
		user.setUserImage(file.getOriginalFilename());
			
		userService.updateUser(user);
		
			
		
		if(user.getRole().equals("mentor") || user.getMentorApply().equals("Y") ) {
			
		List list = new ArrayList();
		for ( int j=0 ; j<licenseName.length ; j++) {
			License license = new License();
			license.setLicenseName(licenseName[j]);
			license.setLicenseInstitution(licenseInstitution[j]);
			System.out.println("아아아"+licenseDate[j]);
			license.setLicenseDate(licenseDate[j]);
			System.out.println("===== 여기는 되고 =====");
			license.setLicenseNo(licenseNo[j]);
			System.out.println("===== 여기는 안될듯 =====");
			license.setUserId(user.getUserId());
			list.add(license);
			
		}
		
		List list2 = new ArrayList();
		for ( int m=0 ; m<company.length ; m++) {
			Career career = new Career();
			career.setCompany(company[m]);
			career.setCareerExperience(careerExperience[m]);
			career.setStartDate(startDate[m]);
			career.setEndDate(endDate[m]);
			career.setCareerNo(careerNo[m]);
			career.setUserId(user.getUserId());
			list2.add(career);
			
		}

		System.out.println("list=" + list);
		System.out.println("list2=" + list2);
		
		Map map = new HashMap();
		map.put("list", list);
		map.put("list2", list2);
		
		userService.updateLicense(map, user);
		userService.updateCareer(map, user);
		
		}
		
		return "redirect:/user/getUser?userId="+user.getUserId();
	}
	
	
	@RequestMapping( value="listUser" )
	public String listUser( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/user/listUser : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		
		Map<String , Object> map=userService.getUserList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("resultPage="+resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/user/listUser.jsp";
	}
	
	
	@RequestMapping( value="deleteUser", method=RequestMethod.GET )
	public String deleteUser(  @RequestParam(value = "userId", required = false) String userId ,
			@RequestParam(value = "quitDate", required = false) Date quitDate, 
			@RequestParam(value = "quitStatus", required = false) String quitStatus, Model model ) throws Exception{

		
		User user = userService.getUser(userId);
				
		model.addAttribute("user", user);
		model.addAttribute("quitDate", quitDate);
		model.addAttribute("quitStatus", quitStatus);
				
		return "forward:/user/deleteUser.jsp";
	}
	
	@RequestMapping( value="deleteUser", method=RequestMethod.POST )
	public String deleteUser(@ModelAttribute("user") User user , HttpSession session, HttpServletRequest request, Model model,
									@RequestParam("quitStatus") String quitStatus) throws Exception{
		
		System.out.println("/user/deleteUser : POST");
		
		System.out.println("user="+user);
	
		System.out.println("quitStatus="+quitStatus);
		
		User dbUser=userService.getUser(user.getUserId());
		
		Date quitDate = user.getQuitDate();
				
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
			
			System.out.println("userID 1="+dbUser.getPassword());
			
			System.out.println("userID 2="+user.getPassword());
			
			quitStatus = user.setQuitStatus("Y");
			
			quitDate = user.setQuitDate(dbUser.getRegDate());
			
			userService.deleteUser(user, quitDate, quitStatus);
		}
				
		session.invalidate();
		
		return "redirect:/index.jsp";
	}
	
}