package main.java.dto;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * datagrid参数
 * @author shenda20467
 *
 */
public class Page {
	
	private Integer page;//当前页
	
	private Integer rows;//每页记录数

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public Integer getRows() {
		return rows;
	}

	public void setRows(Integer rows) {
		this.rows = rows;
	}

    //page参数
	public static Map<Object, Object> newPage(HttpServletRequest request) {    	
    	Map<Object, Object> p = new HashMap<Object, Object>();
    	String page = request.getParameter("page");
    	String rows = request.getParameter("rows");
    	p.put("page", page == null ? 1 : Integer.parseInt(page));
    	p.put("rows", rows == null ? 10 : Integer.parseInt(rows));
    	p.put("offset", Integer.parseInt(p.get("rows").toString()) * (Integer.parseInt(p.get("page").toString()) - 1));
    	p.put("limit", p.get("rows")); 
        return p;
    }
}
