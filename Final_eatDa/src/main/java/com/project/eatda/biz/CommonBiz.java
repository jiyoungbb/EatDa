package com.project.eatda.biz;

import java.util.List;

import com.project.eatda.dto.ProductDto;
import com.project.eatda.dto.RecipeDto;

public interface CommonBiz {
	
	public List<ProductDto> getMarketData();
	
	public List<RecipeDto> getRecentRecipe();

}