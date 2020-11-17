package com.lk.controller;

import java.awt.image.RenderedImage;
import java.io.IOException;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsRequest;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsResponse;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.profile.DefaultProfile;
import com.aliyuncs.profile.IClientProfile;
import com.lk.component.GenerateCode;
import com.lk.component.PhoneRandomBuilder;

/**
 * @author: linkui
 * @Date: 2020/11/4 15:03
 * Describe: 注册获得手机验证码
 */
@Controller
public class GetPhoneCodeControl {

    @PostMapping("/getCode")
    @ResponseBody
    public int getAuthCode(HttpServletRequest request){

        String phone = request.getParameter("phone");
        String sign = request.getParameter("sign");
        String trueMsgCode = PhoneRandomBuilder.randomBuilder();

        request.getSession().setAttribute("trueMsgCode", trueMsgCode);
        request.getSession().setAttribute("msgCodePhone", phone);

        String msgCode = "SMS_136394413";
        //注册模板
        if("register".equals(sign)){
            msgCode = "SMS_136394413";
        }
        //改密码模板
        else {
            msgCode = "SMS_139982667";
        }

        SendSmsResponse sendSmsResponse = null;
        try {
            sendSmsResponse = sendSmsResponse(phone, trueMsgCode, msgCode);
        } catch (ClientException e) {
            e.printStackTrace();
            return 0;
        }

        return 1;
    }
    @GetMapping("/getCode1")
    @ResponseBody
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	  // 调用工具类生成的验证码和验证码图片
    	  Map<String, Object> codeMap = GenerateCode.generateCodeAndPic();
    	 
    	  // 将四位数字的验证码保存到Session中。
    	  HttpSession session = req.getSession();
    	  session.setAttribute("code", codeMap.get("code").toString());
    	  System.out.println("验证码是："+codeMap.get("code").toString());
    	  String phone = req.getParameter("phone");
           req.getSession().setAttribute("trueMsgCode", codeMap.get("code").toString());
          req.getSession().setAttribute("msgCodePhone", phone);
    	  // 禁止图像缓存。
    	  resp.setHeader("Pragma", "no-cache");
    	  resp.setHeader("Cache-Control", "no-cache");
    	  resp.setDateHeader("Expires", 0);
    	 
    	  resp.setContentType("image/jpeg");
    	 
    	  // 将图像输出到Servlet输出流中。
    	  ServletOutputStream sos;
    	  try {
    	   sos = resp.getOutputStream();
    	   ImageIO.write((RenderedImage) codeMap.get("codePic"), "jpeg", sos);
    	   sos.close();
    	  } catch (IOException e) {
    	   // TODO Auto-generated catch block
    	   e.printStackTrace();
    	  }
    	 
    	 }
    	 
    
    
    public static SendSmsResponse sendSmsResponse(String phoneNumber, String code, String msgCode) throws ClientException {

        //可自助调整超时时间
        System.setProperty("sun.net.client.defaultConnectTimeout", "10000");
        System.setProperty("sun.net.client.defaultReadTimeout", "10000");
        //"***"分别填写自己的AccessKey ID和Secret
        IClientProfile profile = DefaultProfile.getProfile("cn-hangzhou", "这里填AccessKey ID", "这里填AccessKey Secret");
        DefaultProfile.addEndpoint("cn-hangzhou", "cn-hangzhou", "Dysmsapi", "dysmsapi.aliyuncs.com");
        IAcsClient acsClient = new DefaultAcsClient(profile);
        SendSmsRequest request = new SendSmsRequest();
        //填写接收方的手机号码
        request.setPhoneNumbers(phoneNumber);
        //此处填写已申请的短信签名
        request.setSignName("张海洋ocean");
        //此处填写获得的短信模版CODE
        request.setTemplateCode(msgCode);
        //笔者的短信模版中有${code}, 因此此处对应填写验证码
        request.setTemplateParam("{\"code\":\"" + code + "\"}");
        SendSmsResponse sendSmsResponse = acsClient.getAcsResponse(request);

        return sendSmsResponse;
    }



}
