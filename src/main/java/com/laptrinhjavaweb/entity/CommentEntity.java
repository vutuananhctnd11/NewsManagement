package com.laptrinhjavaweb.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="comment")
public class CommentEntity extends BaseEntity {

	@Column(name="content")
	private String content;
	
	@Column(name="likecomment")
	private long likeComment;
	
	@Column(name="userid")
	private long userId;
	
	@Column(name="newsid")
	private long newsId;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "newsid", insertable=false, updatable=false)
	private NewsEntity news;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "userid", insertable=false, updatable=false)
	private UserEntity user;
	
	

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

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public long getNewsId() {
		return newsId;
	}

	public void setNewsId(long newsId) {
		this.newsId = newsId;
	}

	public NewsEntity getNews() {
		return news;
	}

	public void setNews(NewsEntity news) {
		this.news = news;
	}

	public UserEntity getUser() {
		return user;
	}

	public void setUser(UserEntity user) {
		this.user = user;
	}
	
	
	
}
