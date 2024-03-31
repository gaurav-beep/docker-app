package com.docker.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.docker.entity.UserModel;

public interface UserRepository extends JpaRepository<UserModel, String> {
}
