package com.project.dto;

import java.util.List;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull; 
import javax.validation.constraints.Pattern;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
public class Userinfo {
   
   @NotBlank(message = "아이디를 입력해주세요.")
   private String id;
   
   @NotNull(message = "비밀번호를 입력해주세요.")
   private String pw;
   
   @NotNull(message = "이름을 입력해주세요.")
   private String name;
    
   
   private String email;

   
   private String regdate;
   private String logdate;
   private int status;
   
   private String enabled;
   private List<SecurityAuth> securityAuthList;
  
}