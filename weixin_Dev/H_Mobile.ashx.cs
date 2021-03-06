﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;

namespace MobilePlatform
{
    /// <summary>
    /// H_Mobile 的摘要描述
    /// </summary>
    public class H_Mobile : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
           // context.Response.Write("Hello World");
            string postString = string.Empty;
            if (HttpContext.Current.Request.HttpMethod.ToUpper() == "POST")
            {
                //using (Stream stream = HttpContext.Current.Request.InputStream)
                //{
                //    Byte[] postBytes = new Byte[stream.Length];
                //    stream.Read(postBytes, 0, (Int32)stream.Length);
                //    postString = Encoding.UTF8.GetString(postBytes);
                //}
                //if (!string.IsNullOrEmpty(postString))
                //{
                //   // Execute(postString);
                //}
            }
            else
            {
                //Auth();
                ResponseMsg();
            }
        }
        /// <summary>          
        /// 成为开发者的第一步，验证并相应服务器的数据         
        /// </summary>          

        private void Auth()          
        {  
            
            //公众平台上开发者设置的token, corpID, EncodingAESKey
            string sToken = "TNIOA";
            string sCorpID = "wx799c5657be0b5f24";
            string sEncodingAESKey = "ihJhh7NxQwI5CjRIbLpbEbv0ptBaqYVbuyLfQDr0A8s";
            WXBizMsgCrypt wxcpt = new WXBizMsgCrypt(sToken, sEncodingAESKey, sCorpID);

            string sVerifyMsgSig = HttpContext.Current.Request.QueryString["msg_signature"];
            string sVerifyTimeStamp = HttpContext.Current.Request.QueryString["timestamp"];
            //企业号的 msg_signature   
            string sVerifyNonce = HttpContext.Current.Request.QueryString["nonce"];
            string sVerifyEchoStr = HttpContext.Current.Request.QueryString["echostr"];

            string sEchoStr = "";
            int ret = wxcpt.VerifyURL(sVerifyMsgSig, sVerifyTimeStamp, sVerifyNonce, sVerifyEchoStr, ref sEchoStr);
            string path = HttpContext.Current.Request.MapPath("./log.txt");
            StreamWriter sw = new StreamWriter(path);
            string str = "msg_signature：" + sVerifyMsgSig + "timestamp：" + sVerifyTimeStamp + "nonce：" + sVerifyNonce + "sVerifyEchoStr：" + sVerifyEchoStr;
            str += "sEchoStr：" + sEchoStr;
            sw.Write(str);
            sw.Close();
            if (ret != 0)
            {
                
                //System.Console.WriteLine("ERR: VerifyURL fail, ret: " + ret);
                //return;
            }
            else
            {
                if (!string.IsNullOrEmpty(sEchoStr))
                {
                    HttpContext.Current.Response.Write(sEchoStr);
                    HttpContext.Current.Response.End();
                }
            }
            //if (new CorpBasicApi().CheckSignature(token, signature, timestamp, nonce, corpId, encodingAESKey, echoString, ref decryptEchoString))           
            //{                 
            //    if (!string.IsNullOrEmpty(decryptEchoString))                
            //    {                     
            //        HttpContext.Current.Response.Write(decryptEchoString);         
            //        HttpContext.Current.Response.End();             
            //    }     
            //}        
        }

        private void ResponseMsg()
        {
            //公众平台上开发者设置的token, corpID, EncodingAESKey
            string sToken = "TNIOA";
            string sCorpID = "wx799c5657be0b5f24";
            string sEncodingAESKey = "ihJhh7NxQwI5CjRIbLpbEbv0ptBaqYVbuyLfQDr0A8s";
            WXBizMsgCrypt wxcpt = new WXBizMsgCrypt(sToken, sEncodingAESKey, sCorpID);

            string sVerifyMsgSig = HttpContext.Current.Request.QueryString["msg_signature"];
            string sVerifyTimeStamp = HttpContext.Current.Request.QueryString["timestamp"];
            //企业号的 msg_signature   
            string sVerifyNonce = HttpContext.Current.Request.QueryString["nonce"];
            string sVerifyEchoStr = HttpContext.Current.Request.QueryString["echostr"];

            string sMsg = "";
            int ret = wxcpt.DecryptMsg(sVerifyMsgSig, sVerifyTimeStamp, sVerifyNonce, sVerifyEchoStr, ref sMsg);

            //if (sMsg = "?")
            string path = HttpContext.Current.Request.MapPath("./log.txt");
            StreamWriter sw = new StreamWriter(path);
            string str = "msg_signature：" + sVerifyMsgSig + "timestamp：" + sVerifyTimeStamp + "nonce：" + sVerifyNonce + "sVerifyEchoStr：" + sVerifyEchoStr;
            str += "sMsg：" + sMsg;
            sw.Write(str);
            sw.Close();        


        }



        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}