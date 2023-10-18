package com.project.dto;

import java.util.List;

import org.springframework.lang.Nullable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
/*
create table userinfo_security(id varchar2(100) primary key, pw varchar2(100)
    , name varchar2(50), email varchar2(100), enabled varchar2(1));
    
create table userinfo_security_auth(id varchar2(100), auth varchar2(50)
    , CONSTRAINT auth_id_fk foreign key(id) references userinfo_security(id));
    
create unique index auth_id_index on userinfo_security_auth(id, auth);  
*/


@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserinfoSecurity {
	/*
	@NotEmpty(groups = {UserinfoSecurityGroups.insertValid.class})
	private String id;
	@NotEmpty(groups = {UserinfoSecurityGroups.insertValid.class})
	private String pw;
	@NotEmpty(groups = {UserinfoSecurityGroups.insertValid.class, UserinfoSecurityGroups.modifyValid.class})
	private String name;
	@NotEmpty(groups = {UserinfoSecurityGroups.insertValid.class, UserinfoSecurityGroups.modifyValid.class})
	private String email;
	@NotEmpty(groups = {UserinfoSecurityGroups.modifyValid.class})
	private String enabled;
	private List<UserinfoSecurityAuth> UserinfoSecurityAuthList;
	*/
	
	@Nullable
	private String id;
	@Nullable
	private String pw;
	@Nullable
	private String name;
	@Nullable
	private String email;
	@Nullable
	private String enabled;
	private List<SecurityAuth> SecurityAuthList;

}
