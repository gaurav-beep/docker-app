package com.docker.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

import lombok.Data;

@Entity
@Data
public class UserModel {
@Id
@Column(name="username", unique = true)
private String username;

@Column(name="password")
private String password;

@Column(name="roles")
private String roles;

@Column(name="email")
private String email;
}