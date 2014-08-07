<?php
/*
* array unique_rand( int $min, int $max, int $num )
* 生成一定?量的不重复?机?
* $min 和 $max: 指定?机?的范?
* $num: 指定生成?量
*/

function unique_rand($min,$max,$num){
$count = 0;
$return_arr = array();
while($count < $num){
$return_arr[] = mt_rand($min,$max);
$return_arr = array_flip(array_flip($return_arr));
$count = count($return_arr);
}
shuffle($return_arr);
return $return_arr;
}



function create_number($min,$max,$num) {
$count = 0;
$number = array();
while ($count <= $num) {
$number[] = mt_rand($min,$max);
$number = array_flip(array_flip($number));
$count = count($number);
}
shuffle($number);
return $number;
}

?>


<?php
echo strlen("hello,world");
echo strpos("Hello world!","world");
?>


<?php//define
define("GREETING", "Welcome to W3School.com.cn!");
echo GREETING;
?>
<?php
define("GREETING", "Welcome to W3School.com.cn!", true);
echo greeting;
?>


<?php//连接字符串
$a = "Hello";
$b = $a . " world!";
echo $b; // ?出 Hello world!

$x="Hello";
$x .= " world!";
echo $x; // ?出 Hello world!
?>

<?php
$t=date("H");

if ($t<"10") {
  echo "Have a good morning!";
} elseif ($t<"20") {
  echo "Have a good day!";
} else {
  echo "Have a good night!";
}
?>

<?php
switch ($x)
{
case 1:
  echo "Number 1";
  break;
case 2:
  echo "Number 2";
  break;
case 3:
  echo "Number 3";
  break;
default:
  echo "No number between 1 and 3";
}
?>

<?php 
$x=1; 

while($x<=5) {
  echo "这个数字是：$x <br>";
  $x++;
} 
?>
<?php 
$x=6;

do {
  echo "这个数字是：$x <br>";
  $x++;
} while ($x<=5);
?>

<?php 
for ($x=0; $x<=10; $x++) {
  echo "数字是：$x <br>";
} 
?>

<?php //foreach 数组
$colors = array("red","green","blue","yellow"); 

foreach ($colors as $value) {
  echo "$value <br>";
  if  strpos($number,$value) > 1
	$a_cnt++
}
?>


<?php//创建自定义函数
function setHeight($minheight=50) {
  echo "The height is : $minheight <br>";
}

setHeight(350);
setHeight(); // 将使用默认值 50
setHeight(135);
setHeight(80);
?>
<?php
function sum($x,$y) {
  $z=$x+$y;
  return $z;
}

echo "5 + 10 = " . sum(5,10) . "<br>";
echo "7 + 13 = " . sum(7,13) . "<br>";
echo "2 + 4 = " . sum(2,4);
?>

<?php//遍历数组
$cars=array("Volvo","BMW","SAAB");
$arrlength=count($cars);

for($x=0;$x<$arrlength;$x++) {
  echo $cars[$x];
  echo "<br>";
}
?>

<?php//关联数组
$age=array("Bill"=>"35","Steve"=>"37","Peter"=>"43");
echo "Peter is " . $age['Peter'] . " years old.";

foreach($age as $x=>$x_value) {
  echo "Key=" . $x . ", Value=" . $x_value;
  echo "<br>";
}
?>
