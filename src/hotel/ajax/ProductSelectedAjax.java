package hotel.ajax;

import hotel.dao.SelectDao;
import hotel.vo.Product;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionSupport;

public class ProductSelectedAjax extends ActionSupport {

	private Logger log = Logger.getLogger(ProductSelectedAjax.class);
	private Product product;
	private String [] types;
	
	private SelectDao sdao = new SelectDao();
	
	public String productSelected(){
		product = sdao.getProductById(product.getId());
		types= product.getRoomTypes().split("_");
		return SUCCESS;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public String[] getTypes() {
		return types;
	}

	public void setTypes(String[] types) {
		this.types = types;
	}
	
}
