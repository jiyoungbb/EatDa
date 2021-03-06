package com.project.eatda.controller;


import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;
import com.project.eatda.biz.RecipeBiz;
import com.project.eatda.dto.RecipeDto;
import com.project.eatda.dto.RecipePageBaseDto;
import com.project.eatda.dto.RecipePageDto;

@Controller
public class RecipeController {
	private static final Logger logger = LoggerFactory.getLogger(RecipeController.class);
	
	@Autowired
	private RecipeBiz biz;
	
	@RequestMapping("/recipeList.do")
	public String recipeList(Model model, RecipePageBaseDto rpbdto) {
		logger.info("RECIPE LIST");
		
		RecipePageDto rpdto = new RecipePageDto(rpbdto, biz.getTotal(rpbdto));
		
		model.addAttribute("rpdto", rpdto);
		model.addAttribute("list", biz.recipeList(rpbdto));
		
		return "/recipe/recipeList";
	}
	

	@RequestMapping("/recipeDetail.do")
	public String recipeDetail(Model model, int recipe_no) {
		logger.info("RECIPE DETAIL");
		
		model.addAttribute("dto", biz.recipeDetail(recipe_no));
		
		//์กฐํ์ +1
		biz.updateRecipeCount(recipe_no);
		return "/recipe/recipeDetail";
	}
	
	@RequestMapping("/recipeInsert.do")
	public String recipeInsert() {
		logger.info("RECIPE INSERT");
		
		return "/recipe/recipeInsert";
	}
	
	@RequestMapping("/recipeInsertRes.do")
	public String recipeInsertRes(RecipeDto dto) {
		logger.info("RECIPE INSERT RESULT");
 
		int res = biz.recipeInsert(dto);
		
		if(res>0){			
			return "redirect:recipeList.do";
		}else {
			return "redirect:recipeInsert.do";
		}
	}
	
	@RequestMapping("/recipeUpdateForm.do")
	public String recipeUpdateForm(Model model, int recipe_no) {
		logger.info("RECIPE UPDATE FORM");
		
		model.addAttribute("dto",biz.recipeDetail(recipe_no));
		return "/recipe/recipeUpdateForm";
	}
	
	@RequestMapping("/recipeupdateRes.do")
	public String recipeUpdateRes(RecipeDto dto) {
		logger.info("RECIPE UPDATE RESULT");
		
		int res = biz.recipeUpdate(dto);
		if(res>0) {
			return "redirect:recipeDetail.do?recipe_no="+dto.getRecipe_no();
		}else {
			return "redirect:recipeUpdateForm.do?recipe_no="+dto.getRecipe_no();			
		}
	}
	
	@RequestMapping("/deleteConfirm.do")
	public String deleteConfirm(int recipe_no) {
		logger.info("RECIPE DELETE CONFIRM");
		
		return "recipe/deleteConfirm";
	}
	@RequestMapping("/recipeDelete.do")
	public String recipeDelete(int recipe_no) {
		logger.info("RECIPE DELETE");
		
		int res = biz.recipeDelete(recipe_no);
		if(res>0) {
			return "redirect:recipeList.do";
		}else {
			return "redirect:recipeDetail.do?recipe_no="+recipe_no;
		}
	}
	
	
	
	//์ธ๋จธ๋ธํธ ํ์ผ์ฒ๋ฆฌ
	@RequestMapping(value="/uploadSummernoteImageFile.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request )  {
		JsonObject jsonObject = new JsonObject();
		
		// ๋ด๋ถ๊ฒฝ๋ก๋ก ์?์ฅ
		String contextRoot = new HttpServletRequestWrapper(request).getRealPath("/");
		String fileRoot = contextRoot+"resources/images/recipe/"; //์๋ฒ์ ์ด๋ฏธ์ง ์?์ฅ
		System.out.println(fileRoot);
		
		String originalFileName = multipartFile.getOriginalFilename();	//์ค๋ฆฌ์ง๋ ํ์ผ๋ช
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//ํ์ผ ํ์ฅ์
		String savedFileName = UUID.randomUUID() + extension;	//์?์ฅ๋? ํ์ผ๋ช
		
		File targetFile = new File(fileRoot + savedFileName);	
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);	//ํ์ผ ์?์ฅ
			jsonObject.addProperty("url", "resources/images/recipe/"+savedFileName); // contextroot + resources + ์?์ฅํ? ๋ด๋ถ ํด๋๋ช
			jsonObject.addProperty("responseCode", "success");

		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);	//์?์ฅ๋ ํ์ผ ์ญ์?
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		String a = jsonObject.toString();
		return a;
	}
	

}
