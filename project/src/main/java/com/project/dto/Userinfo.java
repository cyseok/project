package com.project.dto;

import java.util.List;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;

import lombok.Data;

@Data
public class Userinfo {
/*
 @NotNull(기본값) : 필드의 값이 null이 아닌지 확인. 따라서 ""이나 공백을 포함한 빈 문자열도 허용됩니다.
 @NotEmpty는 필드의 값이 null이 아니고, 빈 문자열이 아닌지 확인. 따라서 공백을 포함한 빈 문자열은 허용되지 않습니다.
 @NotBlank는 필드의 값이 null이 아니고, 공백이 아닌 문자열인지 확인. 따라서 공백이 포함된 문자열은 허용되지 않습니다.
 */
   
   @NotBlank
   private String id;
   
   @NotBlank
   private String pw;
   
   @NotEmpty
   private String name;
   
   @NotEmpty
   private String nickname;
   
   @NotEmpty
   private String birth;
   
   @NotEmpty
   private String address;
    
   @NotBlank
   @Email
   private String email;

   private String regdate;
   private String logdate;
   private int status;
   private String enabled;
   
   private List<UserinfoAuth> securityAuthList;
  
}