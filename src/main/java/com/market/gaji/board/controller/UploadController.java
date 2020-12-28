package com.market.gaji.board.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.market.gaji.board.domain.AttachFileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {
	
	// Ajax를 이용하는 파일 업로드
	@GetMapping("/uploadAjax")
	public String uploadAjax() {
		log.info("upload ajax");
		return "uploadAjax";
	}
	
	// 년,월,일 단위의 폴더 생성
	private	String getFolder() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = sdf.format(date);
		
		return str.replace("-", File.separator); // 오늘 날짜의 경로를 문자열로 생성, 이미 있다면 있는 것으로 반환
	}
	
	// 섬네일 생성 판단 - 이미지 파일이니?
	private boolean checkImageType(File file) { // 파일을 받아서
		
		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	@PostMapping(value="/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE) // JSON 데이터를 반환
	@ResponseBody // JSON 데이터를 반환해야하므로 추가한 것
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		
		List<AttachFileDTO> list = new ArrayList<>();
		
		String uploadFolder = "/Users/dabin/upload/temp";
		String uploadFolderPath = getFolder();
		
		// 폴더 생성 체크
		File uploadPath = new File(uploadFolder, uploadFolderPath); // 지정해준 경로에 오늘 날짜로 만든 경로를 합쳐 경로를 저장해라
		
		if(uploadPath.exists() == false) { // 해당하는 날짜의 폴더가 존재하지 않는다면
			uploadPath.mkdirs(); // 폴더를 만들어줘
		}
		
		// 폼에서 받은 값 꺼내오고 저장하기
		for(MultipartFile multipartFile : uploadFile) {
			
			AttachFileDTO attachDTO = new AttachFileDTO(); // 객체 생성
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("/") + 1); // 파일 이름만 잘라냄
			log.info("only file name: " + uploadFileName);
			attachDTO.setFileName(uploadFileName); // 파일명 추가
			
			// 파일명 중복 방지를 위한 처리
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName; // 파일명: uuid값_실제 파일명
			
			try {
				File saveFile = new File(uploadPath, uploadFileName); // 새로 생성된 폴더에 저장되도록 변경
				multipartFile.transferTo(saveFile);
				
				attachDTO.setUuid(uuid.toString()); // uuid 추가
				attachDTO.setUploadPath(uploadFolderPath); // 업로드경로 추가
				
				// 이미지인지 판단 후, 이미지면 섬네일 생성
				if(checkImageType(saveFile)) {
					
					attachDTO.setImage(true); // 이미지 여부 추가
					
					FileOutputStream thumbnail = 
							new FileOutputStream(new File(uploadPath, "s_" + uploadFileName)); // 섬네일 이미지 파일 앞에 s_가 붙도록 해라
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 200, 200); // 크기 지정
					thumbnail.close();
				}
				list.add(attachDTO);
			} catch(Exception e) {
				e.printStackTrace();
			}
			
		}
		return new ResponseEntity<>(list, HttpStatus.OK);
	}

	// 섬네일 데이터 전송하기
	// 특정한 파일 이름을 받아서 이미지 데이터를 전송
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) { // 파일 이름을 받음 (파일 경로가 포함된!!)
		
		log.info("fileName: " + fileName);
		
		File file = new File("/Users/dabin/upload/temp/" + fileName);
		
		log.info("file: " + file);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch(IOException e) {
			e.printStackTrace();
		}
		return result; // 이미지 데이터 전송
	}
	
	// 첨부파일 다운로드
	@GetMapping(value="/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE) // MIME 타입: 다운로드
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, // HTTP 헤더 메세지의 내용을 받아 저장
												 String fileName) { // 파일 이름을 받아서
		
		Resource resource = new FileSystemResource("/Users/dabin/upload/temp/" + fileName); // 받은 파일명까지해서 경로 반환
		
		if(resource.exists() == false) { // 경로에 아무것도 없으면
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		String resourceName = resource.getFilename(); // 파일 이름만 가져와서 저장
		
		// 파일 다운 받을 때, uuid 삭제하고 받아지도록 설정
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1); // uuid 붙은 파일명에서 _+1 이후로 짤라라
		
		HttpHeaders headers = new HttpHeaders();
		
		try {
			String downloadName = null;
			
			if(userAgent.contains("Trident")) { // IE브라우저
				log.info("IE browser");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8").replaceAll("/+", " ");
			} else if(userAgent.contains("Edge")) { // 엣지
				log.info("Egde browser");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8");
				log.info("Edge name: " + downloadName);
			} else { // 크롬
				log.info("Chrome browser");
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
			}
			
			headers.add("Content-Disposition", "attachment; filename=" + downloadName);
			
		} catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
	// 서버에서 첨부파일 삭제
	@PostMapping("/deleteFile")
	@ResponseBody
	public void deleteFile(String fileName, String type) {
		log.info("deleteFile: " + fileName);
		
		File file;
		
		try {
			file = new File("/Users/dabin/upload/temp/" + URLDecoder.decode(fileName, "UTF-8"));
			
			file.delete(); // 원본 파일 지우고
			
			if(type.equals("image")) {
				
				String largeFileName = file.getAbsolutePath().replace("s_", "");
				
				log.info("largeFileName: " + largeFileName);
				
				file = new File(largeFileName); 
				
				file.delete(); // 썸네일 지우고
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			//return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		//return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	
	
	
	
	
}
