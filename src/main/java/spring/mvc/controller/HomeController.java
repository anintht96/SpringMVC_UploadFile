package spring.mvc.controller;

import java.io.File;
import java.io.IOException;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import spring.mvc.model.MyFile;

@Controller
public class HomeController {

	@RequestMapping(value = "/")
	public ModelAndView index(@ModelAttribute(value = "myFile") MyFile file) {
		return new ModelAndView("index");
	}

	/*
	 * @RequestMapping(value = "/uploadFile", method = RequestMethod.POST) public
	 * String uploadFile(@ModelAttribute(value = "myFile") MyFile file, Model model)
	 * { model.addAttribute("message", "Upload success.");
	 * model.addAttribute("description", file.getDescription());
	 * 
	 * try { MultipartFile multipartFile = file.getMultipartFile(); String fileName
	 * = multipartFile.getOriginalFilename(); File file2 = new File("D:/file",
	 * fileName); multipartFile.transferTo(file2); } catch (IllegalStateException |
	 * IOException e) { e.printStackTrace(); model.addAttribute("message",
	 * "upload file failed."); }
	 * 
	 * return "result"; }
	 */

	@RequestMapping(value = "/uploadFile",method = RequestMethod.POST)
	public ResponseEntity<String> uploadFile(@ModelAttribute(value = "mtFile") MyFile myFile) {

		try {
			MultipartFile multipartFile = myFile.getMultipartFile();
			String fileName = multipartFile.getOriginalFilename();
			File file = new File("D:/file", fileName);
			multipartFile.transferTo(file);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
			return new ResponseEntity<String>("failed :" +e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return new ResponseEntity<String>("Success", HttpStatus.OK);
	}

}
