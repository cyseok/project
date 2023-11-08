package com.project.dto;

import java.util.List;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull; 
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
public class Userinfo {
   
   @NotBlank(message = "아이디를 입력해주세요.")
   @Pattern(regexp = "^[A-Za-z]{1}[A-Za-z0-9]{3,19}$",
   message = "아이디는 영문, 숫자만 가능하며 4 ~ 20자리까지 가능합니다.")
   private String id;
   
   @NotNull(message = "비밀번호를 입력해주세요.")
   @Pattern(regexp = "^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$",
   message = "비밀번호는 8~16자의 영문 대소문자 숫자 및 특수문자를 최소 하나씩 입력해주세요.")
   private String pw;
   
   @NotNull(message = "이름을 입력해주세요.")
   private String name;
    
   @NotBlank(message = "이메일을 반드시 입력해주세요.")
   @Email(message = "이메일을 형식에 맞게 입력해주세요.")
   private String email;

   
   private String regdate;
   private String logdate;
   private int status;
   
   private String enabled;
   
   // 비빌번호 변경
   @Size(min = 8, max = 12, message = "현재 비밀번호를 입력해주세요.")
   @Pattern(regexp = "^(?=.*[0-9a-zA-Z@#$%^&+=!]).{6,}$")
   private String currentPassword;
	
   @Size(min = 8, max = 12, message = "비밀번호는 8자~12자 사이여야 합니다.")
   @Pattern(regexp = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,12}$", message = "비밀번호는 영어 대소문자, 숫자, 특수문자가 꼭 포함되어야 합니다.")
   private String newPassword;

   private String confirmPassword;
	
   private List<SecurityAuth> securityAuthList;
  
}