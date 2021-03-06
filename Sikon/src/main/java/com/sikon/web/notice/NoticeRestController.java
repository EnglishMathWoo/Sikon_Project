package com.sikon.web.notice;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


@Controller
@RequestMapping("/notice/*")
public class NoticeRestController {
	
	///Field
	@Value("#{commonProperties['summerNote']}")
	String summerNote;
	
	
	///Constructor
	public NoticeRestController(){
		System.out.println(this.getClass());
	}
	
	
	///Method
	@PostMapping(value="/json/uploadSummernoteImageFile", produces = "application/json")
	@ResponseBody
	public Map uploadSummernoteImageFile( @RequestParam("file") MultipartFile multipartFile ) {
		
		Map map = new HashMap();
		
		String fileRoot = summerNote; //저장될 외부 파일 경로
		String originalFileName = multipartFile.getOriginalFilename(); //오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf(".")); //파일 확장자
		String savedFileName = UUID.randomUUID() + extension; //저장될 파일 명
		
		File targetFile = new File(fileRoot + savedFileName);
		
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile); //파일 저장
			map.put("url", "/summernoteImage/"+savedFileName);
			map.put("responseCode", "success");
				
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile); //저장된 파일 삭제
			map.put("responseCode", "error");
			e.printStackTrace();
		}
		
		return map;
	}
	
}