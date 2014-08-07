<?php
function getXiaoiInfo($openid, $content)
 2 {
 3     //定?app
 4     $app_key="************";
 5     $app_secret="********************";
 6 
 7     //?名算法
 8     $realm = "xiaoi.com";
 9     $method = "POST";
10     $uri = "/robot/ask.do";
11     $nonce = "";
12     $chars = "abcdefghijklmnopqrstuvwxyz0123456789";
13     for ($i = 0; $i < 40; $i++) {
14         $nonce .= $chars[ mt_rand(0, strlen($chars) - 1) ];
15     }
16     $HA1 = sha1($app_key.":".$realm.":".$app_secret);
17     $HA2 = sha1($method.":".$uri);
18     $sign = sha1($HA1.":".$nonce.":".$HA2);
19 
20     //接口?用
21     $url = "http://nlp.xiaoi.com/robot/ask.do";
22     $ch = curl_init();
23     curl_setopt($ch, CURLOPT_URL, $url);
24     curl_setopt($ch, CURLOPT_HTTPHEADER, array('X-Auth:    app_key="'.$app_key.'", nonce="'.$nonce.'", signature="'.$sign.'"'));
25     curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
26     curl_setopt($ch, CURLOPT_POST, 1);
27     curl_setopt($ch, CURLOPT_POSTFIELDS, "question=".urlencode($content)."&userId=".$openid."&platform=custom&type=0");
28     $output = curl_exec($ch);
29     if ($output === FALSE){
30         return "cURL Error: ". curl_error($ch);
31     }
32     return trim($output);
33 }

private function receiveText($object)
2     {
3         $keyword = trim($object->Content);
4         include("xiaoi.php");
5         $content = getXiaoiInfo($object->FromUserName, $keyword);
6         $result = $this->transmitText($object, $content);
7         return $result;
8     }
?>