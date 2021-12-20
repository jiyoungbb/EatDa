package com.project.eatda.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.eatda.dto.BlogDto;

@Repository
public class BlogDaoImpl implements BlogDao{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<BlogDto> blogList(){
		List<BlogDto> list = new ArrayList<BlogDto>();
		try {
			list = sqlSession.selectList(NAMESPACE+"blogList");
		} catch (Exception e) {
			System.out.println("[error]: blog list");
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public BlogDto selectOne(int blog_no) {
		BlogDto dto = null;
		try {
			dto = sqlSession.selectOne(NAMESPACE+"blogDetail",blog_no);
		} catch (Exception e) {
			System.out.println("[error] : blog detail");
			e.printStackTrace();
		}
		
		return dto;
	}
	
}