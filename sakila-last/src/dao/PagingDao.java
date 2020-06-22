package dao;

import java.util.ArrayList;

import vo.Paging;

public class PagingDao {
	//하단 페이징
	public ArrayList<Paging> groupPaging(int currentPage, int pagePerGroup, int lastPage) {
		System.out.println(currentPage+"<----currentPage");
		System.out.println(pagePerGroup+"<----pagePerGroup");
		System.out.println(lastPage+"<---lastPage");
		
		int groupStartPage = 0;
		
		ArrayList<Paging> list = new ArrayList<Paging>();		
		
		
		//10의 배수일 경우
		if(currentPage % pagePerGroup == 0) {
			groupStartPage = currentPage / pagePerGroup - 1;
			System.out.println(groupStartPage+"<--- 10의 배수일경우값");
			for(int i=(groupStartPage*pagePerGroup)+1; i<=(groupStartPage*pagePerGroup)+pagePerGroup; i=i+1) {
				//현재 페이지 색 다름
				if(i==currentPage) {
					Paging p = new Paging();
					p.setPageNum(i);
					p.setPageSelect(true);
					list.add(p);
				}else {
					Paging p = new Paging();
					p.setPageNum(i);
					p.setPageSelect(false);
					list.add(p);
				}
			}
		}else {
			groupStartPage = currentPage / pagePerGroup;
			System.out.println(groupStartPage+"<--- 10의 배수가 아닐 경우");
			if(lastPage < (groupStartPage*pagePerGroup)+pagePerGroup) {
				for(int i=(groupStartPage*pagePerGroup)+1; i<=lastPage; i=i+1) {
					//현재 페이지 색 다르게
					if(i==currentPage) {
						Paging p = new Paging();
						p.setPageNum(i);
						p.setPageSelect(true);
						list.add(p);
					}else {
						Paging p = new Paging();
						p.setPageNum(i);
						p.setPageSelect(false);
						list.add(p);
					}
				}
			}else {
				for(int i=(groupStartPage*pagePerGroup)+1; i<=(groupStartPage*pagePerGroup)+pagePerGroup; i=i+1) {
					//현재 페이지 색 다르게
					if(i==currentPage) {
						Paging p = new Paging();
						p.setPageNum(i);
						p.setPageSelect(true);
						list.add(p);
					}else {
						Paging p = new Paging();
						p.setPageNum(i);
						p.setPageSelect(false);
						list.add(p);
					}
				}
			}
			
		}
		
//			for(Paging ee : list) {
//				System.out.print(ee.pageNum + " ");
//				System.out.println(ee.pageSelect);
//			}
		return list;
	}
}
