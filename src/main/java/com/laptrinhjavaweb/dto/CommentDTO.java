package com.laptrinhjavaweb.dto;

public class CommentDTO extends AbstractDTO<CommentDTO> {

	private String content;
	private long likeComment;
	private long userId;
	private String userName;
	private long newsId;
	private String newsTitle;
	
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public long getLikeComment() {
		return likeComment;
	}
	public void setLikeComment(long likeComment) {
		this.likeComment = likeComment;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getNewsTitle() {
		return newsTitle;
	}
	public void setNewsTitle(String newsTitle) {
		this.newsTitle = newsTitle;
	}
	public long getNewsId() {
		return newsId;
	}
	public void setNewsId(long newsId) {
		this.newsId = newsId;
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	
	
}
