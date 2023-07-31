package hotel.vo;

import java.util.Arrays;

import oracle.sql.BLOB;

public class Image {

		private int id;
		private byte[] picture;
		private String filename;
		private String explain;
		private int product_id;
		private int picnum;
		private String pictureCode;
		private String title;
		
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		public byte[] getPicture() {
			return picture;
		}
		public void setPicture(byte[] picture) {
			this.picture = picture;
		}
		public String getFilename() {
			return filename;
		}
		public void setFilename(String filename) {
			this.filename = filename;
		}
		public String getExplain() {
			return explain;
		}
		public void setExplain(String explain) {
			this.explain = explain;
		}
		public int getProduct_id() {
			return product_id;
		}
		public void setProduct_id(int product_id) {
			this.product_id = product_id;
		}
		public int getPicnum() {
			return picnum;
		}
		public void setPicnum(int picnum) {
			this.picnum = picnum;
		}
		public String getPictureCode() {
			return pictureCode;
		}
		public void setPictureCode(String pictureCode) {
			this.pictureCode = pictureCode;
		}
		public String getTitle() {
			return title;
		}
		public void setTitle(String title) {
			this.title = title;
		}
		@Override
		public int hashCode() {
			final int prime = 31;
			int result = 1;
			result = prime * result
					+ ((explain == null) ? 0 : explain.hashCode());
			result = prime * result
					+ ((filename == null) ? 0 : filename.hashCode());
			result = prime * result + id;
			result = prime * result + picnum;
			result = prime * result + Arrays.hashCode(picture);
			result = prime * result
					+ ((pictureCode == null) ? 0 : pictureCode.hashCode());
			result = prime * result + product_id;
			result = prime * result + ((title == null) ? 0 : title.hashCode());
			return result;
		}
		@Override
		public boolean equals(Object obj) {
			if (this == obj)
				return true;
			if (obj == null)
				return false;
			if (getClass() != obj.getClass())
				return false;
			Image other = (Image) obj;
			if (explain == null) {
				if (other.explain != null)
					return false;
			} else if (!explain.equals(other.explain))
				return false;
			if (filename == null) {
				if (other.filename != null)
					return false;
			} else if (!filename.equals(other.filename))
				return false;
			if (id != other.id)
				return false;
			if (picnum != other.picnum)
				return false;
			if (!Arrays.equals(picture, other.picture))
				return false;
			if (pictureCode == null) {
				if (other.pictureCode != null)
					return false;
			} else if (!pictureCode.equals(other.pictureCode))
				return false;
			if (product_id != other.product_id)
				return false;
			if (title == null) {
				if (other.title != null)
					return false;
			} else if (!title.equals(other.title))
				return false;
			return true;
		}
		@Override
		public String toString() {
			return "Image [id=" + id + ", picture=" + Arrays.toString(picture)
					+ ", filename=" + filename + ", explain=" + explain
					+ ", product_id=" + product_id + ", picnum=" + picnum
					+ ", pictureCode=" + pictureCode + ", title=" + title + "]";
		}
		public Image() {
			super();
		}
		
		
		
}
